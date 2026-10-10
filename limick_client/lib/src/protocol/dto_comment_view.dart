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
import 'comment.dart' as _i4ch5xwb;
import 'dto_author.dart' as _irki9rqm;

abstract class CommentView
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  CommentView._({
    required this.comment,
    required this.author,
    bool? likedByMe,
  }) : likedByMe = likedByMe ?? false;

  factory CommentView({
    required _i4ch5xwb.Comment comment,
    required _irki9rqm.Author author,
    bool? likedByMe,
  }) = _CommentViewImpl;

  factory CommentView.fromJson(Map<String, dynamic> jsonSerialization) {
    return CommentView(
      comment: _i0imvg6w.Protocol().deserialize<_i4ch5xwb.Comment>(
        jsonSerialization['comment'],
      ),
      author: _i0imvg6w.Protocol().deserialize<_irki9rqm.Author>(
        jsonSerialization['author'],
      ),
      likedByMe: jsonSerialization['likedByMe'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['likedByMe']),
    );
  }

  _i4ch5xwb.Comment comment;

  _irki9rqm.Author author;

  bool likedByMe;

  /// Returns a shallow copy of this [CommentView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  CommentView copyWith({
    _i4ch5xwb.Comment? comment,
    _irki9rqm.Author? author,
    bool? likedByMe,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CommentView',
      'comment': comment.toJson(),
      'author': author.toJson(),
      'likedByMe': likedByMe,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CommentView',
      'comment': comment.toJsonForProtocol(),
      'author': author.toJsonForProtocol(),
      'likedByMe': likedByMe,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _CommentViewImpl extends CommentView {
  _CommentViewImpl({
    required _i4ch5xwb.Comment comment,
    required _irki9rqm.Author author,
    bool? likedByMe,
  }) : super._(
         comment: comment,
         author: author,
         likedByMe: likedByMe,
       );

  /// Returns a shallow copy of this [CommentView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  CommentView copyWith({
    _i4ch5xwb.Comment? comment,
    _irki9rqm.Author? author,
    bool? likedByMe,
  }) {
    return CommentView(
      comment: comment ?? this.comment.copyWith(),
      author: author ?? this.author.copyWith(),
      likedByMe: likedByMe ?? this.likedByMe,
    );
  }
}
