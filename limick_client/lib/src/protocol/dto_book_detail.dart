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
import 'book.dart' as _ik00prxe;
import 'dto_chapter_summary.dart' as _ipu481lu;
import 'reading_progress.dart' as _i2h1sfz6;

abstract class BookDetail
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  BookDetail._({
    required this.book,
    required this.following,
    this.progress,
    required this.chapters,
    this.roomId,
  });

  factory BookDetail({
    required _ik00prxe.Book book,
    required bool following,
    _i2h1sfz6.ReadingProgress? progress,
    required List<_ipu481lu.ChapterSummary> chapters,
    int? roomId,
  }) = _BookDetailImpl;

  factory BookDetail.fromJson(Map<String, dynamic> jsonSerialization) {
    return BookDetail(
      book: _i0imvg6w.Protocol().deserialize<_ik00prxe.Book>(
        jsonSerialization['book'],
      ),
      following: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['following'],
      ),
      progress: jsonSerialization['progress'] == null
          ? null
          : _i0imvg6w.Protocol().deserialize<_i2h1sfz6.ReadingProgress>(
              jsonSerialization['progress'],
            ),
      chapters: _i0imvg6w.Protocol()
          .deserialize<List<_ipu481lu.ChapterSummary>>(
            jsonSerialization['chapters'],
          ),
      roomId: jsonSerialization['roomId'] as int?,
    );
  }

  _ik00prxe.Book book;

  bool following;

  _i2h1sfz6.ReadingProgress? progress;

  List<_ipu481lu.ChapterSummary> chapters;

  int? roomId;

  /// Returns a shallow copy of this [BookDetail]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  BookDetail copyWith({
    _ik00prxe.Book? book,
    bool? following,
    _i2h1sfz6.ReadingProgress? progress,
    List<_ipu481lu.ChapterSummary>? chapters,
    int? roomId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BookDetail',
      'book': book.toJson(),
      'following': following,
      if (progress != null) 'progress': progress?.toJson(),
      'chapters': chapters.toJson(valueToJson: (v) => v.toJson()),
      if (roomId != null) 'roomId': roomId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'BookDetail',
      'book': book.toJsonForProtocol(),
      'following': following,
      if (progress != null) 'progress': progress?.toJsonForProtocol(),
      'chapters': chapters.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (roomId != null) 'roomId': roomId,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BookDetailImpl extends BookDetail {
  _BookDetailImpl({
    required _ik00prxe.Book book,
    required bool following,
    _i2h1sfz6.ReadingProgress? progress,
    required List<_ipu481lu.ChapterSummary> chapters,
    int? roomId,
  }) : super._(
         book: book,
         following: following,
         progress: progress,
         chapters: chapters,
         roomId: roomId,
       );

  /// Returns a shallow copy of this [BookDetail]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  BookDetail copyWith({
    _ik00prxe.Book? book,
    bool? following,
    Object? progress = _Undefined,
    List<_ipu481lu.ChapterSummary>? chapters,
    Object? roomId = _Undefined,
  }) {
    return BookDetail(
      book: book ?? this.book.copyWith(),
      following: following ?? this.following,
      progress: progress is _i2h1sfz6.ReadingProgress?
          ? progress
          : this.progress?.copyWith(),
      chapters: chapters ?? this.chapters.map((e0) => e0.copyWith()).toList(),
      roomId: roomId is int? ? roomId : this.roomId,
    );
  }
}
