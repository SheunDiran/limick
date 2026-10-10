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
import 'package:serverpod/serverpod.dart' as _is;

/// A word in the user's word bank, reviewed with a simple Leitner schedule.
abstract class SavedWord
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
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
      dueAt: _is.DateTimeJsonExtension.fromJson(jsonSerialization['dueAt']),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = SavedWordTable();

  static const db = SavedWordRepository._();

  @override
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

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [SavedWord]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
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

  static SavedWordInclude include() {
    return SavedWordInclude._();
  }

  static SavedWordIncludeList includeList({
    _is.WhereExpressionBuilder<SavedWordTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SavedWordTable>? orderBy,
    _is.OrderByListBuilder<SavedWordTable>? orderByList,
    SavedWordInclude? include,
  }) {
    return SavedWordIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SavedWord.t),
      orderByList: orderByList?.call(SavedWord.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
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
  @_is.useResult
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

class SavedWordUpdateTable extends _is.UpdateTable<SavedWordTable> {
  SavedWordUpdateTable(super.table);

  _is.ColumnValue<int, int> profileId(int value) => _is.ColumnValue(
    table.profileId,
    value,
  );

  _is.ColumnValue<String, String> word(String value) => _is.ColumnValue(
    table.word,
    value,
  );

  _is.ColumnValue<String, String> definition(String value) => _is.ColumnValue(
    table.definition,
    value,
  );

  _is.ColumnValue<String, String> partOfSpeech(String value) => _is.ColumnValue(
    table.partOfSpeech,
    value,
  );

  _is.ColumnValue<String, String> example(String? value) => _is.ColumnValue(
    table.example,
    value,
  );

  _is.ColumnValue<String, String> bookTitle(String? value) => _is.ColumnValue(
    table.bookTitle,
    value,
  );

  _is.ColumnValue<int, int> postId(int? value) => _is.ColumnValue(
    table.postId,
    value,
  );

  _is.ColumnValue<int, int> box(int value) => _is.ColumnValue(
    table.box,
    value,
  );

  _is.ColumnValue<int, int> reviewCount(int value) => _is.ColumnValue(
    table.reviewCount,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> dueAt(DateTime value) => _is.ColumnValue(
    table.dueAt,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class SavedWordTable extends _is.Table<int?> {
  SavedWordTable({super.tableRelation}) : super(tableName: 'saved_word') {
    updateTable = SavedWordUpdateTable(this);
    profileId = _is.ColumnInt(
      'profileId',
      this,
    );
    word = _is.ColumnString(
      'word',
      this,
    );
    definition = _is.ColumnString(
      'definition',
      this,
    );
    partOfSpeech = _is.ColumnString(
      'partOfSpeech',
      this,
      hasDefault: true,
    );
    example = _is.ColumnString(
      'example',
      this,
    );
    bookTitle = _is.ColumnString(
      'bookTitle',
      this,
    );
    postId = _is.ColumnInt(
      'postId',
      this,
    );
    box = _is.ColumnInt(
      'box',
      this,
      hasDefault: true,
    );
    reviewCount = _is.ColumnInt(
      'reviewCount',
      this,
      hasDefault: true,
    );
    dueAt = _is.ColumnDateTime(
      'dueAt',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final SavedWordUpdateTable updateTable;

  late final _is.ColumnInt profileId;

  late final _is.ColumnString word;

  late final _is.ColumnString definition;

  late final _is.ColumnString partOfSpeech;

  late final _is.ColumnString example;

  late final _is.ColumnString bookTitle;

  late final _is.ColumnInt postId;

  late final _is.ColumnInt box;

  late final _is.ColumnInt reviewCount;

  late final _is.ColumnDateTime dueAt;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    profileId,
    word,
    definition,
    partOfSpeech,
    example,
    bookTitle,
    postId,
    box,
    reviewCount,
    dueAt,
    createdAt,
  ];
}

class SavedWordInclude extends _is.IncludeObject {
  SavedWordInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => SavedWord.t;
}

class SavedWordIncludeList extends _is.IncludeList {
  SavedWordIncludeList._({
    _is.WhereExpressionBuilder<SavedWordTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SavedWord.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => SavedWord.t;
}

class SavedWordRepository {
  const SavedWordRepository._();

  /// Returns a list of [SavedWord]s matching the given query parameters.
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
  Future<List<SavedWord>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SavedWordTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SavedWordTable>? orderBy,
    _is.OrderByListBuilder<SavedWordTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SavedWord>(
      where: where?.call(SavedWord.t),
      orderBy: orderBy?.call(SavedWord.t),
      orderByList: orderByList?.call(SavedWord.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [SavedWord] matching the given query parameters.
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
  Future<SavedWord?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SavedWordTable>? where,
    int? offset,
    _is.OrderByBuilder<SavedWordTable>? orderBy,
    _is.OrderByListBuilder<SavedWordTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SavedWord>(
      where: where?.call(SavedWord.t),
      orderBy: orderBy?.call(SavedWord.t),
      orderByList: orderByList?.call(SavedWord.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SavedWord] by its [id] or null if no such row exists.
  Future<SavedWord?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<SavedWord>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [SavedWord]s in the list and returns the inserted rows.
  ///
  /// The returned [SavedWord]s will have their `id` fields set.
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
  Future<List<SavedWord>> insert(
    _is.DatabaseSession session,
    List<SavedWord> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<SavedWord>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [SavedWord] and returns the inserted row.
  ///
  /// The returned [SavedWord] will have its `id` field set.
  Future<SavedWord> insertRow(
    _is.DatabaseSession session,
    SavedWord row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<SavedWord>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [SavedWord]s in the list and returns the resulting rows.
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
  /// The returned [SavedWord]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SavedWord>> upsert(
    _is.DatabaseSession session,
    List<SavedWord> rows, {
    required _is.ColumnSelections<SavedWordTable> conflictColumns,
    _is.ColumnSelections<SavedWordTable>? updateColumns,
    _is.WhereExpressionBuilder<SavedWordTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<SavedWord>(
      rows,
      conflictColumns: conflictColumns(SavedWord.t),
      updateColumns: updateColumns?.call(SavedWord.t),
      updateWhere: updateWhere?.call(SavedWord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [SavedWord] and returns the resulting row.
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
  /// The returned [SavedWord] will have its `id` field set.
  Future<SavedWord?> upsertRow(
    _is.DatabaseSession session,
    SavedWord row, {
    required _is.ColumnSelections<SavedWordTable> conflictColumns,
    _is.ColumnSelections<SavedWordTable>? updateColumns,
    _is.WhereExpressionBuilder<SavedWordTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<SavedWord>(
      row,
      conflictColumns: conflictColumns(SavedWord.t),
      updateColumns: updateColumns?.call(SavedWord.t),
      updateWhere: updateWhere?.call(SavedWord.t),
      transaction: transaction,
    );
  }

  /// Updates all [SavedWord]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SavedWord>> update(
    _is.DatabaseSession session,
    List<SavedWord> rows, {
    _is.ColumnSelections<SavedWordTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<SavedWord>(
      rows,
      columns: columns?.call(SavedWord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [SavedWord]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SavedWord> updateRow(
    _is.DatabaseSession session,
    SavedWord row, {
    _is.ColumnSelections<SavedWordTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<SavedWord>(
      row,
      columns: columns?.call(SavedWord.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SavedWord] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SavedWord?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<SavedWordUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<SavedWord>(
      id,
      columnValues: columnValues(SavedWord.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SavedWord]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SavedWord>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<SavedWordUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<SavedWordTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SavedWordTable>? orderBy,
    _is.OrderByListBuilder<SavedWordTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<SavedWord>(
      columnValues: columnValues(SavedWord.t.updateTable),
      where: where(SavedWord.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SavedWord.t),
      orderByList: orderByList?.call(SavedWord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [SavedWord]s in the list and returns the deleted rows.
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
  Future<List<SavedWord>> delete(
    _is.DatabaseSession session,
    List<SavedWord> rows, {
    _is.OrderByBuilder<SavedWordTable>? orderBy,
    _is.OrderByListBuilder<SavedWordTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<SavedWord>(
      rows,
      orderBy: orderBy?.call(SavedWord.t),
      orderByList: orderByList?.call(SavedWord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [SavedWord].
  Future<SavedWord> deleteRow(
    _is.DatabaseSession session,
    SavedWord row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SavedWord>(
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
  Future<List<SavedWord>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SavedWordTable> where,
    _is.OrderByBuilder<SavedWordTable>? orderBy,
    _is.OrderByListBuilder<SavedWordTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<SavedWord>(
      where: where(SavedWord.t),
      orderBy: orderBy?.call(SavedWord.t),
      orderByList: orderByList?.call(SavedWord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SavedWordTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<SavedWord>(
      where: where?.call(SavedWord.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SavedWord] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SavedWordTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SavedWord>(
      where: where(SavedWord.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
