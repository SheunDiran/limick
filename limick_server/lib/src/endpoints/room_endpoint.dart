import 'dart:async';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../util/current_profile.dart';
import '../util/text.dart';

/// Public rooms: one per topic, plus a book club per book. Real time via
/// Serverpod streams.
class RoomEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  static String channel(int roomId) => 'room-$roomId';

  /// Live connection counts per room on this server.
  static final Map<int, int> _online = {};

  Future<List<RoomView>> list(Session session) async {
    final profile = await currentProfile(session);
    final memberships = {
      for (final m in await RoomMember.db.find(
        session,
        where: (t) => t.profileId.equals(profile.id!),
      ))
        m.roomId: m,
    };
    final rooms = await Room.db.find(
      session,
      where: (t) =>
          t.topic.notEquals(null) | t.id.inSet(memberships.keys.toSet()),
      orderBy: (t) => t.lastMessageAt.desc(),
    );
    final views = <RoomView>[];
    for (final room in rooms) {
      views.add(await _view(session, room, memberships[room.id]));
    }
    views.sort((a, b) {
      if (a.joined != b.joined) return a.joined ? -1 : 1;
      final at = a.room.lastMessageAt ?? a.room.createdAt;
      final bt = b.room.lastMessageAt ?? b.room.createdAt;
      return bt.compareTo(at);
    });
    return views;
  }

  Future<RoomView> get(Session session, int roomId) async {
    final profile = await currentProfile(session);
    final room = await _room(session, roomId);
    final member = await _membership(session, profile.id!, roomId);
    return _view(session, room, member);
  }

  /// The book club for a book, created the first time someone opens it.
  Future<RoomView> forBook(Session session, int bookId) async {
    final profile = await currentProfile(session);
    var room = await Room.db.findFirstRow(
      session,
      where: (t) => t.bookId.equals(bookId),
    );
    if (room == null) {
      final book = await Book.db.findById(session, bookId);
      if (book == null) {
        throw AppException(message: 'Book not found.', code: 'not_found');
      }
      try {
        room = await Room.db.insertRow(
          session,
          Room(
            slug: 'book-${book.id}',
            name: book.title.length > 60
                ? '${book.title.substring(0, 57)}...'
                : book.title,
            description: 'Book club for ${book.title} by ${book.author}.',
            bookId: book.id,
          ),
        );
      } on DatabaseException {
        // Someone created it at the same moment.
        room = await Room.db.findFirstRow(
          session,
          where: (t) => t.bookId.equals(bookId),
        );
      }
    }
    final member = await _membership(session, profile.id!, room!.id!);
    return _view(session, room, member);
  }

  Future<RoomView> setJoined(Session session, int roomId, bool joined) async {
    final profile = await currentProfile(session);
    final room = await _room(session, roomId);
    var member = await _membership(session, profile.id!, roomId);
    if (joined && member == null) {
      member = await RoomMember.db.insertRow(
        session,
        RoomMember(profileId: profile.id!, roomId: roomId),
      );
      await session.db.unsafeExecute(
        'UPDATE room SET "memberCount" = "memberCount" + 1 WHERE id = $roomId',
      );
    } else if (!joined && member != null) {
      await RoomMember.db.deleteRow(session, member);
      member = null;
      await session.db.unsafeExecute(
        'UPDATE room SET "memberCount" = GREATEST("memberCount" - 1, 0) WHERE id = $roomId',
      );
    }
    return _view(
      session,
      (await Room.db.findById(session, roomId)) ?? room,
      member,
    );
  }

  /// Messages, newest first. Opening the latest page marks the room read.
  Future<List<RoomMessageView>> messages(
    Session session,
    int roomId,
    int? beforeId,
  ) async {
    final profile = await currentProfile(session);
    await _room(session, roomId);
    final blocked = await blockedIds(session, profile.id!);
    final rows = await RoomMessage.db.find(
      session,
      where: (t) =>
          t.roomId.equals(roomId) &
          t.deleted.equals(false) &
          (beforeId == null ? Constant.bool(true) : t.id < beforeId),
      orderBy: (t) => t.id.desc(),
      limit: 50,
    );
    if (beforeId == null) await markRead(session, roomId);
    final visible = rows.where((m) => !blocked.contains(m.profileId)).toList();
    final authors = {
      for (final p in await Reader.db.find(
        session,
        where: (t) => t.id.inSet(visible.map((m) => m.profileId).toSet()),
      ))
        p.id!: authorOf(p),
    };
    return [
      for (final m in visible)
        if (authors[m.profileId] != null)
          RoomMessageView(message: m, author: authors[m.profileId]!),
    ];
  }

  Future<RoomMessageView> send(Session session, int roomId, String body) async {
    final profile = await currentProfile(session);
    final text = maskProfanity(cleanUserText(body, maxLength: 800));
    if (text.isEmpty) {
      throw AppException(message: 'Write something first.', code: 'invalid');
    }
    await rateLimit(
      session,
      action: 'room',
      profileId: profile.id!,
      window: const Duration(milliseconds: 800),
    );
    await _room(session, roomId);
    if (await _membership(session, profile.id!, roomId) == null) {
      await setJoined(session, roomId, true);
    }
    final message = await RoomMessage.db.insertRow(
      session,
      RoomMessage(roomId: roomId, profileId: profile.id!, body: text),
    );
    await session.db.unsafeExecute(
      'UPDATE room SET "messageCount" = "messageCount" + 1, "lastMessageAt" = NOW() WHERE id = $roomId',
    );
    await markRead(session, roomId);
    final view = RoomMessageView(message: message, author: authorOf(profile));
    await session.messages.postMessage(
      channel(roomId),
      RoomEvent(type: LiveEventType.added, roomId: roomId, message: view),
    );
    return view;
  }

  Future<void> delete(Session session, int messageId) async {
    final profile = await currentProfile(session);
    final message = await RoomMessage.db.findById(session, messageId);
    if (message == null) return;
    if (message.profileId != profile.id) {
      throw AppException(
        message: 'You can only delete your own messages.',
        code: 'forbidden',
      );
    }
    await RoomMessage.db.updateRow(
      session,
      message.copyWith(deleted: true, body: ''),
    );
    await session.messages.postMessage(
      channel(message.roomId),
      RoomEvent(
        type: LiveEventType.deleted,
        roomId: message.roomId,
        messageId: messageId,
      ),
    );
  }

  Future<void> markRead(Session session, int roomId) async {
    final profile = await currentProfile(session);
    final member = await _membership(session, profile.id!, roomId);
    if (member != null) {
      await RoomMember.db.updateRow(
        session,
        member.copyWith(lastReadAt: DateTime.now()),
      );
    }
  }

  /// Live room events. Counts this connection as "online" while it is open.
  Stream<RoomEvent> live(Session session, int roomId) async* {
    final profile = await currentProfile(session);
    await _room(session, roomId);
    final blocked = await blockedIds(session, profile.id!);
    final updates = session.messages.createStream<RoomEvent>(channel(roomId));

    _online[roomId] = (_online[roomId] ?? 0) + 1;
    _broadcastPresence(session, roomId);
    try {
      yield RoomEvent(
        type: LiveEventType.presence,
        roomId: roomId,
        onlineCount: _online[roomId],
      );
      await for (final event in updates) {
        final author = event.message?.author.id;
        if (author != null && blocked.contains(author)) continue;
        yield event;
      }
    } finally {
      _online[roomId] = ((_online[roomId] ?? 1) - 1).clamp(0, 1 << 30);
      _broadcastPresence(session, roomId);
    }
  }

  void _broadcastPresence(Session session, int roomId) {
    try {
      unawaited(
        session.messages
            .postMessage(
              channel(roomId),
              RoomEvent(
                type: LiveEventType.presence,
                roomId: roomId,
                onlineCount: _online[roomId] ?? 0,
              ),
            )
            .catchError((_) => false),
      );
    } catch (_) {
      // The session may already be closing when a client disconnects.
    }
  }

  static Future<Room> _room(Session session, int roomId) async {
    final room = await Room.db.findById(session, roomId);
    if (room == null) {
      throw AppException(
        message: 'This room no longer exists.',
        code: 'not_found',
      );
    }
    return room;
  }

  static Future<RoomMember?> _membership(
    Session session,
    int profileId,
    int roomId,
  ) => RoomMember.db.findFirstRow(
    session,
    where: (t) => t.profileId.equals(profileId) & t.roomId.equals(roomId),
  );

  static Future<RoomView> _view(
    Session session,
    Room room,
    RoomMember? member,
  ) async {
    var unread = 0;
    if (member != null) {
      unread = await RoomMessage.db.count(
        session,
        where: (t) =>
            t.roomId.equals(room.id!) &
            t.deleted.equals(false) &
            (t.createdAt > member.lastReadAt) &
            t.profileId.notEquals(member.profileId),
      );
    }
    final last = await RoomMessage.db.findFirstRow(
      session,
      where: (t) => t.roomId.equals(room.id!) & t.deleted.equals(false),
      orderBy: (t) => t.id.desc(),
    );
    return RoomView(
      room: room,
      joined: member != null,
      unread: unread,
      onlineCount: _online[room.id] ?? 0,
      lastMessage: last?.body,
    );
  }
}
