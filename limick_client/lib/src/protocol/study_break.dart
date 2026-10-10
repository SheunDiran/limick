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

abstract class StudyBreak
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  StudyBreak._({
    this.id,
    required this.profileId,
    required this.plannedMinutes,
    DateTime? startedAt,
    this.endedAt,
  }) : startedAt = startedAt ?? DateTime.now();

  factory StudyBreak({
    int? id,
    required int profileId,
    required int plannedMinutes,
    DateTime? startedAt,
    DateTime? endedAt,
  }) = _StudyBreakImpl;

  factory StudyBreak.fromJson(Map<String, dynamic> jsonSerialization) {
    return StudyBreak(
      id: jsonSerialization['id'] as int?,
      profileId: jsonSerialization['profileId'] as int,
      plannedMinutes: jsonSerialization['plannedMinutes'] as int,
      startedAt: jsonSerialization['startedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['startedAt']),
      endedAt: jsonSerialization['endedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['endedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int profileId;

  int plannedMinutes;

  DateTime startedAt;

  DateTime? endedAt;

  /// Returns a shallow copy of this [StudyBreak]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  StudyBreak copyWith({
    int? id,
    int? profileId,
    int? plannedMinutes,
    DateTime? startedAt,
    DateTime? endedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StudyBreak',
      if (id != null) 'id': id,
      'profileId': profileId,
      'plannedMinutes': plannedMinutes,
      'startedAt': startedAt.toJson(),
      if (endedAt != null) 'endedAt': endedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'StudyBreak',
      if (id != null) 'id': id,
      'profileId': profileId,
      'plannedMinutes': plannedMinutes,
      'startedAt': startedAt.toJson(),
      if (endedAt != null) 'endedAt': endedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StudyBreakImpl extends StudyBreak {
  _StudyBreakImpl({
    int? id,
    required int profileId,
    required int plannedMinutes,
    DateTime? startedAt,
    DateTime? endedAt,
  }) : super._(
         id: id,
         profileId: profileId,
         plannedMinutes: plannedMinutes,
         startedAt: startedAt,
         endedAt: endedAt,
       );

  /// Returns a shallow copy of this [StudyBreak]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  StudyBreak copyWith({
    Object? id = _Undefined,
    int? profileId,
    int? plannedMinutes,
    DateTime? startedAt,
    Object? endedAt = _Undefined,
  }) {
    return StudyBreak(
      id: id is int? ? id : this.id,
      profileId: profileId ?? this.profileId,
      plannedMinutes: plannedMinutes ?? this.plannedMinutes,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt is DateTime? ? endedAt : this.endedAt,
    );
  }
}
