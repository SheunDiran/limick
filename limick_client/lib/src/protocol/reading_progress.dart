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

abstract class ReadingProgress
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ReadingProgress._({
    this.id,
    required this.profileId,
    required this.bookId,
    required this.chapterPosition,
    double? scrollFraction,
    DateTime? updatedAt,
    DateTime? createdAt,
  }) : scrollFraction = scrollFraction ?? 0.0,
       updatedAt = updatedAt ?? DateTime.now(),
       createdAt = createdAt ?? DateTime.now();

  factory ReadingProgress({
    int? id,
    required int profileId,
    required int bookId,
    required int chapterPosition,
    double? scrollFraction,
    DateTime? updatedAt,
    DateTime? createdAt,
  }) = _ReadingProgressImpl;

  factory ReadingProgress.fromJson(Map<String, dynamic> jsonSerialization) {
    return ReadingProgress(
      id: jsonSerialization['id'] as int?,
      profileId: jsonSerialization['profileId'] as int,
      bookId: jsonSerialization['bookId'] as int,
      chapterPosition: jsonSerialization['chapterPosition'] as int,
      scrollFraction: (jsonSerialization['scrollFraction'] as num?)?.toDouble(),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
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

  int chapterPosition;

  double scrollFraction;

  DateTime updatedAt;

  DateTime createdAt;

  /// Returns a shallow copy of this [ReadingProgress]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ReadingProgress copyWith({
    int? id,
    int? profileId,
    int? bookId,
    int? chapterPosition,
    double? scrollFraction,
    DateTime? updatedAt,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ReadingProgress',
      if (id != null) 'id': id,
      'profileId': profileId,
      'bookId': bookId,
      'chapterPosition': chapterPosition,
      'scrollFraction': scrollFraction,
      'updatedAt': updatedAt.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ReadingProgress',
      if (id != null) 'id': id,
      'profileId': profileId,
      'bookId': bookId,
      'chapterPosition': chapterPosition,
      'scrollFraction': scrollFraction,
      'updatedAt': updatedAt.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ReadingProgressImpl extends ReadingProgress {
  _ReadingProgressImpl({
    int? id,
    required int profileId,
    required int bookId,
    required int chapterPosition,
    double? scrollFraction,
    DateTime? updatedAt,
    DateTime? createdAt,
  }) : super._(
         id: id,
         profileId: profileId,
         bookId: bookId,
         chapterPosition: chapterPosition,
         scrollFraction: scrollFraction,
         updatedAt: updatedAt,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [ReadingProgress]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ReadingProgress copyWith({
    Object? id = _Undefined,
    int? profileId,
    int? bookId,
    int? chapterPosition,
    double? scrollFraction,
    DateTime? updatedAt,
    DateTime? createdAt,
  }) {
    return ReadingProgress(
      id: id is int? ? id : this.id,
      profileId: profileId ?? this.profileId,
      bookId: bookId ?? this.bookId,
      chapterPosition: chapterPosition ?? this.chapterPosition,
      scrollFraction: scrollFraction ?? this.scrollFraction,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
