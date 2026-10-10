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

/// Which official posts a reader has already been shown.
abstract class OfficialSeen
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  OfficialSeen._({
    this.id,
    required this.profileId,
    required this.officialPostId,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory OfficialSeen({
    int? id,
    required int profileId,
    required int officialPostId,
    DateTime? createdAt,
  }) = _OfficialSeenImpl;

  factory OfficialSeen.fromJson(Map<String, dynamic> jsonSerialization) {
    return OfficialSeen(
      id: jsonSerialization['id'] as int?,
      profileId: jsonSerialization['profileId'] as int,
      officialPostId: jsonSerialization['officialPostId'] as int,
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

  int officialPostId;

  DateTime createdAt;

  /// Returns a shallow copy of this [OfficialSeen]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  OfficialSeen copyWith({
    int? id,
    int? profileId,
    int? officialPostId,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OfficialSeen',
      if (id != null) 'id': id,
      'profileId': profileId,
      'officialPostId': officialPostId,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'OfficialSeen',
      if (id != null) 'id': id,
      'profileId': profileId,
      'officialPostId': officialPostId,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OfficialSeenImpl extends OfficialSeen {
  _OfficialSeenImpl({
    int? id,
    required int profileId,
    required int officialPostId,
    DateTime? createdAt,
  }) : super._(
         id: id,
         profileId: profileId,
         officialPostId: officialPostId,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [OfficialSeen]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  OfficialSeen copyWith({
    Object? id = _Undefined,
    int? profileId,
    int? officialPostId,
    DateTime? createdAt,
  }) {
    return OfficialSeen(
      id: id is int? ? id : this.id,
      profileId: profileId ?? this.profileId,
      officialPostId: officialPostId ?? this.officialPostId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
