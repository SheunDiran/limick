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
import 'dto_author.dart' as _irki9rqm;
import 'dto_profile_stats.dart' as _iea09c12;

abstract class PublicProfile
    implements _is.SerializableModel, _is.ProtocolSerialization {
  PublicProfile._({
    required this.author,
    required this.bio,
    this.field,
    required this.stats,
    required this.isMe,
    bool? blocked,
  }) : blocked = blocked ?? false;

  factory PublicProfile({
    required _irki9rqm.Author author,
    required String bio,
    String? field,
    required _iea09c12.ProfileStats stats,
    required bool isMe,
    bool? blocked,
  }) = _PublicProfileImpl;

  factory PublicProfile.fromJson(Map<String, dynamic> jsonSerialization) {
    return PublicProfile(
      author: _i8uqouhs.Protocol().deserialize<_irki9rqm.Author>(
        jsonSerialization['author'],
      ),
      bio: jsonSerialization['bio'] as String,
      field: jsonSerialization['field'] as String?,
      stats: _i8uqouhs.Protocol().deserialize<_iea09c12.ProfileStats>(
        jsonSerialization['stats'],
      ),
      isMe: _is.BoolJsonExtension.fromJson(jsonSerialization['isMe']),
      blocked: jsonSerialization['blocked'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['blocked']),
    );
  }

  _irki9rqm.Author author;

  String bio;

  String? field;

  _iea09c12.ProfileStats stats;

  bool isMe;

  bool blocked;

  /// Returns a shallow copy of this [PublicProfile]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  PublicProfile copyWith({
    _irki9rqm.Author? author,
    String? bio,
    String? field,
    _iea09c12.ProfileStats? stats,
    bool? isMe,
    bool? blocked,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PublicProfile',
      'author': author.toJson(),
      'bio': bio,
      if (field != null) 'field': field,
      'stats': stats.toJson(),
      'isMe': isMe,
      'blocked': blocked,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PublicProfile',
      'author': author.toJsonForProtocol(),
      'bio': bio,
      if (field != null) 'field': field,
      'stats': stats.toJsonForProtocol(),
      'isMe': isMe,
      'blocked': blocked,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PublicProfileImpl extends PublicProfile {
  _PublicProfileImpl({
    required _irki9rqm.Author author,
    required String bio,
    String? field,
    required _iea09c12.ProfileStats stats,
    required bool isMe,
    bool? blocked,
  }) : super._(
         author: author,
         bio: bio,
         field: field,
         stats: stats,
         isMe: isMe,
         blocked: blocked,
       );

  /// Returns a shallow copy of this [PublicProfile]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  PublicProfile copyWith({
    _irki9rqm.Author? author,
    String? bio,
    Object? field = _Undefined,
    _iea09c12.ProfileStats? stats,
    bool? isMe,
    bool? blocked,
  }) {
    return PublicProfile(
      author: author ?? this.author.copyWith(),
      bio: bio ?? this.bio,
      field: field is String? ? field : this.field,
      stats: stats ?? this.stats.copyWith(),
      isMe: isMe ?? this.isMe,
      blocked: blocked ?? this.blocked,
    );
  }
}
