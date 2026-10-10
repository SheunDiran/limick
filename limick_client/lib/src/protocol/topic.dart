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

/// Broad subject area used for onboarding, ranking and rooms.
enum Topic implements _isc.SerializableModel {
  medicine,
  law,
  science,
  philosophy,
  psychology,
  economics,
  history,
  literature,
  poetry,
  mathematics,
  technology,
  religion,
  politics,
  biography,
  selfImprovement,
  arts,
  education,
  nature;

  static Topic fromJson(String name) {
    switch (name) {
      case 'medicine':
        return Topic.medicine;
      case 'law':
        return Topic.law;
      case 'science':
        return Topic.science;
      case 'philosophy':
        return Topic.philosophy;
      case 'psychology':
        return Topic.psychology;
      case 'economics':
        return Topic.economics;
      case 'history':
        return Topic.history;
      case 'literature':
        return Topic.literature;
      case 'poetry':
        return Topic.poetry;
      case 'mathematics':
        return Topic.mathematics;
      case 'technology':
        return Topic.technology;
      case 'religion':
        return Topic.religion;
      case 'politics':
        return Topic.politics;
      case 'biography':
        return Topic.biography;
      case 'selfImprovement':
        return Topic.selfImprovement;
      case 'arts':
        return Topic.arts;
      case 'education':
        return Topic.education;
      case 'nature':
        return Topic.nature;
      default:
        throw ArgumentError('Value "$name" cannot be converted to "Topic"');
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
