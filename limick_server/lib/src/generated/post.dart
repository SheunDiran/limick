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
import 'post_kind.dart' as _i8wd172o;
import 'topic.dart' as _iro94j51;

/// A post generated from a passage of a book.
abstract class Post implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Post._({
    this.id,
    required this.bookId,
    required this.chapterId,
    required this.chapterPosition,
    required this.kind,
    required this.body,
    this.quote,
    this.parts,
    this.word,
    this.wordDefinition,
    this.wordPartOfSpeech,
    this.quizOptions,
    this.quizAnswerIndex,
    this.quizExplanation,
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
    String? quote,
    List<String>? parts,
    String? word,
    String? wordDefinition,
    String? wordPartOfSpeech,
    List<String>? quizOptions,
    int? quizAnswerIndex,
    String? quizExplanation,
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
      quote: jsonSerialization['quote'] as String?,
      parts: jsonSerialization['parts'] == null
          ? null
          : _i8uqouhs.Protocol().deserialize<List<String>>(
              jsonSerialization['parts'],
            ),
      word: jsonSerialization['word'] as String?,
      wordDefinition: jsonSerialization['wordDefinition'] as String?,
      wordPartOfSpeech: jsonSerialization['wordPartOfSpeech'] as String?,
      quizOptions: jsonSerialization['quizOptions'] == null
          ? null
          : _i8uqouhs.Protocol().deserialize<List<String>>(
              jsonSerialization['quizOptions'],
            ),
      quizAnswerIndex: jsonSerialization['quizAnswerIndex'] as int?,
      quizExplanation: jsonSerialization['quizExplanation'] as String?,
      primaryTopic: _iro94j51.Topic.fromJson(
        (jsonSerialization['primaryTopic'] as String),
      ),
      historical: jsonSerialization['historical'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['historical']),
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
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = PostTable();

  static const db = PostRepository._();

  @override
  int? id;

  int bookId;

  int chapterId;

  int chapterPosition;

  _i8wd172o.PostKind kind;

  String body;

  String? quote;

  List<String>? parts;

  String? word;

  String? wordDefinition;

  String? wordPartOfSpeech;

  List<String>? quizOptions;

  int? quizAnswerIndex;

  String? quizExplanation;

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

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Post]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Post copyWith({
    int? id,
    int? bookId,
    int? chapterId,
    int? chapterPosition,
    _i8wd172o.PostKind? kind,
    String? body,
    String? quote,
    List<String>? parts,
    String? word,
    String? wordDefinition,
    String? wordPartOfSpeech,
    List<String>? quizOptions,
    int? quizAnswerIndex,
    String? quizExplanation,
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
      if (quote != null) 'quote': quote,
      if (parts != null) 'parts': parts?.toJson(),
      if (word != null) 'word': word,
      if (wordDefinition != null) 'wordDefinition': wordDefinition,
      if (wordPartOfSpeech != null) 'wordPartOfSpeech': wordPartOfSpeech,
      if (quizOptions != null) 'quizOptions': quizOptions?.toJson(),
      if (quizAnswerIndex != null) 'quizAnswerIndex': quizAnswerIndex,
      if (quizExplanation != null) 'quizExplanation': quizExplanation,
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

  static PostInclude include() {
    return PostInclude._();
  }

  static PostIncludeList includeList({
    _is.WhereExpressionBuilder<PostTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PostTable>? orderBy,
    _is.OrderByListBuilder<PostTable>? orderByList,
    PostInclude? include,
  }) {
    return PostIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Post.t),
      orderByList: orderByList?.call(Post.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
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
    String? quote,
    List<String>? parts,
    String? word,
    String? wordDefinition,
    String? wordPartOfSpeech,
    List<String>? quizOptions,
    int? quizAnswerIndex,
    String? quizExplanation,
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
         quote: quote,
         parts: parts,
         word: word,
         wordDefinition: wordDefinition,
         wordPartOfSpeech: wordPartOfSpeech,
         quizOptions: quizOptions,
         quizAnswerIndex: quizAnswerIndex,
         quizExplanation: quizExplanation,
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
  @_is.useResult
  @override
  Post copyWith({
    Object? id = _Undefined,
    int? bookId,
    int? chapterId,
    int? chapterPosition,
    _i8wd172o.PostKind? kind,
    String? body,
    Object? quote = _Undefined,
    Object? parts = _Undefined,
    Object? word = _Undefined,
    Object? wordDefinition = _Undefined,
    Object? wordPartOfSpeech = _Undefined,
    Object? quizOptions = _Undefined,
    Object? quizAnswerIndex = _Undefined,
    Object? quizExplanation = _Undefined,
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
      quizAnswerIndex: quizAnswerIndex is int?
          ? quizAnswerIndex
          : this.quizAnswerIndex,
      quizExplanation: quizExplanation is String?
          ? quizExplanation
          : this.quizExplanation,
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

class PostUpdateTable extends _is.UpdateTable<PostTable> {
  PostUpdateTable(super.table);

  _is.ColumnValue<int, int> bookId(int value) => _is.ColumnValue(
    table.bookId,
    value,
  );

  _is.ColumnValue<int, int> chapterId(int value) => _is.ColumnValue(
    table.chapterId,
    value,
  );

  _is.ColumnValue<int, int> chapterPosition(int value) => _is.ColumnValue(
    table.chapterPosition,
    value,
  );

  _is.ColumnValue<_i8wd172o.PostKind, _i8wd172o.PostKind> kind(
    _i8wd172o.PostKind value,
  ) => _is.ColumnValue(
    table.kind,
    value,
  );

  _is.ColumnValue<String, String> body(String value) => _is.ColumnValue(
    table.body,
    value,
  );

  _is.ColumnValue<String, String> quote(String? value) => _is.ColumnValue(
    table.quote,
    value,
  );

  _is.ColumnValue<List<String>, List<String>> parts(List<String>? value) =>
      _is.ColumnValue(
        table.parts,
        value,
      );

  _is.ColumnValue<String, String> word(String? value) => _is.ColumnValue(
    table.word,
    value,
  );

  _is.ColumnValue<String, String> wordDefinition(String? value) =>
      _is.ColumnValue(
        table.wordDefinition,
        value,
      );

  _is.ColumnValue<String, String> wordPartOfSpeech(String? value) =>
      _is.ColumnValue(
        table.wordPartOfSpeech,
        value,
      );

  _is.ColumnValue<List<String>, List<String>> quizOptions(
    List<String>? value,
  ) => _is.ColumnValue(
    table.quizOptions,
    value,
  );

  _is.ColumnValue<int, int> quizAnswerIndex(int? value) => _is.ColumnValue(
    table.quizAnswerIndex,
    value,
  );

  _is.ColumnValue<String, String> quizExplanation(String? value) =>
      _is.ColumnValue(
        table.quizExplanation,
        value,
      );

  _is.ColumnValue<_iro94j51.Topic, _iro94j51.Topic> primaryTopic(
    _iro94j51.Topic value,
  ) => _is.ColumnValue(
    table.primaryTopic,
    value,
  );

  _is.ColumnValue<bool, bool> historical(bool value) => _is.ColumnValue(
    table.historical,
    value,
  );

  _is.ColumnValue<int, int> passageStart(int value) => _is.ColumnValue(
    table.passageStart,
    value,
  );

  _is.ColumnValue<int, int> passageEnd(int value) => _is.ColumnValue(
    table.passageEnd,
    value,
  );

  _is.ColumnValue<int, int> likeCount(int value) => _is.ColumnValue(
    table.likeCount,
    value,
  );

  _is.ColumnValue<int, int> commentCount(int value) => _is.ColumnValue(
    table.commentCount,
    value,
  );

  _is.ColumnValue<int, int> saveCount(int value) => _is.ColumnValue(
    table.saveCount,
    value,
  );

  _is.ColumnValue<int, int> agreeCount(int value) => _is.ColumnValue(
    table.agreeCount,
    value,
  );

  _is.ColumnValue<int, int> disagreeCount(int value) => _is.ColumnValue(
    table.disagreeCount,
    value,
  );

  _is.ColumnValue<int, int> quizAnswerCount(int value) => _is.ColumnValue(
    table.quizAnswerCount,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class PostTable extends _is.Table<int?> {
  PostTable({super.tableRelation}) : super(tableName: 'post') {
    updateTable = PostUpdateTable(this);
    bookId = _is.ColumnInt(
      'bookId',
      this,
    );
    chapterId = _is.ColumnInt(
      'chapterId',
      this,
    );
    chapterPosition = _is.ColumnInt(
      'chapterPosition',
      this,
    );
    kind = _is.ColumnEnum(
      'kind',
      this,
      _is.EnumSerialization.byName,
    );
    body = _is.ColumnString(
      'body',
      this,
    );
    quote = _is.ColumnString(
      'quote',
      this,
    );
    parts = _is.ColumnSerializable<List<String>>(
      'parts',
      this,
    );
    word = _is.ColumnString(
      'word',
      this,
    );
    wordDefinition = _is.ColumnString(
      'wordDefinition',
      this,
    );
    wordPartOfSpeech = _is.ColumnString(
      'wordPartOfSpeech',
      this,
    );
    quizOptions = _is.ColumnSerializable<List<String>>(
      'quizOptions',
      this,
    );
    quizAnswerIndex = _is.ColumnInt(
      'quizAnswerIndex',
      this,
    );
    quizExplanation = _is.ColumnString(
      'quizExplanation',
      this,
    );
    primaryTopic = _is.ColumnEnum(
      'primaryTopic',
      this,
      _is.EnumSerialization.byName,
    );
    historical = _is.ColumnBool(
      'historical',
      this,
      hasDefault: true,
    );
    passageStart = _is.ColumnInt(
      'passageStart',
      this,
    );
    passageEnd = _is.ColumnInt(
      'passageEnd',
      this,
    );
    likeCount = _is.ColumnInt(
      'likeCount',
      this,
      hasDefault: true,
    );
    commentCount = _is.ColumnInt(
      'commentCount',
      this,
      hasDefault: true,
    );
    saveCount = _is.ColumnInt(
      'saveCount',
      this,
      hasDefault: true,
    );
    agreeCount = _is.ColumnInt(
      'agreeCount',
      this,
      hasDefault: true,
    );
    disagreeCount = _is.ColumnInt(
      'disagreeCount',
      this,
      hasDefault: true,
    );
    quizAnswerCount = _is.ColumnInt(
      'quizAnswerCount',
      this,
      hasDefault: true,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final PostUpdateTable updateTable;

  late final _is.ColumnInt bookId;

  late final _is.ColumnInt chapterId;

  late final _is.ColumnInt chapterPosition;

  late final _is.ColumnEnum<_i8wd172o.PostKind> kind;

  late final _is.ColumnString body;

  late final _is.ColumnString quote;

  late final _is.ColumnSerializable<List<String>> parts;

  late final _is.ColumnString word;

  late final _is.ColumnString wordDefinition;

  late final _is.ColumnString wordPartOfSpeech;

  late final _is.ColumnSerializable<List<String>> quizOptions;

  late final _is.ColumnInt quizAnswerIndex;

  late final _is.ColumnString quizExplanation;

  late final _is.ColumnEnum<_iro94j51.Topic> primaryTopic;

  late final _is.ColumnBool historical;

  late final _is.ColumnInt passageStart;

  late final _is.ColumnInt passageEnd;

  late final _is.ColumnInt likeCount;

  late final _is.ColumnInt commentCount;

  late final _is.ColumnInt saveCount;

  late final _is.ColumnInt agreeCount;

  late final _is.ColumnInt disagreeCount;

  late final _is.ColumnInt quizAnswerCount;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    bookId,
    chapterId,
    chapterPosition,
    kind,
    body,
    quote,
    parts,
    word,
    wordDefinition,
    wordPartOfSpeech,
    quizOptions,
    quizAnswerIndex,
    quizExplanation,
    primaryTopic,
    historical,
    passageStart,
    passageEnd,
    likeCount,
    commentCount,
    saveCount,
    agreeCount,
    disagreeCount,
    quizAnswerCount,
    createdAt,
  ];
}

class PostInclude extends _is.IncludeObject {
  PostInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => Post.t;
}

class PostIncludeList extends _is.IncludeList {
  PostIncludeList._({
    _is.WhereExpressionBuilder<PostTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Post.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Post.t;
}

class PostRepository {
  const PostRepository._();

  /// Returns a list of [Post]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<Post>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PostTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PostTable>? orderBy,
    _is.OrderByListBuilder<PostTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Post>(
      where: where?.call(Post.t),
      orderBy: orderBy?.call(Post.t),
      orderByList: orderByList?.call(Post.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Post] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<Post?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PostTable>? where,
    int? offset,
    _is.OrderByBuilder<PostTable>? orderBy,
    _is.OrderByListBuilder<PostTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Post>(
      where: where?.call(Post.t),
      orderBy: orderBy?.call(Post.t),
      orderByList: orderByList?.call(Post.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Post] by its [id] or null if no such row exists.
  Future<Post?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Post>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Post]s in the list and returns the inserted rows.
  ///
  /// The returned [Post]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  ///
  /// If [noReturn] is set to `true`, the inserted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Post>> insert(
    _is.DatabaseSession session,
    List<Post> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Post>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Post] and returns the inserted row.
  ///
  /// The returned [Post] will have its `id` field set.
  Future<Post> insertRow(
    _is.DatabaseSession session,
    Post row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Post>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Post]s in the list and returns the resulting rows.
  ///
  /// If a row conflicts on the given [conflictColumns], the existing row is
  /// updated with the new values. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies to rows matching the
  /// given expression. Conflicting rows that don't match are skipped and not
  /// returned, so the resulting list may be shorter than [rows].
  ///
  /// The returned [Post]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Post>> upsert(
    _is.DatabaseSession session,
    List<Post> rows, {
    required _is.ColumnSelections<PostTable> conflictColumns,
    _is.ColumnSelections<PostTable>? updateColumns,
    _is.WhereExpressionBuilder<PostTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Post>(
      rows,
      conflictColumns: conflictColumns(Post.t),
      updateColumns: updateColumns?.call(Post.t),
      updateWhere: updateWhere?.call(Post.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Post] and returns the resulting row.
  ///
  /// If the row conflicts on the given [conflictColumns], the existing row is
  /// updated. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies when the existing
  /// row matches the expression. Returns `null` if no row was affected — for
  /// example when [updateWhere] does not match the conflicting row.
  ///
  /// The returned [Post] will have its `id` field set.
  Future<Post?> upsertRow(
    _is.DatabaseSession session,
    Post row, {
    required _is.ColumnSelections<PostTable> conflictColumns,
    _is.ColumnSelections<PostTable>? updateColumns,
    _is.WhereExpressionBuilder<PostTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Post>(
      row,
      conflictColumns: conflictColumns(Post.t),
      updateColumns: updateColumns?.call(Post.t),
      updateWhere: updateWhere?.call(Post.t),
      transaction: transaction,
    );
  }

  /// Updates all [Post]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Post>> update(
    _is.DatabaseSession session,
    List<Post> rows, {
    _is.ColumnSelections<PostTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Post>(
      rows,
      columns: columns?.call(Post.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Post]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Post> updateRow(
    _is.DatabaseSession session,
    Post row, {
    _is.ColumnSelections<PostTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Post>(
      row,
      columns: columns?.call(Post.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Post] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Post?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<PostUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Post>(
      id,
      columnValues: columnValues(Post.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Post]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Post>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<PostUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<PostTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PostTable>? orderBy,
    _is.OrderByListBuilder<PostTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Post>(
      columnValues: columnValues(Post.t.updateTable),
      where: where(Post.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Post.t),
      orderByList: orderByList?.call(Post.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Post]s in the list and returns the deleted rows.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Post>> delete(
    _is.DatabaseSession session,
    List<Post> rows, {
    _is.OrderByBuilder<PostTable>? orderBy,
    _is.OrderByListBuilder<PostTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Post>(
      rows,
      orderBy: orderBy?.call(Post.t),
      orderByList: orderByList?.call(Post.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Post].
  Future<Post> deleteRow(
    _is.DatabaseSession session,
    Post row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Post>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Post>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<PostTable> where,
    _is.OrderByBuilder<PostTable>? orderBy,
    _is.OrderByListBuilder<PostTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Post>(
      where: where(Post.t),
      orderBy: orderBy?.call(Post.t),
      orderByList: orderByList?.call(Post.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PostTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Post>(
      where: where?.call(Post.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Post] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<PostTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Post>(
      where: where(Post.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
