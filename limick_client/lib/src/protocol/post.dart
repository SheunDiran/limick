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
import 'post_kind.dart' as _i8wd172o;
import 'topic.dart' as _iro94j51;

/// A post generated from a passage of a book.
abstract class Post
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Post._({
    this.id,
    required this.bookId,
    required this.chapterId,
    required this.chapterPosition,
    required this.kind,
    required this.body,
    this.style,
    this.quote,
    this.parts,
    this.word,
    this.wordDefinition,
    this.wordPartOfSpeech,
    this.quizOptions,
    required this.primaryTopic,
    bool? historical,
    required this.passageStart,
    required this.passageEnd,
    int? likeCount,
    int? commentCount,
    int? saveCount,
    int? agreeCount,
    int? disagreeCount,
    int? quizAnswerCount,
    DateTime? createdAt,
  }) : historical = historical ?? false,
       likeCount = likeCount ?? 0,
       commentCount = commentCount ?? 0,
       saveCount = saveCount ?? 0,
       agreeCount = agreeCount ?? 0,
       disagreeCount = disagreeCount ?? 0,
       quizAnswerCount = quizAnswerCount ?? 0,
       createdAt = createdAt ?? DateTime.now();

  factory Post({
    int? id,
    required int bookId,
    required int chapterId,
    required int chapterPosition,
    required _i8wd172o.PostKind kind,
    required String body,
    String? style,
    String? quote,
    List<String>? parts,
    String? word,
    String? wordDefinition,
    String? wordPartOfSpeech,
    List<String>? quizOptions,
    required _iro94j51.Topic primaryTopic,
    bool? historical,
    required int passageStart,
    required int passageEnd,
    int? likeCount,
    int? commentCount,
    int? saveCount,
    int? agreeCount,
    int? disagreeCount,
    int? quizAnswerCount,
    DateTime? createdAt,
  }) = _PostImpl;

  factory Post.fromJson(Map<String, dynamic> jsonSerialization) {
    return Post(
      id: jsonSerialization['id'] as int?,
      bookId: jsonSerialization['bookId'] as int,
      chapterId: jsonSerialization['chapterId'] as int,
      chapterPosition: jsonSerialization['chapterPosition'] as int,
      kind: _i8wd172o.PostKind.fromJson((jsonSerialization['kind'] as String)),
      body: jsonSerialization['body'] as String,
      style: jsonSerialization['style'] as String?,
      quote: jsonSerialization['quote'] as String?,
      parts: jsonSerialization['parts'] == null
          ? null
          : _i0imvg6w.Protocol().deserialize<List<String>>(
              jsonSerialization['parts'],
            ),
      word: jsonSerialization['word'] as String?,
      wordDefinition: jsonSerialization['wordDefinition'] as String?,
      wordPartOfSpeech: jsonSerialization['wordPartOfSpeech'] as String?,
      quizOptions: jsonSerialization['quizOptions'] == null
          ? null
          : _i0imvg6w.Protocol().deserialize<List<String>>(
              jsonSerialization['quizOptions'],
            ),
      primaryTopic: _iro94j51.Topic.fromJson(
        (jsonSerialization['primaryTopic'] as String),
      ),
      historical: jsonSerialization['historical'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['historical']),
      passageStart: jsonSerialization['passageStart'] as int,
      passageEnd: jsonSerialization['passageEnd'] as int,
      likeCount: jsonSerialization['likeCount'] as int?,
      commentCount: jsonSerialization['commentCount'] as int?,
      saveCount: jsonSerialization['saveCount'] as int?,
      agreeCount: jsonSerialization['agreeCount'] as int?,
      disagreeCount: jsonSerialization['disagreeCount'] as int?,
      quizAnswerCount: jsonSerialization['quizAnswerCount'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int bookId;

  int chapterId;

  int chapterPosition;

  _i8wd172o.PostKind kind;

  String body;

  /// The social format the post was written in (hotTake, storytime, pov,
  /// til, ...). Used to keep the feed varied.
  String? style;

  String? quote;

  List<String>? parts;

  String? word;

  String? wordDefinition;

  String? wordPartOfSpeech;

  List<String>? quizOptions;

  _iro94j51.Topic primaryTopic;

  bool historical;

  int passageStart;

  int passageEnd;

  int likeCount;

  int commentCount;

  int saveCount;

  int agreeCount;

  int disagreeCount;

  int quizAnswerCount;

  DateTime createdAt;

  /// Returns a shallow copy of this [Post]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Post copyWith({
    int? id,
    int? bookId,
    int? chapterId,
    int? chapterPosition,
    _i8wd172o.PostKind? kind,
    String? body,
    String? style,
    String? quote,
    List<String>? parts,
    String? word,
    String? wordDefinition,
    String? wordPartOfSpeech,
    List<String>? quizOptions,
    _iro94j51.Topic? primaryTopic,
    bool? historical,
    int? passageStart,
    int? passageEnd,
    int? likeCount,
    int? commentCount,
    int? saveCount,
    int? agreeCount,
    int? disagreeCount,
    int? quizAnswerCount,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Post',
      if (id != null) 'id': id,
      'bookId': bookId,
      'chapterId': chapterId,
      'chapterPosition': chapterPosition,
      'kind': kind.toJson(),
      'body': body,
      if (style != null) 'style': style,
      if (quote != null) 'quote': quote,
      if (parts != null) 'parts': parts?.toJson(),
      if (word != null) 'word': word,
      if (wordDefinition != null) 'wordDefinition': wordDefinition,
      if (wordPartOfSpeech != null) 'wordPartOfSpeech': wordPartOfSpeech,
      if (quizOptions != null) 'quizOptions': quizOptions?.toJson(),
      'primaryTopic': primaryTopic.toJson(),
      'historical': historical,
      'passageStart': passageStart,
      'passageEnd': passageEnd,
      'likeCount': likeCount,
      'commentCount': commentCount,
      'saveCount': saveCount,
      'agreeCount': agreeCount,
      'disagreeCount': disagreeCount,
      'quizAnswerCount': quizAnswerCount,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Post',
      if (id != null) 'id': id,
      'bookId': bookId,
      'chapterId': chapterId,
      'chapterPosition': chapterPosition,
      'kind': kind.toJson(),
      'body': body,
      if (style != null) 'style': style,
      if (quote != null) 'quote': quote,
      if (parts != null) 'parts': parts?.toJson(),
      if (word != null) 'word': word,
      if (wordDefinition != null) 'wordDefinition': wordDefinition,
      if (wordPartOfSpeech != null) 'wordPartOfSpeech': wordPartOfSpeech,
      if (quizOptions != null) 'quizOptions': quizOptions?.toJson(),
      'primaryTopic': primaryTopic.toJson(),
      'historical': historical,
      'passageStart': passageStart,
      'passageEnd': passageEnd,
      'likeCount': likeCount,
      'commentCount': commentCount,
      'saveCount': saveCount,
      'agreeCount': agreeCount,
      'disagreeCount': disagreeCount,
      'quizAnswerCount': quizAnswerCount,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PostImpl extends Post {
  _PostImpl({
    int? id,
    required int bookId,
    required int chapterId,
    required int chapterPosition,
    required _i8wd172o.PostKind kind,
    required String body,
    String? style,
    String? quote,
    List<String>? parts,
    String? word,
    String? wordDefinition,
    String? wordPartOfSpeech,
    List<String>? quizOptions,
    required _iro94j51.Topic primaryTopic,
    bool? historical,
    required int passageStart,
    required int passageEnd,
    int? likeCount,
    int? commentCount,
    int? saveCount,
    int? agreeCount,
    int? disagreeCount,
    int? quizAnswerCount,
    DateTime? createdAt,
  }) : super._(
         id: id,
         bookId: bookId,
         chapterId: chapterId,
         chapterPosition: chapterPosition,
         kind: kind,
         body: body,
         style: style,
         quote: quote,
         parts: parts,
         word: word,
         wordDefinition: wordDefinition,
         wordPartOfSpeech: wordPartOfSpeech,
         quizOptions: quizOptions,
         primaryTopic: primaryTopic,
         historical: historical,
         passageStart: passageStart,
         passageEnd: passageEnd,
         likeCount: likeCount,
         commentCount: commentCount,
         saveCount: saveCount,
         agreeCount: agreeCount,
         disagreeCount: disagreeCount,
         quizAnswerCount: quizAnswerCount,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Post]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Post copyWith({
    Object? id = _Undefined,
    int? bookId,
    int? chapterId,
    int? chapterPosition,
    _i8wd172o.PostKind? kind,
    String? body,
    Object? style = _Undefined,
    Object? quote = _Undefined,
    Object? parts = _Undefined,
    Object? word = _Undefined,
    Object? wordDefinition = _Undefined,
    Object? wordPartOfSpeech = _Undefined,
    Object? quizOptions = _Undefined,
    _iro94j51.Topic? primaryTopic,
    bool? historical,
    int? passageStart,
    int? passageEnd,
    int? likeCount,
    int? commentCount,
    int? saveCount,
    int? agreeCount,
    int? disagreeCount,
    int? quizAnswerCount,
    DateTime? createdAt,
  }) {
    return Post(
      id: id is int? ? id : this.id,
      bookId: bookId ?? this.bookId,
      chapterId: chapterId ?? this.chapterId,
      chapterPosition: chapterPosition ?? this.chapterPosition,
      kind: kind ?? this.kind,
      body: body ?? this.body,
      style: style is String? ? style : this.style,
      quote: quote is String? ? quote : this.quote,
      parts: parts is List<String>?
          ? parts
          : this.parts?.map((e0) => e0).toList(),
      word: word is String? ? word : this.word,
      wordDefinition: wordDefinition is String?
          ? wordDefinition
          : this.wordDefinition,
      wordPartOfSpeech: wordPartOfSpeech is String?
          ? wordPartOfSpeech
          : this.wordPartOfSpeech,
      quizOptions: quizOptions is List<String>?
          ? quizOptions
          : this.quizOptions?.map((e0) => e0).toList(),
      primaryTopic: primaryTopic ?? this.primaryTopic,
      historical: historical ?? this.historical,
      passageStart: passageStart ?? this.passageStart,
      passageEnd: passageEnd ?? this.passageEnd,
      likeCount: likeCount ?? this.likeCount,
      commentCount: commentCount ?? this.commentCount,
      saveCount: saveCount ?? this.saveCount,
      agreeCount: agreeCount ?? this.agreeCount,
      disagreeCount: disagreeCount ?? this.disagreeCount,
      quizAnswerCount: quizAnswerCount ?? this.quizAnswerCount,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
