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
import 'reader.dart' as _in4ni7b0;
import 'study_break.dart' as _i199zodz;

/// Everything the app needs on launch for the signed-in user.
abstract class Me implements _is.SerializableModel, _is.ProtocolSerialization {
  Me._({
    this.profile,
    required this.suggestedHandle,
    this.activeBreak,
    int? dueWords,
  }) : dueWords = dueWords ?? 0;

  factory Me({
    _in4ni7b0.Reader? profile,
    required String suggestedHandle,
    _i199zodz.StudyBreak? activeBreak,
    int? dueWords,
  }) = _MeImpl;

  factory Me.fromJson(Map<String, dynamic> jsonSerialization) {
    return Me(
      profile: jsonSerialization['profile'] == null
          ? null
          : _i8uqouhs.Protocol().deserialize<_in4ni7b0.Reader>(
              jsonSerialization['profile'],
            ),
      suggestedHandle: jsonSerialization['suggestedHandle'] as String,
      activeBreak: jsonSerialization['activeBreak'] == null
          ? null
          : _i8uqouhs.Protocol().deserialize<_i199zodz.StudyBreak>(
              jsonSerialization['activeBreak'],
            ),
      dueWords: jsonSerialization['dueWords'] as int?,
    );
  }

  _in4ni7b0.Reader? profile;

  String suggestedHandle;

  _i199zodz.StudyBreak? activeBreak;

  int dueWords;

  /// Returns a shallow copy of this [Me]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Me copyWith({
    _in4ni7b0.Reader? profile,
    String? suggestedHandle,
    _i199zodz.StudyBreak? activeBreak,
    int? dueWords,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Me',
      if (profile != null) 'profile': profile?.toJson(),
      'suggestedHandle': suggestedHandle,
      if (activeBreak != null) 'activeBreak': activeBreak?.toJson(),
      'dueWords': dueWords,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Me',
      if (profile != null) 'profile': profile?.toJsonForProtocol(),
      'suggestedHandle': suggestedHandle,
      if (activeBreak != null) 'activeBreak': activeBreak?.toJsonForProtocol(),
      'dueWords': dueWords,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MeImpl extends Me {
  _MeImpl({
    _in4ni7b0.Reader? profile,
    required String suggestedHandle,
    _i199zodz.StudyBreak? activeBreak,
    int? dueWords,
  }) : super._(
         profile: profile,
         suggestedHandle: suggestedHandle,
         activeBreak: activeBreak,
         dueWords: dueWords,
       );

  /// Returns a shallow copy of this [Me]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Me copyWith({
    Object? profile = _Undefined,
    String? suggestedHandle,
    Object? activeBreak = _Undefined,
    int? dueWords,
  }) {
    return Me(
      profile: profile is _in4ni7b0.Reader?
          ? profile
          : this.profile?.copyWith(),
      suggestedHandle: suggestedHandle ?? this.suggestedHandle,
      activeBreak: activeBreak is _i199zodz.StudyBreak?
          ? activeBreak
          : this.activeBreak?.copyWith(),
      dueWords: dueWords ?? this.dueWords,
    );
  }
}
