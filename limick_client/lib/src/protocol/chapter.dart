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

/// A chapter of an ingested book. [text] is reflowed: paragraphs are
/// separated by a blank line, so character offsets are stable.
abstract class Chapter
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Chapter._({
    this.id,
    required this.bookId,
    required this.position,
    required this.title,
    required this.wordCount,
    required this.text,
  });

  factory Chapter({
    int? id,
    required int bookId,
    required int position,
    required String title,
    required int wordCount,
    required String text,
  }) = _ChapterImpl;

  factory Chapter.fromJson(Map<String, dynamic> jsonSerialization) {
    return Chapter(
      id: jsonSerialization['id'] as int?,
      bookId: jsonSerialization['bookId'] as int,
      position: jsonSerialization['position'] as int,
      title: jsonSerialization['title'] as String,
      wordCount: jsonSerialization['wordCount'] as int,
      text: jsonSerialization['text'] as String,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int bookId;

  int position;

  String title;

  int wordCount;

  String text;

  /// Returns a shallow copy of this [Chapter]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Chapter copyWith({
    int? id,
    int? bookId,
    int? position,
    String? title,
    int? wordCount,
    String? text,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Chapter',
      if (id != null) 'id': id,
      'bookId': bookId,
      'position': position,
      'title': title,
      'wordCount': wordCount,
      'text': text,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Chapter',
      if (id != null) 'id': id,
      'bookId': bookId,
      'position': position,
      'title': title,
      'wordCount': wordCount,
      'text': text,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ChapterImpl extends Chapter {
  _ChapterImpl({
    int? id,
    required int bookId,
    required int position,
    required String title,
    required int wordCount,
    required String text,
  }) : super._(
         id: id,
         bookId: bookId,
         position: position,
         title: title,
         wordCount: wordCount,
         text: text,
       );

  /// Returns a shallow copy of this [Chapter]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Chapter copyWith({
    Object? id = _Undefined,
    int? bookId,
    int? position,
    String? title,
    int? wordCount,
    String? text,
  }) {
    return Chapter(
      id: id is int? ? id : this.id,
      bookId: bookId ?? this.bookId,
      position: position ?? this.position,
      title: title ?? this.title,
      wordCount: wordCount ?? this.wordCount,
      text: text ?? this.text,
    );
  }
}
