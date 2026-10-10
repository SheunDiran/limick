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
import 'book_status.dart' as _i7d3z7gh;
import 'topic.dart' as _iro94j51;

/// A public-domain book from Project Gutenberg. Each book is also an
/// "account" in the feed, identified by [handle].
abstract class Book implements _is.TableRow<int?>, _is.ProtocolSerialization {
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
    this.ingestError,
    int? ingestAttempts,
    int? nextChapterPosition,
    int? nextOffset,
    int? generationFailures,
    this.lastGeneratedAt,
    this.queuedAt,
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
    String? ingestError,
    int? ingestAttempts,
    int? nextChapterPosition,
    int? nextOffset,
    int? generationFailures,
    DateTime? lastGeneratedAt,
    DateTime? queuedAt,
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
      topics: _i8uqouhs.Protocol().deserialize<List<_iro94j51.Topic>>(
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
          : _is.BoolJsonExtension.fromJson(jsonSerialization['featured']),
      popularity: jsonSerialization['popularity'] as int?,
      chapterCount: jsonSerialization['chapterCount'] as int?,
      wordCount: jsonSerialization['wordCount'] as int?,
      postCount: jsonSerialization['postCount'] as int?,
      followerCount: jsonSerialization['followerCount'] as int?,
      blurb: jsonSerialization['blurb'] as String?,
      ingestError: jsonSerialization['ingestError'] as String?,
      ingestAttempts: jsonSerialization['ingestAttempts'] as int?,
      nextChapterPosition: jsonSerialization['nextChapterPosition'] as int?,
      nextOffset: jsonSerialization['nextOffset'] as int?,
      generationFailures: jsonSerialization['generationFailures'] as int?,
      lastGeneratedAt: jsonSerialization['lastGeneratedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastGeneratedAt'],
            ),
      queuedAt: jsonSerialization['queuedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['queuedAt']),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = BookTable();

  static const db = BookRepository._();

  @override
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

  String? ingestError;

  int ingestAttempts;

  int nextChapterPosition;

  int nextOffset;

  int generationFailures;

  DateTime? lastGeneratedAt;

  DateTime? queuedAt;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Book]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
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
    String? ingestError,
    int? ingestAttempts,
    int? nextChapterPosition,
    int? nextOffset,
    int? generationFailures,
    DateTime? lastGeneratedAt,
    DateTime? queuedAt,
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
      if (ingestError != null) 'ingestError': ingestError,
      'ingestAttempts': ingestAttempts,
      'nextChapterPosition': nextChapterPosition,
      'nextOffset': nextOffset,
      'generationFailures': generationFailures,
      if (lastGeneratedAt != null) 'lastGeneratedAt': lastGeneratedAt?.toJson(),
      if (queuedAt != null) 'queuedAt': queuedAt?.toJson(),
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

  static BookInclude include() {
    return BookInclude._();
  }

  static BookIncludeList includeList({
    _is.WhereExpressionBuilder<BookTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<BookTable>? orderBy,
    _is.OrderByListBuilder<BookTable>? orderByList,
    BookInclude? include,
  }) {
    return BookIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Book.t),
      orderByList: orderByList?.call(Book.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
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
    String? ingestError,
    int? ingestAttempts,
    int? nextChapterPosition,
    int? nextOffset,
    int? generationFailures,
    DateTime? lastGeneratedAt,
    DateTime? queuedAt,
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
         ingestError: ingestError,
         ingestAttempts: ingestAttempts,
         nextChapterPosition: nextChapterPosition,
         nextOffset: nextOffset,
         generationFailures: generationFailures,
         lastGeneratedAt: lastGeneratedAt,
         queuedAt: queuedAt,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Book]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
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
    Object? ingestError = _Undefined,
    int? ingestAttempts,
    int? nextChapterPosition,
    int? nextOffset,
    int? generationFailures,
    Object? lastGeneratedAt = _Undefined,
    Object? queuedAt = _Undefined,
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
      ingestError: ingestError is String? ? ingestError : this.ingestError,
      ingestAttempts: ingestAttempts ?? this.ingestAttempts,
      nextChapterPosition: nextChapterPosition ?? this.nextChapterPosition,
      nextOffset: nextOffset ?? this.nextOffset,
      generationFailures: generationFailures ?? this.generationFailures,
      lastGeneratedAt: lastGeneratedAt is DateTime?
          ? lastGeneratedAt
          : this.lastGeneratedAt,
      queuedAt: queuedAt is DateTime? ? queuedAt : this.queuedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class BookUpdateTable extends _is.UpdateTable<BookTable> {
  BookUpdateTable(super.table);

  _is.ColumnValue<int, int> gutenbergId(int value) => _is.ColumnValue(
    table.gutenbergId,
    value,
  );

  _is.ColumnValue<String, String> title(String value) => _is.ColumnValue(
    table.title,
    value,
  );

  _is.ColumnValue<String, String> author(String value) => _is.ColumnValue(
    table.author,
    value,
  );

  _is.ColumnValue<String, String> authorYears(String? value) => _is.ColumnValue(
    table.authorYears,
    value,
  );

  _is.ColumnValue<String, String> handle(String value) => _is.ColumnValue(
    table.handle,
    value,
  );

  _is.ColumnValue<List<_iro94j51.Topic>, List<_iro94j51.Topic>> topics(
    List<_iro94j51.Topic> value,
  ) => _is.ColumnValue(
    table.topics,
    value,
  );

  _is.ColumnValue<_iro94j51.Topic, _iro94j51.Topic> primaryTopic(
    _iro94j51.Topic value,
  ) => _is.ColumnValue(
    table.primaryTopic,
    value,
  );

  _is.ColumnValue<String, String> subjects(String value) => _is.ColumnValue(
    table.subjects,
    value,
  );

  _is.ColumnValue<_i7d3z7gh.BookStatus, _i7d3z7gh.BookStatus> status(
    _i7d3z7gh.BookStatus value,
  ) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<bool, bool> featured(bool value) => _is.ColumnValue(
    table.featured,
    value,
  );

  _is.ColumnValue<int, int> popularity(int value) => _is.ColumnValue(
    table.popularity,
    value,
  );

  _is.ColumnValue<int, int> chapterCount(int value) => _is.ColumnValue(
    table.chapterCount,
    value,
  );

  _is.ColumnValue<int, int> wordCount(int value) => _is.ColumnValue(
    table.wordCount,
    value,
  );

  _is.ColumnValue<int, int> postCount(int value) => _is.ColumnValue(
    table.postCount,
    value,
  );

  _is.ColumnValue<int, int> followerCount(int value) => _is.ColumnValue(
    table.followerCount,
    value,
  );

  _is.ColumnValue<String, String> blurb(String? value) => _is.ColumnValue(
    table.blurb,
    value,
  );

  _is.ColumnValue<String, String> ingestError(String? value) => _is.ColumnValue(
    table.ingestError,
    value,
  );

  _is.ColumnValue<int, int> ingestAttempts(int value) => _is.ColumnValue(
    table.ingestAttempts,
    value,
  );

  _is.ColumnValue<int, int> nextChapterPosition(int value) => _is.ColumnValue(
    table.nextChapterPosition,
    value,
  );

  _is.ColumnValue<int, int> nextOffset(int value) => _is.ColumnValue(
    table.nextOffset,
    value,
  );

  _is.ColumnValue<int, int> generationFailures(int value) => _is.ColumnValue(
    table.generationFailures,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> lastGeneratedAt(DateTime? value) =>
      _is.ColumnValue(
        table.lastGeneratedAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> queuedAt(DateTime? value) =>
      _is.ColumnValue(
        table.queuedAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class BookTable extends _is.Table<int?> {
  BookTable({super.tableRelation}) : super(tableName: 'book') {
    updateTable = BookUpdateTable(this);
    gutenbergId = _is.ColumnInt(
      'gutenbergId',
      this,
    );
    title = _is.ColumnString(
      'title',
      this,
    );
    author = _is.ColumnString(
      'author',
      this,
    );
    authorYears = _is.ColumnString(
      'authorYears',
      this,
    );
    handle = _is.ColumnString(
      'handle',
      this,
    );
    topics = _is.ColumnSerializable<List<_iro94j51.Topic>>(
      'topics',
      this,
    );
    primaryTopic = _is.ColumnEnum(
      'primaryTopic',
      this,
      _is.EnumSerialization.byName,
    );
    subjects = _is.ColumnString(
      'subjects',
      this,
      hasDefault: true,
    );
    status = _is.ColumnEnum(
      'status',
      this,
      _is.EnumSerialization.byName,
      hasDefault: true,
    );
    featured = _is.ColumnBool(
      'featured',
      this,
      hasDefault: true,
    );
    popularity = _is.ColumnInt(
      'popularity',
      this,
      hasDefault: true,
    );
    chapterCount = _is.ColumnInt(
      'chapterCount',
      this,
      hasDefault: true,
    );
    wordCount = _is.ColumnInt(
      'wordCount',
      this,
      hasDefault: true,
    );
    postCount = _is.ColumnInt(
      'postCount',
      this,
      hasDefault: true,
    );
    followerCount = _is.ColumnInt(
      'followerCount',
      this,
      hasDefault: true,
    );
    blurb = _is.ColumnString(
      'blurb',
      this,
    );
    ingestError = _is.ColumnString(
      'ingestError',
      this,
    );
    ingestAttempts = _is.ColumnInt(
      'ingestAttempts',
      this,
      hasDefault: true,
    );
    nextChapterPosition = _is.ColumnInt(
      'nextChapterPosition',
      this,
      hasDefault: true,
    );
    nextOffset = _is.ColumnInt(
      'nextOffset',
      this,
      hasDefault: true,
    );
    generationFailures = _is.ColumnInt(
      'generationFailures',
      this,
      hasDefault: true,
    );
    lastGeneratedAt = _is.ColumnDateTime(
      'lastGeneratedAt',
      this,
    );
    queuedAt = _is.ColumnDateTime(
      'queuedAt',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final BookUpdateTable updateTable;

  late final _is.ColumnInt gutenbergId;

  late final _is.ColumnString title;

  late final _is.ColumnString author;

  late final _is.ColumnString authorYears;

  late final _is.ColumnString handle;

  late final _is.ColumnSerializable<List<_iro94j51.Topic>> topics;

  late final _is.ColumnEnum<_iro94j51.Topic> primaryTopic;

  late final _is.ColumnString subjects;

  late final _is.ColumnEnum<_i7d3z7gh.BookStatus> status;

  late final _is.ColumnBool featured;

  late final _is.ColumnInt popularity;

  late final _is.ColumnInt chapterCount;

  late final _is.ColumnInt wordCount;

  late final _is.ColumnInt postCount;

  late final _is.ColumnInt followerCount;

  late final _is.ColumnString blurb;

  late final _is.ColumnString ingestError;

  late final _is.ColumnInt ingestAttempts;

  late final _is.ColumnInt nextChapterPosition;

  late final _is.ColumnInt nextOffset;

  late final _is.ColumnInt generationFailures;

  late final _is.ColumnDateTime lastGeneratedAt;

  late final _is.ColumnDateTime queuedAt;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    gutenbergId,
    title,
    author,
    authorYears,
    handle,
    topics,
    primaryTopic,
    subjects,
    status,
    featured,
    popularity,
    chapterCount,
    wordCount,
    postCount,
    followerCount,
    blurb,
    ingestError,
    ingestAttempts,
    nextChapterPosition,
    nextOffset,
    generationFailures,
    lastGeneratedAt,
    queuedAt,
    createdAt,
  ];
}

class BookInclude extends _is.IncludeObject {
  BookInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => Book.t;
}

class BookIncludeList extends _is.IncludeList {
  BookIncludeList._({
    _is.WhereExpressionBuilder<BookTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Book.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Book.t;
}

class BookRepository {
  const BookRepository._();

  /// Returns a list of [Book]s matching the given query parameters.
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
  Future<List<Book>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<BookTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<BookTable>? orderBy,
    _is.OrderByListBuilder<BookTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Book>(
      where: where?.call(Book.t),
      orderBy: orderBy?.call(Book.t),
      orderByList: orderByList?.call(Book.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Book] matching the given query parameters.
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
  Future<Book?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<BookTable>? where,
    int? offset,
    _is.OrderByBuilder<BookTable>? orderBy,
    _is.OrderByListBuilder<BookTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Book>(
      where: where?.call(Book.t),
      orderBy: orderBy?.call(Book.t),
      orderByList: orderByList?.call(Book.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Book] by its [id] or null if no such row exists.
  Future<Book?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Book>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Book]s in the list and returns the inserted rows.
  ///
  /// The returned [Book]s will have their `id` fields set.
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
  Future<List<Book>> insert(
    _is.DatabaseSession session,
    List<Book> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Book>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Book] and returns the inserted row.
  ///
  /// The returned [Book] will have its `id` field set.
  Future<Book> insertRow(
    _is.DatabaseSession session,
    Book row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Book>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Book]s in the list and returns the resulting rows.
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
  /// The returned [Book]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Book>> upsert(
    _is.DatabaseSession session,
    List<Book> rows, {
    required _is.ColumnSelections<BookTable> conflictColumns,
    _is.ColumnSelections<BookTable>? updateColumns,
    _is.WhereExpressionBuilder<BookTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Book>(
      rows,
      conflictColumns: conflictColumns(Book.t),
      updateColumns: updateColumns?.call(Book.t),
      updateWhere: updateWhere?.call(Book.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Book] and returns the resulting row.
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
  /// The returned [Book] will have its `id` field set.
  Future<Book?> upsertRow(
    _is.DatabaseSession session,
    Book row, {
    required _is.ColumnSelections<BookTable> conflictColumns,
    _is.ColumnSelections<BookTable>? updateColumns,
    _is.WhereExpressionBuilder<BookTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Book>(
      row,
      conflictColumns: conflictColumns(Book.t),
      updateColumns: updateColumns?.call(Book.t),
      updateWhere: updateWhere?.call(Book.t),
      transaction: transaction,
    );
  }

  /// Updates all [Book]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Book>> update(
    _is.DatabaseSession session,
    List<Book> rows, {
    _is.ColumnSelections<BookTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Book>(
      rows,
      columns: columns?.call(Book.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Book]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Book> updateRow(
    _is.DatabaseSession session,
    Book row, {
    _is.ColumnSelections<BookTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Book>(
      row,
      columns: columns?.call(Book.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Book] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Book?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<BookUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Book>(
      id,
      columnValues: columnValues(Book.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Book]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Book>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<BookUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<BookTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<BookTable>? orderBy,
    _is.OrderByListBuilder<BookTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Book>(
      columnValues: columnValues(Book.t.updateTable),
      where: where(Book.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Book.t),
      orderByList: orderByList?.call(Book.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Book]s in the list and returns the deleted rows.
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
  Future<List<Book>> delete(
    _is.DatabaseSession session,
    List<Book> rows, {
    _is.OrderByBuilder<BookTable>? orderBy,
    _is.OrderByListBuilder<BookTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Book>(
      rows,
      orderBy: orderBy?.call(Book.t),
      orderByList: orderByList?.call(Book.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Book].
  Future<Book> deleteRow(
    _is.DatabaseSession session,
    Book row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Book>(
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
  Future<List<Book>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<BookTable> where,
    _is.OrderByBuilder<BookTable>? orderBy,
    _is.OrderByListBuilder<BookTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Book>(
      where: where(Book.t),
      orderBy: orderBy?.call(Book.t),
      orderByList: orderByList?.call(Book.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<BookTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Book>(
      where: where?.call(Book.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Book] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<BookTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Book>(
      where: where(Book.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
