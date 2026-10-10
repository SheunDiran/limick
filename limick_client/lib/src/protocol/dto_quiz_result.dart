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

abstract class QuizResult
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  QuizResult._({
    required this.correct,
    required this.correctIndex,
    required this.explanation,
    required this.answerCount,
  });

  factory QuizResult({
    required bool correct,
    required int correctIndex,
    required String explanation,
    required int answerCount,
  }) = _QuizResultImpl;

  factory QuizResult.fromJson(Map<String, dynamic> jsonSerialization) {
    return QuizResult(
      correct: _isc.BoolJsonExtension.fromJson(jsonSerialization['correct']),
      correctIndex: jsonSerialization['correctIndex'] as int,
      explanation: jsonSerialization['explanation'] as String,
      answerCount: jsonSerialization['answerCount'] as int,
    );
  }

  bool correct;

  int correctIndex;

  String explanation;

  int answerCount;

  /// Returns a shallow copy of this [QuizResult]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  QuizResult copyWith({
    bool? correct,
    int? correctIndex,
    String? explanation,
    int? answerCount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'QuizResult',
      'correct': correct,
      'correctIndex': correctIndex,
      'explanation': explanation,
      'answerCount': answerCount,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'QuizResult',
      'correct': correct,
      'correctIndex': correctIndex,
      'explanation': explanation,
      'answerCount': answerCount,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _QuizResultImpl extends QuizResult {
  _QuizResultImpl({
    required bool correct,
    required int correctIndex,
    required String explanation,
    required int answerCount,
  }) : super._(
         correct: correct,
         correctIndex: correctIndex,
         explanation: explanation,
         answerCount: answerCount,
       );

  /// Returns a shallow copy of this [QuizResult]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  QuizResult copyWith({
    bool? correct,
    int? correctIndex,
    String? explanation,
    int? answerCount,
  }) {
    return QuizResult(
      correct: correct ?? this.correct,
      correctIndex: correctIndex ?? this.correctIndex,
      explanation: explanation ?? this.explanation,
      answerCount: answerCount ?? this.answerCount,
    );
  }
}
