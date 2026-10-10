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
import 'book.dart' as _ik00prxe;
import 'study_break.dart' as _i199zodz;

/// What the user learned during a study break.
abstract class BreakSummary
    implements _is.SerializableModel, _is.ProtocolSerialization {
  BreakSummary._({
    required this.studyBreak,
    required this.postsRead,
    required this.wordsSaved,
    required this.quizzesAnswered,
    required this.quizzesCorrect,
    required this.books,
    this.continueBook,
    this.continueChapter,
  });

  factory BreakSummary({
    required _i199zodz.StudyBreak studyBreak,
    required int postsRead,
    required int wordsSaved,
    required int quizzesAnswered,
    required int quizzesCorrect,
    required List<String> books,
    _ik00prxe.Book? continueBook,
    int? continueChapter,
  }) = _BreakSummaryImpl;

  factory BreakSummary.fromJson(Map<String, dynamic> jsonSerialization) {
    return BreakSummary(
      studyBreak: _i8uqouhs.Protocol().deserialize<_i199zodz.StudyBreak>(
        jsonSerialization['studyBreak'],
      ),
      postsRead: jsonSerialization['postsRead'] as int,
      wordsSaved: jsonSerialization['wordsSaved'] as int,
      quizzesAnswered: jsonSerialization['quizzesAnswered'] as int,
      quizzesCorrect: jsonSerialization['quizzesCorrect'] as int,
      books: _i8uqouhs.Protocol().deserialize<List<String>>(
        jsonSerialization['books'],
      ),
      continueBook: jsonSerialization['continueBook'] == null
          ? null
          : _i8uqouhs.Protocol().deserialize<_ik00prxe.Book>(
              jsonSerialization['continueBook'],
            ),
      continueChapter: jsonSerialization['continueChapter'] as int?,
    );
  }

  _i199zodz.StudyBreak studyBreak;

  int postsRead;

  int wordsSaved;

  int quizzesAnswered;

  int quizzesCorrect;

  List<String> books;

  _ik00prxe.Book? continueBook;

  int? continueChapter;

  /// Returns a shallow copy of this [BreakSummary]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  BreakSummary copyWith({
    _i199zodz.StudyBreak? studyBreak,
    int? postsRead,
    int? wordsSaved,
    int? quizzesAnswered,
    int? quizzesCorrect,
    List<String>? books,
    _ik00prxe.Book? continueBook,
    int? continueChapter,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BreakSummary',
      'studyBreak': studyBreak.toJson(),
      'postsRead': postsRead,
      'wordsSaved': wordsSaved,
      'quizzesAnswered': quizzesAnswered,
      'quizzesCorrect': quizzesCorrect,
      'books': books.toJson(),
      if (continueBook != null) 'continueBook': continueBook?.toJson(),
      if (continueChapter != null) 'continueChapter': continueChapter,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'BreakSummary',
      'studyBreak': studyBreak.toJsonForProtocol(),
      'postsRead': postsRead,
      'wordsSaved': wordsSaved,
      'quizzesAnswered': quizzesAnswered,
      'quizzesCorrect': quizzesCorrect,
      'books': books.toJson(),
      if (continueBook != null)
        'continueBook': continueBook?.toJsonForProtocol(),
      if (continueChapter != null) 'continueChapter': continueChapter,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BreakSummaryImpl extends BreakSummary {
  _BreakSummaryImpl({
    required _i199zodz.StudyBreak studyBreak,
    required int postsRead,
    required int wordsSaved,
    required int quizzesAnswered,
    required int quizzesCorrect,
    required List<String> books,
    _ik00prxe.Book? continueBook,
    int? continueChapter,
  }) : super._(
         studyBreak: studyBreak,
         postsRead: postsRead,
         wordsSaved: wordsSaved,
         quizzesAnswered: quizzesAnswered,
         quizzesCorrect: quizzesCorrect,
         books: books,
         continueBook: continueBook,
         continueChapter: continueChapter,
       );

  /// Returns a shallow copy of this [BreakSummary]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  BreakSummary copyWith({
    _i199zodz.StudyBreak? studyBreak,
    int? postsRead,
    int? wordsSaved,
    int? quizzesAnswered,
    int? quizzesCorrect,
    List<String>? books,
    Object? continueBook = _Undefined,
    Object? continueChapter = _Undefined,
  }) {
    return BreakSummary(
      studyBreak: studyBreak ?? this.studyBreak.copyWith(),
      postsRead: postsRead ?? this.postsRead,
      wordsSaved: wordsSaved ?? this.wordsSaved,
      quizzesAnswered: quizzesAnswered ?? this.quizzesAnswered,
      quizzesCorrect: quizzesCorrect ?? this.quizzesCorrect,
      books: books ?? this.books.map((e0) => e0).toList(),
      continueBook: continueBook is _ik00prxe.Book?
          ? continueBook
          : this.continueBook?.copyWith(),
      continueChapter: continueChapter is int?
          ? continueChapter
          : this.continueChapter,
    );
  }
}
