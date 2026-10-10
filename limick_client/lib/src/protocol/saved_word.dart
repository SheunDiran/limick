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

/// A word in the user's word bank, reviewed with a simple Leitner schedule.
abstract class SavedWord
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  SavedWord._({
    this.id,
    required this.profileId,
    required this.word,
    required this.definition,
    String? partOfSpeech,
    this.example,
    this.bookTitle,
    this.postId,
    int? box,
    int? reviewCount,
    required this.dueAt,
    DateTime? createdAt,
  }) : partOfSpeech = partOfSpeech ?? '',
       box = box ?? 0,
       reviewCount = reviewCount ?? 0,
       createdAt = createdAt ?? DateTime.now();

  factory SavedWord({
    int? id,
    required int profileId,
    required String word,
    required String definition,
    String? partOfSpeech,
    String? example,
    String? bookTitle,
    int? postId,
    int? box,
    int? reviewCount,
    required DateTime dueAt,
    DateTime? createdAt,
  }) = _SavedWordImpl;

  factory SavedWord.fromJson(Map<String, dynamic> jsonSerialization) {
    return SavedWord(
      id: jsonSerialization['id'] as int?,
      profileId: jsonSerialization['profileId'] as int,
      word: jsonSerialization['word'] as String,
      definition: jsonSerialization['definition'] as String,
      partOfSpeech: jsonSerialization['partOfSpeech'] as String?,
      example: jsonSerialization['example'] as String?,
      bookTitle: jsonSerialization['bookTitle'] as String?,
      postId: jsonSerialization['postId'] as int?,
      box: jsonSerialization['box'] as int?,
      reviewCount: jsonSerialization['reviewCount'] as int?,
      dueAt: _isc.DateTimeJsonExtension.fromJson(jsonSerialization['dueAt']),
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

  String word;

  String definition;

  String partOfSpeech;

  String? example;

  String? bookTitle;

  int? postId;

  int box;

  int reviewCount;

  DateTime dueAt;

  DateTime createdAt;

  /// Returns a shallow copy of this [SavedWord]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  SavedWord copyWith({
    int? id,
    int? profileId,
    String? word,
    String? definition,
    String? partOfSpeech,
    String? example,
    String? bookTitle,
    int? postId,
    int? box,
    int? reviewCount,
    DateTime? dueAt,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SavedWord',
      if (id != null) 'id': id,
      'profileId': profileId,
      'word': word,
      'definition': definition,
      'partOfSpeech': partOfSpeech,
      if (example != null) 'example': example,
      if (bookTitle != null) 'bookTitle': bookTitle,
      if (postId != null) 'postId': postId,
      'box': box,
      'reviewCount': reviewCount,
      'dueAt': dueAt.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SavedWord',
      if (id != null) 'id': id,
      'profileId': profileId,
      'word': word,
      'definition': definition,
      'partOfSpeech': partOfSpeech,
      if (example != null) 'example': example,
      if (bookTitle != null) 'bookTitle': bookTitle,
      if (postId != null) 'postId': postId,
      'box': box,
      'reviewCount': reviewCount,
      'dueAt': dueAt.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SavedWordImpl extends SavedWord {
  _SavedWordImpl({
    int? id,
    required int profileId,
    required String word,
    required String definition,
    String? partOfSpeech,
    String? example,
    String? bookTitle,
    int? postId,
    int? box,
    int? reviewCount,
    required DateTime dueAt,
    DateTime? createdAt,
  }) : super._(
         id: id,
         profileId: profileId,
         word: word,
         definition: definition,
         partOfSpeech: partOfSpeech,
         example: example,
         bookTitle: bookTitle,
         postId: postId,
         box: box,
         reviewCount: reviewCount,
         dueAt: dueAt,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [SavedWord]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  SavedWord copyWith({
    Object? id = _Undefined,
    int? profileId,
    String? word,
    String? definition,
    String? partOfSpeech,
    Object? example = _Undefined,
    Object? bookTitle = _Undefined,
    Object? postId = _Undefined,
    int? box,
    int? reviewCount,
    DateTime? dueAt,
    DateTime? createdAt,
  }) {
    return SavedWord(
      id: id is int? ? id : this.id,
      profileId: profileId ?? this.profileId,
      word: word ?? this.word,
      definition: definition ?? this.definition,
      partOfSpeech: partOfSpeech ?? this.partOfSpeech,
      example: example is String? ? example : this.example,
      bookTitle: bookTitle is String? ? bookTitle : this.bookTitle,
      postId: postId is int? ? postId : this.postId,
      box: box ?? this.box,
      reviewCount: reviewCount ?? this.reviewCount,
      dueAt: dueAt ?? this.dueAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
