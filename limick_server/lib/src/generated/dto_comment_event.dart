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
import 'dto_comment_view.dart' as _i4xf9a43;
import 'live_event_type.dart' as _ijk6vck4;

/// Live update for an open comment thread.
abstract class CommentEvent
    implements _is.SerializableModel, _is.ProtocolSerialization {
  CommentEvent._({
    required this.type,
    required this.postId,
    this.comment,
    this.commentId,
    this.likeCount,
  });

  factory CommentEvent({
    required _ijk6vck4.LiveEventType type,
    required int postId,
    _i4xf9a43.CommentView? comment,
    int? commentId,
    int? likeCount,
  }) = _CommentEventImpl;

  factory CommentEvent.fromJson(Map<String, dynamic> jsonSerialization) {
    return CommentEvent(
      type: _ijk6vck4.LiveEventType.fromJson(
        (jsonSerialization['type'] as String),
      ),
      postId: jsonSerialization['postId'] as int,
      comment: jsonSerialization['comment'] == null
          ? null
          : _i8uqouhs.Protocol().deserialize<_i4xf9a43.CommentView>(
              jsonSerialization['comment'],
            ),
      commentId: jsonSerialization['commentId'] as int?,
      likeCount: jsonSerialization['likeCount'] as int?,
    );
  }

  _ijk6vck4.LiveEventType type;

  int postId;

  _i4xf9a43.CommentView? comment;

  int? commentId;

  int? likeCount;

  /// Returns a shallow copy of this [CommentEvent]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CommentEvent copyWith({
    _ijk6vck4.LiveEventType? type,
    int? postId,
    _i4xf9a43.CommentView? comment,
    int? commentId,
    int? likeCount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CommentEvent',
      'type': type.toJson(),
      'postId': postId,
      if (comment != null) 'comment': comment?.toJson(),
      if (commentId != null) 'commentId': commentId,
      if (likeCount != null) 'likeCount': likeCount,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CommentEvent',
      'type': type.toJson(),
      'postId': postId,
      if (comment != null) 'comment': comment?.toJsonForProtocol(),
      if (commentId != null) 'commentId': commentId,
      if (likeCount != null) 'likeCount': likeCount,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CommentEventImpl extends CommentEvent {
  _CommentEventImpl({
    required _ijk6vck4.LiveEventType type,
    required int postId,
    _i4xf9a43.CommentView? comment,
    int? commentId,
    int? likeCount,
  }) : super._(
         type: type,
         postId: postId,
         comment: comment,
         commentId: commentId,
         likeCount: likeCount,
       );

  /// Returns a shallow copy of this [CommentEvent]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  CommentEvent copyWith({
    _ijk6vck4.LiveEventType? type,
    int? postId,
    Object? comment = _Undefined,
    Object? commentId = _Undefined,
    Object? likeCount = _Undefined,
  }) {
    return CommentEvent(
      type: type ?? this.type,
      postId: postId ?? this.postId,
      comment: comment is _i4xf9a43.CommentView?
          ? comment
          : this.comment?.copyWith(),
      commentId: commentId is int? ? commentId : this.commentId,
      likeCount: likeCount is int? ? likeCount : this.likeCount,
    );
  }
}
