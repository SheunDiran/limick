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

abstract class ChapterSummary
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ChapterSummary._({
    required this.position,
    required this.title,
    required this.wordCount,
  });

  factory ChapterSummary({
    required int position,
    required String title,
    required int wordCount,
  }) = _ChapterSummaryImpl;

  factory ChapterSummary.fromJson(Map<String, dynamic> jsonSerialization) {
    return ChapterSummary(
      position: jsonSerialization['position'] as int,
      title: jsonSerialization['title'] as String,
      wordCount: jsonSerialization['wordCount'] as int,
    );
  }

  int position;

  String title;

  int wordCount;

  /// Returns a shallow copy of this [ChapterSummary]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ChapterSummary copyWith({
    int? position,
    String? title,
    int? wordCount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ChapterSummary',
      'position': position,
      'title': title,
      'wordCount': wordCount,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ChapterSummary',
      'position': position,
      'title': title,
      'wordCount': wordCount,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _ChapterSummaryImpl extends ChapterSummary {
  _ChapterSummaryImpl({
    required int position,
    required String title,
    required int wordCount,
  }) : super._(
         position: position,
         title: title,
         wordCount: wordCount,
       );

  /// Returns a shallow copy of this [ChapterSummary]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ChapterSummary copyWith({
    int? position,
    String? title,
    int? wordCount,
  }) {
    return ChapterSummary(
      position: position ?? this.position,
      title: title ?? this.title,
      wordCount: wordCount ?? this.wordCount,
    );
  }
}
