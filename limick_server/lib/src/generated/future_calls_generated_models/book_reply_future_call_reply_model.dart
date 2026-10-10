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
import 'package:serverpod/serverpod.dart' as _is;

abstract class BookReplyFutureCallReplyModel
    implements _is.SerializableModel, _is.ProtocolSerialization {
  BookReplyFutureCallReplyModel._({required this.commentId});

  factory BookReplyFutureCallReplyModel({required int commentId}) =
      _BookReplyFutureCallReplyModelImpl;

  factory BookReplyFutureCallReplyModel.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return BookReplyFutureCallReplyModel(
      commentId: jsonSerialization['commentId'] as int,
    );
  }

  int commentId;

  /// Returns a shallow copy of this [BookReplyFutureCallReplyModel]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  BookReplyFutureCallReplyModel copyWith({int? commentId});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BookReplyFutureCallReplyModel',
      'commentId': commentId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _BookReplyFutureCallReplyModelImpl extends BookReplyFutureCallReplyModel {
  _BookReplyFutureCallReplyModelImpl({required int commentId})
    : super._(commentId: commentId);

  /// Returns a shallow copy of this [BookReplyFutureCallReplyModel]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  BookReplyFutureCallReplyModel copyWith({int? commentId}) {
    return BookReplyFutureCallReplyModel(
      commentId: commentId ?? this.commentId,
    );
  }
}
