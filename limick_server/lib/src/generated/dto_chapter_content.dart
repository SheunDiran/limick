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

abstract class ChapterContent
    implements _is.SerializableModel, _is.ProtocolSerialization {
  ChapterContent._({
    required this.bookId,
    required this.position,
    required this.title,
    required this.text,
    required this.chapterCount,
  });

  factory ChapterContent({
    required int bookId,
    required int position,
    required String title,
    required String text,
    required int chapterCount,
  }) = _ChapterContentImpl;

  factory ChapterContent.fromJson(Map<String, dynamic> jsonSerialization) {
    return ChapterContent(
      bookId: jsonSerialization['bookId'] as int,
      position: jsonSerialization['position'] as int,
      title: jsonSerialization['title'] as String,
      text: jsonSerialization['text'] as String,
      chapterCount: jsonSerialization['chapterCount'] as int,
    );
  }

  int bookId;

  int position;

  String title;

  String text;

  int chapterCount;

  /// Returns a shallow copy of this [ChapterContent]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ChapterContent copyWith({
    int? bookId,
    int? position,
    String? title,
    String? text,
    int? chapterCount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ChapterContent',
      'bookId': bookId,
      'position': position,
      'title': title,
      'text': text,
      'chapterCount': chapterCount,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ChapterContent',
      'bookId': bookId,
      'position': position,
      'title': title,
      'text': text,
      'chapterCount': chapterCount,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _ChapterContentImpl extends ChapterContent {
  _ChapterContentImpl({
    required int bookId,
    required int position,
    required String title,
    required String text,
    required int chapterCount,
  }) : super._(
         bookId: bookId,
         position: position,
         title: title,
         text: text,
         chapterCount: chapterCount,
       );

  /// Returns a shallow copy of this [ChapterContent]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ChapterContent copyWith({
    int? bookId,
    int? position,
    String? title,
    String? text,
    int? chapterCount,
  }) {
    return ChapterContent(
      bookId: bookId ?? this.bookId,
      position: position ?? this.position,
      title: title ?? this.title,
      text: text ?? this.text,
      chapterCount: chapterCount ?? this.chapterCount,
    );
  }
}
