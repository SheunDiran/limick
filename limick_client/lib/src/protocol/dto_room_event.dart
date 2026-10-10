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
import 'package:limick_client/src/protocol/protocol.dart' as _i0imvg6w;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'dto_room_message_view.dart' as _idb2b7gg;
import 'live_event_type.dart' as _ijk6vck4;

/// Live update for an open room.
abstract class RoomEvent
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  RoomEvent._({
    required this.type,
    required this.roomId,
    this.message,
    this.messageId,
    this.onlineCount,
  });

  factory RoomEvent({
    required _ijk6vck4.LiveEventType type,
    required int roomId,
    _idb2b7gg.RoomMessageView? message,
    int? messageId,
    int? onlineCount,
  }) = _RoomEventImpl;

  factory RoomEvent.fromJson(Map<String, dynamic> jsonSerialization) {
    return RoomEvent(
      type: _ijk6vck4.LiveEventType.fromJson(
        (jsonSerialization['type'] as String),
      ),
      roomId: jsonSerialization['roomId'] as int,
      message: jsonSerialization['message'] == null
          ? null
          : _i0imvg6w.Protocol().deserialize<_idb2b7gg.RoomMessageView>(
              jsonSerialization['message'],
            ),
      messageId: jsonSerialization['messageId'] as int?,
      onlineCount: jsonSerialization['onlineCount'] as int?,
    );
  }

  _ijk6vck4.LiveEventType type;

  int roomId;

  _idb2b7gg.RoomMessageView? message;

  int? messageId;

  int? onlineCount;

  /// Returns a shallow copy of this [RoomEvent]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  RoomEvent copyWith({
    _ijk6vck4.LiveEventType? type,
    int? roomId,
    _idb2b7gg.RoomMessageView? message,
    int? messageId,
    int? onlineCount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RoomEvent',
      'type': type.toJson(),
      'roomId': roomId,
      if (message != null) 'message': message?.toJson(),
      if (messageId != null) 'messageId': messageId,
      if (onlineCount != null) 'onlineCount': onlineCount,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RoomEvent',
      'type': type.toJson(),
      'roomId': roomId,
      if (message != null) 'message': message?.toJsonForProtocol(),
      if (messageId != null) 'messageId': messageId,
      if (onlineCount != null) 'onlineCount': onlineCount,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RoomEventImpl extends RoomEvent {
  _RoomEventImpl({
    required _ijk6vck4.LiveEventType type,
    required int roomId,
    _idb2b7gg.RoomMessageView? message,
    int? messageId,
    int? onlineCount,
  }) : super._(
         type: type,
         roomId: roomId,
         message: message,
         messageId: messageId,
         onlineCount: onlineCount,
       );

  /// Returns a shallow copy of this [RoomEvent]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  RoomEvent copyWith({
    _ijk6vck4.LiveEventType? type,
    int? roomId,
    Object? message = _Undefined,
    Object? messageId = _Undefined,
    Object? onlineCount = _Undefined,
  }) {
    return RoomEvent(
      type: type ?? this.type,
      roomId: roomId ?? this.roomId,
      message: message is _idb2b7gg.RoomMessageView?
          ? message
          : this.message?.copyWith(),
      messageId: messageId is int? ? messageId : this.messageId,
      onlineCount: onlineCount is int? ? onlineCount : this.onlineCount,
    );
  }
}
