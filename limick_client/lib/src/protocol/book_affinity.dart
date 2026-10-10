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

abstract class BookAffinity
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  BookAffinity._({
    this.id,
    required this.profileId,
    required this.bookId,
    double? score,
    DateTime? createdAt,
  }) : score = score ?? 0.0,
       createdAt = createdAt ?? DateTime.now();

  factory BookAffinity({
    int? id,
    required int profileId,
    required int bookId,
    double? score,
    DateTime? createdAt,
  }) = _BookAffinityImpl;

  factory BookAffinity.fromJson(Map<String, dynamic> jsonSerialization) {
    return BookAffinity(
      id: jsonSerialization['id'] as int?,
      profileId: jsonSerialization['profileId'] as int,
      bookId: jsonSerialization['bookId'] as int,
      score: (jsonSerialization['score'] as num?)?.toDouble(),
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

  int bookId;

  double score;

  DateTime createdAt;

  /// Returns a shallow copy of this [BookAffinity]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  BookAffinity copyWith({
    int? id,
    int? profileId,
    int? bookId,
    double? score,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BookAffinity',
      if (id != null) 'id': id,
      'profileId': profileId,
      'bookId': bookId,
      'score': score,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'BookAffinity',
      if (id != null) 'id': id,
      'profileId': profileId,
      'bookId': bookId,
      'score': score,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BookAffinityImpl extends BookAffinity {
  _BookAffinityImpl({
    int? id,
    required int profileId,
    required int bookId,
    double? score,
    DateTime? createdAt,
  }) : super._(
         id: id,
         profileId: profileId,
         bookId: bookId,
         score: score,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [BookAffinity]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  BookAffinity copyWith({
    Object? id = _Undefined,
    int? profileId,
    int? bookId,
    double? score,
    DateTime? createdAt,
  }) {
    return BookAffinity(
      id: id is int? ? id : this.id,
      profileId: profileId ?? this.profileId,
      bookId: bookId ?? this.bookId,
      score: score ?? this.score,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
