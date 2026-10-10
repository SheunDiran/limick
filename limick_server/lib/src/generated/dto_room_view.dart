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
import 'package:limick_server/src/generated/protocol.dart' as _i8uqouhs;
import 'package:serverpod/serverpod.dart' as _is;
import 'room.dart' as _ieflxecy;

abstract class RoomView
    implements _is.SerializableModel, _is.ProtocolSerialization {
  RoomView._({
    required this.room,
    required this.joined,
    int? unread,
    int? onlineCount,
    this.lastMessage,
  }) : unread = unread ?? 0,
       onlineCount = onlineCount ?? 0;

  factory RoomView({
    required _ieflxecy.Room room,
    required bool joined,
    int? unread,
    int? onlineCount,
    String? lastMessage,
  }) = _RoomViewImpl;

  factory RoomView.fromJson(Map<String, dynamic> jsonSerialization) {
    return RoomView(
      room: _i8uqouhs.Protocol().deserialize<_ieflxecy.Room>(
        jsonSerialization['room'],
      ),
      joined: _is.BoolJsonExtension.fromJson(jsonSerialization['joined']),
      unread: jsonSerialization['unread'] as int?,
      onlineCount: jsonSerialization['onlineCount'] as int?,
      lastMessage: jsonSerialization['lastMessage'] as String?,
    );
  }

  _ieflxecy.Room room;

  bool joined;

  int unread;

  int onlineCount;

  String? lastMessage;

  /// Returns a shallow copy of this [RoomView]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  RoomView copyWith({
    _ieflxecy.Room? room,
    bool? joined,
    int? unread,
    int? onlineCount,
    String? lastMessage,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RoomView',
      'room': room.toJson(),
      'joined': joined,
      'unread': unread,
      'onlineCount': onlineCount,
      if (lastMessage != null) 'lastMessage': lastMessage,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RoomView',
      'room': room.toJsonForProtocol(),
      'joined': joined,
      'unread': unread,
      'onlineCount': onlineCount,
      if (lastMessage != null) 'lastMessage': lastMessage,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RoomViewImpl extends RoomView {
  _RoomViewImpl({
    required _ieflxecy.Room room,
    required bool joined,
    int? unread,
    int? onlineCount,
    String? lastMessage,
  }) : super._(
         room: room,
         joined: joined,
         unread: unread,
         onlineCount: onlineCount,
         lastMessage: lastMessage,
       );

  /// Returns a shallow copy of this [RoomView]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  RoomView copyWith({
    _ieflxecy.Room? room,
    bool? joined,
    int? unread,
    int? onlineCount,
    Object? lastMessage = _Undefined,
  }) {
    return RoomView(
      room: room ?? this.room.copyWith(),
      joined: joined ?? this.joined,
      unread: unread ?? this.unread,
      onlineCount: onlineCount ?? this.onlineCount,
      lastMessage: lastMessage is String? ? lastMessage : this.lastMessage,
    );
  }
}
