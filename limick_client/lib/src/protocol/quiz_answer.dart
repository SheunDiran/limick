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

abstract class QuizAnswer
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  QuizAnswer._({
    this.id,
    required this.profileId,
    required this.postId,
    required this.choiceIndex,
    required this.correct,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory QuizAnswer({
    int? id,
    required int profileId,
    required int postId,
    required int choiceIndex,
    required bool correct,
    DateTime? createdAt,
  }) = _QuizAnswerImpl;

  factory QuizAnswer.fromJson(Map<String, dynamic> jsonSerialization) {
    return QuizAnswer(
      id: jsonSerialization['id'] as int?,
      profileId: jsonSerialization['profileId'] as int,
      postId: jsonSerialization['postId'] as int,
      choiceIndex: jsonSerialization['choiceIndex'] as int,
      correct: _isc.BoolJsonExtension.fromJson(jsonSerialization['correct']),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int profileId;

  int postId;

  int choiceIndex;

  bool correct;

  DateTime createdAt;

  /// Returns a shallow copy of this [QuizAnswer]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  QuizAnswer copyWith({
    int? id,
    int? profileId,
    int? postId,
    int? choiceIndex,
    bool? correct,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'QuizAnswer',
      if (id != null) 'id': id,
      'profileId': profileId,
      'postId': postId,
      'choiceIndex': choiceIndex,
      'correct': correct,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'QuizAnswer',
      if (id != null) 'id': id,
      'profileId': profileId,
      'postId': postId,
      'choiceIndex': choiceIndex,
      'correct': correct,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _QuizAnswerImpl extends QuizAnswer {
  _QuizAnswerImpl({
    int? id,
    required int profileId,
    required int postId,
    required int choiceIndex,
    required bool correct,
    DateTime? createdAt,
  }) : super._(
         id: id,
         profileId: profileId,
         postId: postId,
         choiceIndex: choiceIndex,
         correct: correct,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [QuizAnswer]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  QuizAnswer copyWith({
    Object? id = _Undefined,
    int? profileId,
    int? postId,
    int? choiceIndex,
    bool? correct,
    DateTime? createdAt,
  }) {
    return QuizAnswer(
      id: id is int? ? id : this.id,
      profileId: profileId ?? this.profileId,
      postId: postId ?? this.postId,
      choiceIndex: choiceIndex ?? this.choiceIndex,
      correct: correct ?? this.correct,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
