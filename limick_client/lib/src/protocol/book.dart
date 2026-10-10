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
import 'book_status.dart' as _i7d3z7gh;
import 'topic.dart' as _iro94j51;

/// A public-domain book from Project Gutenberg. Each book is also an
/// "account" in the feed, identified by [handle].
abstract class Book
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Book._({
    this.id,
    required this.gutenbergId,
    required this.title,
    required this.author,
    this.authorYears,
    required this.handle,
    required this.topics,
    required this.primaryTopic,
    String? subjects,
    _i7d3z7gh.BookStatus? status,
    bool? featured,
    int? popularity,
    int? chapterCount,
    int? wordCount,
    int? postCount,
    int? followerCount,
    this.blurb,
    int? ingestAttempts,
    int? nextChapterPosition,
    int? nextOffset,
    int? generationFailures,
    DateTime? createdAt,
  }) : subjects = subjects ?? '',
       status = status ?? _i7d3z7gh.BookStatus.catalogued,
       featured = featured ?? false,
       popularity = popularity ?? 0,
       chapterCount = chapterCount ?? 0,
       wordCount = wordCount ?? 0,
       postCount = postCount ?? 0,
       followerCount = followerCount ?? 0,
       ingestAttempts = ingestAttempts ?? 0,
       nextChapterPosition = nextChapterPosition ?? 0,
       nextOffset = nextOffset ?? 0,
       generationFailures = generationFailures ?? 0,
       createdAt = createdAt ?? DateTime.now();

  factory Book({
    int? id,
    required int gutenbergId,
    required String title,
    required String author,
    String? authorYears,
    required String handle,
    required List<_iro94j51.Topic> topics,
    required _iro94j51.Topic primaryTopic,
    String? subjects,
    _i7d3z7gh.BookStatus? status,
    bool? featured,
    int? popularity,
    int? chapterCount,
    int? wordCount,
    int? postCount,
    int? followerCount,
    String? blurb,
    int? ingestAttempts,
    int? nextChapterPosition,
    int? nextOffset,
    int? generationFailures,
    DateTime? createdAt,
  }) = _BookImpl;

  factory Book.fromJson(Map<String, dynamic> jsonSerialization) {
    return Book(
      id: jsonSerialization['id'] as int?,
      gutenbergId: jsonSerialization['gutenbergId'] as int,
      title: jsonSerialization['title'] as String,
      author: jsonSerialization['author'] as String,
      authorYears: jsonSerialization['authorYears'] as String?,
      handle: jsonSerialization['handle'] as String,
      topics: _i0imvg6w.Protocol().deserialize<List<_iro94j51.Topic>>(
        jsonSerialization['topics'],
      ),
      primaryTopic: _iro94j51.Topic.fromJson(
        (jsonSerialization['primaryTopic'] as String),
      ),
      subjects: jsonSerialization['subjects'] as String?,
      status: jsonSerialization['status'] == null
          ? null
          : _i7d3z7gh.BookStatus.fromJson(
              (jsonSerialization['status'] as String),
            ),
      featured: jsonSerialization['featured'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['featured']),
      popularity: jsonSerialization['popularity'] as int?,
      chapterCount: jsonSerialization['chapterCount'] as int?,
      wordCount: jsonSerialization['wordCount'] as int?,
      postCount: jsonSerialization['postCount'] as int?,
      followerCount: jsonSerialization['followerCount'] as int?,
      blurb: jsonSerialization['blurb'] as String?,
      ingestAttempts: jsonSerialization['ingestAttempts'] as int?,
      nextChapterPosition: jsonSerialization['nextChapterPosition'] as int?,
      nextOffset: jsonSerialization['nextOffset'] as int?,
      generationFailures: jsonSerialization['generationFailures'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int gutenbergId;

  String title;

  String author;

  String? authorYears;

  String handle;

  List<_iro94j51.Topic> topics;

  _iro94j51.Topic primaryTopic;

  String subjects;

  _i7d3z7gh.BookStatus status;

  bool featured;

  int popularity;

  int chapterCount;

  int wordCount;

  int postCount;

  int followerCount;

  String? blurb;

  int ingestAttempts;

  int nextChapterPosition;

  int nextOffset;

  int generationFailures;

  DateTime createdAt;

  /// Returns a shallow copy of this [Book]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Book copyWith({
    int? id,
    int? gutenbergId,
    String? title,
    String? author,
    String? authorYears,
    String? handle,
    List<_iro94j51.Topic>? topics,
    _iro94j51.Topic? primaryTopic,
    String? subjects,
    _i7d3z7gh.BookStatus? status,
    bool? featured,
    int? popularity,
    int? chapterCount,
    int? wordCount,
    int? postCount,
    int? followerCount,
    String? blurb,
    int? ingestAttempts,
    int? nextChapterPosition,
    int? nextOffset,
    int? generationFailures,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Book',
      if (id != null) 'id': id,
      'gutenbergId': gutenbergId,
      'title': title,
      'author': author,
      if (authorYears != null) 'authorYears': authorYears,
      'handle': handle,
      'topics': topics.toJson(valueToJson: (v) => v.toJson()),
      'primaryTopic': primaryTopic.toJson(),
      'subjects': subjects,
      'status': status.toJson(),
      'featured': featured,
      'popularity': popularity,
      'chapterCount': chapterCount,
      'wordCount': wordCount,
      'postCount': postCount,
      'followerCount': followerCount,
      if (blurb != null) 'blurb': blurb,
      'ingestAttempts': ingestAttempts,
      'nextChapterPosition': nextChapterPosition,
      'nextOffset': nextOffset,
      'generationFailures': generationFailures,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Book',
      if (id != null) 'id': id,
      'gutenbergId': gutenbergId,
      'title': title,
      'author': author,
      if (authorYears != null) 'authorYears': authorYears,
      'handle': handle,
      'topics': topics.toJson(valueToJson: (v) => v.toJson()),
      'primaryTopic': primaryTopic.toJson(),
      'subjects': subjects,
      'status': status.toJson(),
      'featured': featured,
      'popularity': popularity,
      'chapterCount': chapterCount,
      'wordCount': wordCount,
      'postCount': postCount,
      'followerCount': followerCount,
      if (blurb != null) 'blurb': blurb,
      'ingestAttempts': ingestAttempts,
      'nextChapterPosition': nextChapterPosition,
      'nextOffset': nextOffset,
      'generationFailures': generationFailures,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BookImpl extends Book {
  _BookImpl({
    int? id,
    required int gutenbergId,
    required String title,
    required String author,
    String? authorYears,
    required String handle,
    required List<_iro94j51.Topic> topics,
    required _iro94j51.Topic primaryTopic,
    String? subjects,
    _i7d3z7gh.BookStatus? status,
    bool? featured,
    int? popularity,
    int? chapterCount,
    int? wordCount,
    int? postCount,
    int? followerCount,
    String? blurb,
    int? ingestAttempts,
    int? nextChapterPosition,
    int? nextOffset,
    int? generationFailures,
    DateTime? createdAt,
  }) : super._(
         id: id,
         gutenbergId: gutenbergId,
         title: title,
         author: author,
         authorYears: authorYears,
         handle: handle,
         topics: topics,
         primaryTopic: primaryTopic,
         subjects: subjects,
         status: status,
         featured: featured,
         popularity: popularity,
         chapterCount: chapterCount,
         wordCount: wordCount,
         postCount: postCount,
         followerCount: followerCount,
         blurb: blurb,
         ingestAttempts: ingestAttempts,
         nextChapterPosition: nextChapterPosition,
         nextOffset: nextOffset,
         generationFailures: generationFailures,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Book]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Book copyWith({
    Object? id = _Undefined,
    int? gutenbergId,
    String? title,
    String? author,
    Object? authorYears = _Undefined,
    String? handle,
    List<_iro94j51.Topic>? topics,
    _iro94j51.Topic? primaryTopic,
    String? subjects,
    _i7d3z7gh.BookStatus? status,
    bool? featured,
    int? popularity,
    int? chapterCount,
    int? wordCount,
    int? postCount,
    int? followerCount,
    Object? blurb = _Undefined,
    int? ingestAttempts,
    int? nextChapterPosition,
    int? nextOffset,
    int? generationFailures,
    DateTime? createdAt,
  }) {
    return Book(
      id: id is int? ? id : this.id,
      gutenbergId: gutenbergId ?? this.gutenbergId,
      title: title ?? this.title,
      author: author ?? this.author,
      authorYears: authorYears is String? ? authorYears : this.authorYears,
      handle: handle ?? this.handle,
      topics: topics ?? this.topics.map((e0) => e0).toList(),
      primaryTopic: primaryTopic ?? this.primaryTopic,
      subjects: subjects ?? this.subjects,
      status: status ?? this.status,
      featured: featured ?? this.featured,
      popularity: popularity ?? this.popularity,
      chapterCount: chapterCount ?? this.chapterCount,
      wordCount: wordCount ?? this.wordCount,
      postCount: postCount ?? this.postCount,
      followerCount: followerCount ?? this.followerCount,
      blurb: blurb is String? ? blurb : this.blurb,
      ingestAttempts: ingestAttempts ?? this.ingestAttempts,
      nextChapterPosition: nextChapterPosition ?? this.nextChapterPosition,
      nextOffset: nextOffset ?? this.nextOffset,
      generationFailures: generationFailures ?? this.generationFailures,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
