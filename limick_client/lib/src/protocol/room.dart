/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'topic.dart' as _iro94j51;

/// A public chat room, either for a topic or for a single book (book club).
abstract class Room
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Room._({
    this.id,
    required this.slug,
    required this.name,
    required this.description,
    this.topic,
    this.bookId,
    int? memberCount,
    int? messageCount,
    this.lastMessageAt,
    DateTime? createdAt,
  }) : memberCount = memberCount ?? 0,
       messageCount = messageCount ?? 0,
       createdAt = createdAt ?? DateTime.now();

  factory Room({
    int? id,
    required String slug,
    required String name,
    required String description,
    _iro94j51.Topic? topic,
    int? bookId,
    int? memberCount,
    int? messageCount,
    DateTime? lastMessageAt,
    DateTime? createdAt,
  }) = _RoomImpl;

  factory Room.fromJson(Map<String, dynamic> jsonSerialization) {
    return Room(
      id: jsonSerialization['id'] as int?,
      slug: jsonSerialization['slug'] as String,
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String,
      topic: jsonSerialization['topic'] == null
          ? null
          : _iro94j51.Topic.fromJson((jsonSerialization['topic'] as String)),
      bookId: jsonSerialization['bookId'] as int?,
      memberCount: jsonSerialization['memberCount'] as int?,
      messageCount: jsonSerialization['messageCount'] as int?,
      lastMessageAt: jsonSerialization['lastMessageAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastMessageAt'],
            ),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String slug;

  String name;

  String description;

  _iro94j51.Topic? topic;

  int? bookId;

  int memberCount;

  int messageCount;

  DateTime? lastMessageAt;

  DateTime createdAt;

  /// Returns a shallow copy of this [Room]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Room copyWith({
    int? id,
    String? slug,
    String? name,
    String? description,
    _iro94j51.Topic? topic,
    int? bookId,
    int? memberCount,
    int? messageCount,
    DateTime? lastMessageAt,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Room',
      if (id != null) 'id': id,
      'slug': slug,
      'name': name,
      'description': description,
      if (topic != null) 'topic': topic?.toJson(),
      if (bookId != null) 'bookId': bookId,
      'memberCount': memberCount,
      'messageCount': messageCount,
      if (lastMessageAt != null) 'lastMessageAt': lastMessageAt?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Room',
      if (id != null) 'id': id,
      'slug': slug,
      'name': name,
      'description': description,
      if (topic != null) 'topic': topic?.toJson(),
      if (bookId != null) 'bookId': bookId,
      'memberCount': memberCount,
      'messageCount': messageCount,
      if (lastMessageAt != null) 'lastMessageAt': lastMessageAt?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RoomImpl extends Room {
  _RoomImpl({
    int? id,
    required String slug,
    required String name,
    required String description,
    _iro94j51.Topic? topic,
    int? bookId,
    int? memberCount,
    int? messageCount,
    DateTime? lastMessageAt,
    DateTime? createdAt,
  }) : super._(
         id: id,
         slug: slug,
         name: name,
         description: description,
         topic: topic,
         bookId: bookId,
         memberCount: memberCount,
         messageCount: messageCount,
         lastMessageAt: lastMessageAt,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Room]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Room copyWith({
    Object? id = _Undefined,
    String? slug,
    String? name,
    String? description,
    Object? topic = _Undefined,
    Object? bookId = _Undefined,
    int? memberCount,
    int? messageCount,
    Object? lastMessageAt = _Undefined,
    DateTime? createdAt,
  }) {
    return Room(
      id: id is int? ? id : this.id,
      slug: slug ?? this.slug,
      name: name ?? this.name,
      description: description ?? this.description,
      topic: topic is _iro94j51.Topic? ? topic : this.topic,
      bookId: bookId is int? ? bookId : this.bookId,
      memberCount: memberCount ?? this.memberCount,
      messageCount: messageCount ?? this.messageCount,
      lastMessageAt: lastMessageAt is DateTime?
          ? lastMessageAt
          : this.lastMessageAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
