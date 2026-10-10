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

abstract class RoomMember
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  RoomMember._({
    this.id,
    required this.profileId,
    required this.roomId,
    DateTime? lastReadAt,
    DateTime? createdAt,
  }) : lastReadAt = lastReadAt ?? DateTime.now(),
       createdAt = createdAt ?? DateTime.now();

  factory RoomMember({
    int? id,
    required int profileId,
    required int roomId,
    DateTime? lastReadAt,
    DateTime? createdAt,
  }) = _RoomMemberImpl;

  factory RoomMember.fromJson(Map<String, dynamic> jsonSerialization) {
    return RoomMember(
      id: jsonSerialization['id'] as int?,
      profileId: jsonSerialization['profileId'] as int,
      roomId: jsonSerialization['roomId'] as int,
      lastReadAt: jsonSerialization['lastReadAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastReadAt'],
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

  int profileId;

  int roomId;

  DateTime lastReadAt;

  DateTime createdAt;

  /// Returns a shallow copy of this [RoomMember]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  RoomMember copyWith({
    int? id,
    int? profileId,
    int? roomId,
    DateTime? lastReadAt,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RoomMember',
      if (id != null) 'id': id,
      'profileId': profileId,
      'roomId': roomId,
      'lastReadAt': lastReadAt.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RoomMember',
      if (id != null) 'id': id,
      'profileId': profileId,
      'roomId': roomId,
      'lastReadAt': lastReadAt.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RoomMemberImpl extends RoomMember {
  _RoomMemberImpl({
    int? id,
    required int profileId,
    required int roomId,
    DateTime? lastReadAt,
    DateTime? createdAt,
  }) : super._(
         id: id,
         profileId: profileId,
         roomId: roomId,
         lastReadAt: lastReadAt,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [RoomMember]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  RoomMember copyWith({
    Object? id = _Undefined,
    int? profileId,
    int? roomId,
    DateTime? lastReadAt,
    DateTime? createdAt,
  }) {
    return RoomMember(
      id: id is int? ? id : this.id,
      profileId: profileId ?? this.profileId,
      roomId: roomId ?? this.roomId,
      lastReadAt: lastReadAt ?? this.lastReadAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
