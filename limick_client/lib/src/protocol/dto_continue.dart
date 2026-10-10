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
import 'reading_progress.dart' as _i2h1sfz6;

/// A book the user has started, for the "continue reading" shelf.
abstract class ContinueReading
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ContinueReading._({
    required this.book,
    required this.progress,
    required this.chapterTitle,
  });

  factory ContinueReading({
    required _ik00prxe.Book book,
    required _i2h1sfz6.ReadingProgress progress,
    required String chapterTitle,
  }) = _ContinueReadingImpl;

  factory ContinueReading.fromJson(Map<String, dynamic> jsonSerialization) {
    return ContinueReading(
      book: _i0imvg6w.Protocol().deserialize<_ik00prxe.Book>(
        jsonSerialization['book'],
      ),
      progress: _i0imvg6w.Protocol().deserialize<_i2h1sfz6.ReadingProgress>(
        jsonSerialization['progress'],
      ),
      chapterTitle: jsonSerialization['chapterTitle'] as String,
    );
  }

  _ik00prxe.Book book;

  _i2h1sfz6.ReadingProgress progress;

  String chapterTitle;

  /// Returns a shallow copy of this [ContinueReading]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ContinueReading copyWith({
    _ik00prxe.Book? book,
    _i2h1sfz6.ReadingProgress? progress,
    String? chapterTitle,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ContinueReading',
      'book': book.toJson(),
      'progress': progress.toJson(),
      'chapterTitle': chapterTitle,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ContinueReading',
      'book': book.toJsonForProtocol(),
      'progress': progress.toJsonForProtocol(),
      'chapterTitle': chapterTitle,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _ContinueReadingImpl extends ContinueReading {
  _ContinueReadingImpl({
    required _ik00prxe.Book book,
    required _i2h1sfz6.ReadingProgress progress,
    required String chapterTitle,
  }) : super._(
         book: book,
         progress: progress,
         chapterTitle: chapterTitle,
       );

  /// Returns a shallow copy of this [ContinueReading]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ContinueReading copyWith({
    _ik00prxe.Book? book,
    _i2h1sfz6.ReadingProgress? progress,
    String? chapterTitle,
  }) {
    return ContinueReading(
      book: book ?? this.book.copyWith(),
      progress: progress ?? this.progress.copyWith(),
      chapterTitle: chapterTitle ?? this.chapterTitle,
    );
  }
}
