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

abstract class Comment
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Comment._({
    this.id,
    required this.postId,
    required this.profileId,
    this.parentId,
    required this.body,
    this.asBookId,
    int? likeCount,
    int? replyCount,
    bool? deleted,
    DateTime? createdAt,
  }) : likeCount = likeCount ?? 0,
       replyCount = replyCount ?? 0,
       deleted = deleted ?? false,
       createdAt = createdAt ?? DateTime.now();

  factory Comment({
    int? id,
    required int postId,
    required int profileId,
    int? parentId,
    required String body,
    int? asBookId,
    int? likeCount,
    int? replyCount,
    bool? deleted,
    DateTime? createdAt,
  }) = _CommentImpl;

  factory Comment.fromJson(Map<String, dynamic> jsonSerialization) {
    return Comment(
      id: jsonSerialization['id'] as int?,
      postId: jsonSerialization['postId'] as int,
      profileId: jsonSerialization['profileId'] as int,
      parentId: jsonSerialization['parentId'] as int?,
      body: jsonSerialization['body'] as String,
      asBookId: jsonSerialization['asBookId'] as int?,
      likeCount: jsonSerialization['likeCount'] as int?,
      replyCount: jsonSerialization['replyCount'] as int?,
      deleted: jsonSerialization['deleted'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['deleted']),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int postId;

  int profileId;

  int? parentId;

  String body;

  /// Set when a book account replied (AI, grounded in the passage). The
  /// comment is stored under the official account.
  int? asBookId;

  int likeCount;

  int replyCount;

  bool deleted;

  DateTime createdAt;

  /// Returns a shallow copy of this [Comment]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Comment copyWith({
    int? id,
    int? postId,
    int? profileId,
    int? parentId,
    String? body,
    int? asBookId,
    int? likeCount,
    int? replyCount,
    bool? deleted,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Comment',
      if (id != null) 'id': id,
      'postId': postId,
      'profileId': profileId,
      if (parentId != null) 'parentId': parentId,
      'body': body,
      if (asBookId != null) 'asBookId': asBookId,
      'likeCount': likeCount,
      'replyCount': replyCount,
      'deleted': deleted,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Comment',
      if (id != null) 'id': id,
      'postId': postId,
      'profileId': profileId,
      if (parentId != null) 'parentId': parentId,
      'body': body,
      if (asBookId != null) 'asBookId': asBookId,
      'likeCount': likeCount,
      'replyCount': replyCount,
      'deleted': deleted,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CommentImpl extends Comment {
  _CommentImpl({
    int? id,
    required int postId,
    required int profileId,
    int? parentId,
    required String body,
    int? asBookId,
    int? likeCount,
    int? replyCount,
    bool? deleted,
    DateTime? createdAt,
  }) : super._(
         id: id,
         postId: postId,
         profileId: profileId,
         parentId: parentId,
         body: body,
         asBookId: asBookId,
         likeCount: likeCount,
         replyCount: replyCount,
         deleted: deleted,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Comment]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Comment copyWith({
    Object? id = _Undefined,
    int? postId,
    int? profileId,
    Object? parentId = _Undefined,
    String? body,
    Object? asBookId = _Undefined,
    int? likeCount,
    int? replyCount,
    bool? deleted,
    DateTime? createdAt,
  }) {
    return Comment(
      id: id is int? ? id : this.id,
      postId: postId ?? this.postId,
      profileId: profileId ?? this.profileId,
      parentId: parentId is int? ? parentId : this.parentId,
      body: body ?? this.body,
      asBookId: asBookId is int? ? asBookId : this.asBookId,
      likeCount: likeCount ?? this.likeCount,
      replyCount: replyCount ?? this.replyCount,
      deleted: deleted ?? this.deleted,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
