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

abstract class PostLike
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  PostLike._({
    this.id,
    required this.profileId,
    required this.postId,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory PostLike({
    int? id,
    required int profileId,
    required int postId,
    DateTime? createdAt,
  }) = _PostLikeImpl;

  factory PostLike.fromJson(Map<String, dynamic> jsonSerialization) {
    return PostLike(
      id: jsonSerialization['id'] as int?,
      profileId: jsonSerialization['profileId'] as int,
      postId: jsonSerialization['postId'] as int,
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

  int postId;

  DateTime createdAt;

  /// Returns a shallow copy of this [PostLike]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  PostLike copyWith({
    int? id,
    int? profileId,
    int? postId,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PostLike',
      if (id != null) 'id': id,
      'profileId': profileId,
      'postId': postId,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PostLike',
      if (id != null) 'id': id,
      'profileId': profileId,
      'postId': postId,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PostLikeImpl extends PostLike {
  _PostLikeImpl({
    int? id,
    required int profileId,
    required int postId,
    DateTime? createdAt,
  }) : super._(
         id: id,
         profileId: profileId,
         postId: postId,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [PostLike]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  PostLike copyWith({
    Object? id = _Undefined,
    int? profileId,
    int? postId,
    DateTime? createdAt,
  }) {
    return PostLike(
      id: id is int? ? id : this.id,
      profileId: profileId ?? this.profileId,
      postId: postId ?? this.postId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
