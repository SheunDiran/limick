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

/// Limick's own data for a signed-in user.
abstract class Reader
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Reader._({
    this.id,
    required this.handle,
    required this.displayName,
    String? bio,
    this.field,
    required this.interests,
    int? dailyGoalMinutes,
    bool? onboarded,
    int? avatarHue,
    int? streakDays,
    this.lastActiveDay,
    int? tzOffsetMinutes,
    bool? official,
    DateTime? createdAt,
  }) : bio = bio ?? '',
       dailyGoalMinutes = dailyGoalMinutes ?? 15,
       onboarded = onboarded ?? false,
       avatarHue = avatarHue ?? 210,
       streakDays = streakDays ?? 0,
       tzOffsetMinutes = tzOffsetMinutes ?? 0,
       official = official ?? false,
       createdAt = createdAt ?? DateTime.now();

  factory Reader({
    int? id,
    required String handle,
    required String displayName,
    String? bio,
    String? field,
    required List<_iro94j51.Topic> interests,
    int? dailyGoalMinutes,
    bool? onboarded,
    int? avatarHue,
    int? streakDays,
    String? lastActiveDay,
    int? tzOffsetMinutes,
    bool? official,
    DateTime? createdAt,
  }) = _ReaderImpl;

  factory Reader.fromJson(Map<String, dynamic> jsonSerialization) {
    return Reader(
      id: jsonSerialization['id'] as int?,
      handle: jsonSerialization['handle'] as String,
      displayName: jsonSerialization['displayName'] as String,
      bio: jsonSerialization['bio'] as String?,
      field: jsonSerialization['field'] as String?,
      interests: _i0imvg6w.Protocol().deserialize<List<_iro94j51.Topic>>(
        jsonSerialization['interests'],
      ),
      dailyGoalMinutes: jsonSerialization['dailyGoalMinutes'] as int?,
      onboarded: jsonSerialization['onboarded'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['onboarded']),
      avatarHue: jsonSerialization['avatarHue'] as int?,
      streakDays: jsonSerialization['streakDays'] as int?,
      lastActiveDay: jsonSerialization['lastActiveDay'] as String?,
      tzOffsetMinutes: jsonSerialization['tzOffsetMinutes'] as int?,
      official: jsonSerialization['official'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['official']),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String handle;

  String displayName;

  String bio;

  String? field;

  List<_iro94j51.Topic> interests;

  int dailyGoalMinutes;

  bool onboarded;

  int avatarHue;

  int streakDays;

  String? lastActiveDay;

  int tzOffsetMinutes;

  /// The platform's own account (@limick). Not a person.
  bool official;

  DateTime createdAt;

  /// Returns a shallow copy of this [Reader]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Reader copyWith({
    int? id,
    String? handle,
    String? displayName,
    String? bio,
    String? field,
    List<_iro94j51.Topic>? interests,
    int? dailyGoalMinutes,
    bool? onboarded,
    int? avatarHue,
    int? streakDays,
    String? lastActiveDay,
    int? tzOffsetMinutes,
    bool? official,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Reader',
      if (id != null) 'id': id,
      'handle': handle,
      'displayName': displayName,
      'bio': bio,
      if (field != null) 'field': field,
      'interests': interests.toJson(valueToJson: (v) => v.toJson()),
      'dailyGoalMinutes': dailyGoalMinutes,
      'onboarded': onboarded,
      'avatarHue': avatarHue,
      'streakDays': streakDays,
      if (lastActiveDay != null) 'lastActiveDay': lastActiveDay,
      'tzOffsetMinutes': tzOffsetMinutes,
      'official': official,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Reader',
      if (id != null) 'id': id,
      'handle': handle,
      'displayName': displayName,
      'bio': bio,
      if (field != null) 'field': field,
      'interests': interests.toJson(valueToJson: (v) => v.toJson()),
      'dailyGoalMinutes': dailyGoalMinutes,
      'onboarded': onboarded,
      'avatarHue': avatarHue,
      'streakDays': streakDays,
      if (lastActiveDay != null) 'lastActiveDay': lastActiveDay,
      'tzOffsetMinutes': tzOffsetMinutes,
      'official': official,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ReaderImpl extends Reader {
  _ReaderImpl({
    int? id,
    required String handle,
    required String displayName,
    String? bio,
    String? field,
    required List<_iro94j51.Topic> interests,
    int? dailyGoalMinutes,
    bool? onboarded,
    int? avatarHue,
    int? streakDays,
    String? lastActiveDay,
    int? tzOffsetMinutes,
    bool? official,
    DateTime? createdAt,
  }) : super._(
         id: id,
         handle: handle,
         displayName: displayName,
         bio: bio,
         field: field,
         interests: interests,
         dailyGoalMinutes: dailyGoalMinutes,
         onboarded: onboarded,
         avatarHue: avatarHue,
         streakDays: streakDays,
         lastActiveDay: lastActiveDay,
         tzOffsetMinutes: tzOffsetMinutes,
         official: official,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Reader]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Reader copyWith({
    Object? id = _Undefined,
    String? handle,
    String? displayName,
    String? bio,
    Object? field = _Undefined,
    List<_iro94j51.Topic>? interests,
    int? dailyGoalMinutes,
    bool? onboarded,
    int? avatarHue,
    int? streakDays,
    Object? lastActiveDay = _Undefined,
    int? tzOffsetMinutes,
    bool? official,
    DateTime? createdAt,
  }) {
    return Reader(
      id: id is int? ? id : this.id,
      handle: handle ?? this.handle,
      displayName: displayName ?? this.displayName,
      bio: bio ?? this.bio,
      field: field is String? ? field : this.field,
      interests: interests ?? this.interests.map((e0) => e0).toList(),
      dailyGoalMinutes: dailyGoalMinutes ?? this.dailyGoalMinutes,
      onboarded: onboarded ?? this.onboarded,
      avatarHue: avatarHue ?? this.avatarHue,
      streakDays: streakDays ?? this.streakDays,
      lastActiveDay: lastActiveDay is String?
          ? lastActiveDay
          : this.lastActiveDay,
      tzOffsetMinutes: tzOffsetMinutes ?? this.tzOffsetMinutes,
      official: official ?? this.official,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
