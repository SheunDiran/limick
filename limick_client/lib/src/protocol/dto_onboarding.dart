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
import 'topic.dart' as _iro94j51;

abstract class OnboardingInput
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  OnboardingInput._({
    required this.displayName,
    required this.handle,
    this.field,
    required this.interests,
    required this.favoriteBookIds,
    required this.dailyGoalMinutes,
  });

  factory OnboardingInput({
    required String displayName,
    required String handle,
    String? field,
    required List<_iro94j51.Topic> interests,
    required List<int> favoriteBookIds,
    required int dailyGoalMinutes,
  }) = _OnboardingInputImpl;

  factory OnboardingInput.fromJson(Map<String, dynamic> jsonSerialization) {
    return OnboardingInput(
      displayName: jsonSerialization['displayName'] as String,
      handle: jsonSerialization['handle'] as String,
      field: jsonSerialization['field'] as String?,
      interests: _i0imvg6w.Protocol().deserialize<List<_iro94j51.Topic>>(
        jsonSerialization['interests'],
      ),
      favoriteBookIds: _i0imvg6w.Protocol().deserialize<List<int>>(
        jsonSerialization['favoriteBookIds'],
      ),
      dailyGoalMinutes: jsonSerialization['dailyGoalMinutes'] as int,
    );
  }

  String displayName;

  String handle;

  String? field;

  List<_iro94j51.Topic> interests;

  List<int> favoriteBookIds;

  int dailyGoalMinutes;

  /// Returns a shallow copy of this [OnboardingInput]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  OnboardingInput copyWith({
    String? displayName,
    String? handle,
    String? field,
    List<_iro94j51.Topic>? interests,
    List<int>? favoriteBookIds,
    int? dailyGoalMinutes,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OnboardingInput',
      'displayName': displayName,
      'handle': handle,
      if (field != null) 'field': field,
      'interests': interests.toJson(valueToJson: (v) => v.toJson()),
      'favoriteBookIds': favoriteBookIds.toJson(),
      'dailyGoalMinutes': dailyGoalMinutes,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'OnboardingInput',
      'displayName': displayName,
      'handle': handle,
      if (field != null) 'field': field,
      'interests': interests.toJson(valueToJson: (v) => v.toJson()),
      'favoriteBookIds': favoriteBookIds.toJson(),
      'dailyGoalMinutes': dailyGoalMinutes,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OnboardingInputImpl extends OnboardingInput {
  _OnboardingInputImpl({
    required String displayName,
    required String handle,
    String? field,
    required List<_iro94j51.Topic> interests,
    required List<int> favoriteBookIds,
    required int dailyGoalMinutes,
  }) : super._(
         displayName: displayName,
         handle: handle,
         field: field,
         interests: interests,
         favoriteBookIds: favoriteBookIds,
         dailyGoalMinutes: dailyGoalMinutes,
       );

  /// Returns a shallow copy of this [OnboardingInput]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  OnboardingInput copyWith({
    String? displayName,
    String? handle,
    Object? field = _Undefined,
    List<_iro94j51.Topic>? interests,
    List<int>? favoriteBookIds,
    int? dailyGoalMinutes,
  }) {
    return OnboardingInput(
      displayName: displayName ?? this.displayName,
      handle: handle ?? this.handle,
      field: field is String? ? field : this.field,
      interests: interests ?? this.interests.map((e0) => e0).toList(),
      favoriteBookIds:
          favoriteBookIds ?? this.favoriteBookIds.map((e0) => e0).toList(),
      dailyGoalMinutes: dailyGoalMinutes ?? this.dailyGoalMinutes,
    );
  }
}
