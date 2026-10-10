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
import 'topic.dart' as _iro94j51;

abstract class TopicAffinity
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  TopicAffinity._({
    this.id,
    required this.profileId,
    required this.topic,
    double? score,
  }) : score = score ?? 0.0;

  factory TopicAffinity({
    int? id,
    required int profileId,
    required _iro94j51.Topic topic,
    double? score,
  }) = _TopicAffinityImpl;

  factory TopicAffinity.fromJson(Map<String, dynamic> jsonSerialization) {
    return TopicAffinity(
      id: jsonSerialization['id'] as int?,
      profileId: jsonSerialization['profileId'] as int,
      topic: _iro94j51.Topic.fromJson((jsonSerialization['topic'] as String)),
      score: (jsonSerialization['score'] as num?)?.toDouble(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int profileId;

  _iro94j51.Topic topic;

  double score;

  /// Returns a shallow copy of this [TopicAffinity]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  TopicAffinity copyWith({
    int? id,
    int? profileId,
    _iro94j51.Topic? topic,
    double? score,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TopicAffinity',
      if (id != null) 'id': id,
      'profileId': profileId,
      'topic': topic.toJson(),
      'score': score,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'TopicAffinity',
      if (id != null) 'id': id,
      'profileId': profileId,
      'topic': topic.toJson(),
      'score': score,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TopicAffinityImpl extends TopicAffinity {
  _TopicAffinityImpl({
    int? id,
    required int profileId,
    required _iro94j51.Topic topic,
    double? score,
  }) : super._(
         id: id,
         profileId: profileId,
         topic: topic,
         score: score,
       );

  /// Returns a shallow copy of this [TopicAffinity]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  TopicAffinity copyWith({
    Object? id = _Undefined,
    int? profileId,
    _iro94j51.Topic? topic,
    double? score,
  }) {
    return TopicAffinity(
      id: id is int? ? id : this.id,
      profileId: profileId ?? this.profileId,
      topic: topic ?? this.topic,
      score: score ?? this.score,
    );
  }
}
