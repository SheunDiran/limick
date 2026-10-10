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

abstract class ReadingProgress
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
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
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = ReadingProgressTable();

  static const db = ReadingProgressRepository._();

  @override
  int? id;

  int profileId;

  int bookId;

  int chapterPosition;

  double scrollFraction;

  DateTime updatedAt;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [ReadingProgress]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
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

  static ReadingProgressInclude include() {
    return ReadingProgressInclude._();
  }

  static ReadingProgressIncludeList includeList({
    _is.WhereExpressionBuilder<ReadingProgressTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ReadingProgressTable>? orderBy,
    _is.OrderByListBuilder<ReadingProgressTable>? orderByList,
    ReadingProgressInclude? include,
  }) {
    return ReadingProgressIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ReadingProgress.t),
      orderByList: orderByList?.call(ReadingProgress.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
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
  @_is.useResult
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

class ReadingProgressUpdateTable extends _is.UpdateTable<ReadingProgressTable> {
  ReadingProgressUpdateTable(super.table);

  _is.ColumnValue<int, int> profileId(int value) => _is.ColumnValue(
    table.profileId,
    value,
  );

  _is.ColumnValue<int, int> bookId(int value) => _is.ColumnValue(
    table.bookId,
    value,
  );

  _is.ColumnValue<int, int> chapterPosition(int value) => _is.ColumnValue(
    table.chapterPosition,
    value,
  );

  _is.ColumnValue<double, double> scrollFraction(double value) =>
      _is.ColumnValue(
        table.scrollFraction,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _is.ColumnValue(
        table.updatedAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class ReadingProgressTable extends _is.Table<int?> {
  ReadingProgressTable({super.tableRelation})
    : super(tableName: 'reading_progress') {
    updateTable = ReadingProgressUpdateTable(this);
    profileId = _is.ColumnInt(
      'profileId',
      this,
    );
    bookId = _is.ColumnInt(
      'bookId',
      this,
    );
    chapterPosition = _is.ColumnInt(
      'chapterPosition',
      this,
    );
    scrollFraction = _is.ColumnDouble(
      'scrollFraction',
      this,
      hasDefault: true,
    );
    updatedAt = _is.ColumnDateTime(
      'updatedAt',
      this,
      hasDefault: true,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final ReadingProgressUpdateTable updateTable;

  late final _is.ColumnInt profileId;

  late final _is.ColumnInt bookId;

  late final _is.ColumnInt chapterPosition;

  late final _is.ColumnDouble scrollFraction;

  late final _is.ColumnDateTime updatedAt;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    profileId,
    bookId,
    chapterPosition,
    scrollFraction,
    updatedAt,
    createdAt,
  ];
}

class ReadingProgressInclude extends _is.IncludeObject {
  ReadingProgressInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => ReadingProgress.t;
}

class ReadingProgressIncludeList extends _is.IncludeList {
  ReadingProgressIncludeList._({
    _is.WhereExpressionBuilder<ReadingProgressTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ReadingProgress.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => ReadingProgress.t;
}

class ReadingProgressRepository {
  const ReadingProgressRepository._();

  /// Returns a list of [ReadingProgress]s matching the given query parameters.
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
  Future<List<ReadingProgress>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ReadingProgressTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ReadingProgressTable>? orderBy,
    _is.OrderByListBuilder<ReadingProgressTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ReadingProgress>(
      where: where?.call(ReadingProgress.t),
      orderBy: orderBy?.call(ReadingProgress.t),
      orderByList: orderByList?.call(ReadingProgress.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ReadingProgress] matching the given query parameters.
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
  Future<ReadingProgress?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ReadingProgressTable>? where,
    int? offset,
    _is.OrderByBuilder<ReadingProgressTable>? orderBy,
    _is.OrderByListBuilder<ReadingProgressTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ReadingProgress>(
      where: where?.call(ReadingProgress.t),
      orderBy: orderBy?.call(ReadingProgress.t),
      orderByList: orderByList?.call(ReadingProgress.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ReadingProgress] by its [id] or null if no such row exists.
  Future<ReadingProgress?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ReadingProgress>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ReadingProgress]s in the list and returns the inserted rows.
  ///
  /// The returned [ReadingProgress]s will have their `id` fields set.
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
  Future<List<ReadingProgress>> insert(
    _is.DatabaseSession session,
    List<ReadingProgress> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<ReadingProgress>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [ReadingProgress] and returns the inserted row.
  ///
  /// The returned [ReadingProgress] will have its `id` field set.
  Future<ReadingProgress> insertRow(
    _is.DatabaseSession session,
    ReadingProgress row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<ReadingProgress>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [ReadingProgress]s in the list and returns the resulting rows.
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
  /// The returned [ReadingProgress]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ReadingProgress>> upsert(
    _is.DatabaseSession session,
    List<ReadingProgress> rows, {
    required _is.ColumnSelections<ReadingProgressTable> conflictColumns,
    _is.ColumnSelections<ReadingProgressTable>? updateColumns,
    _is.WhereExpressionBuilder<ReadingProgressTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<ReadingProgress>(
      rows,
      conflictColumns: conflictColumns(ReadingProgress.t),
      updateColumns: updateColumns?.call(ReadingProgress.t),
      updateWhere: updateWhere?.call(ReadingProgress.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [ReadingProgress] and returns the resulting row.
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
  /// The returned [ReadingProgress] will have its `id` field set.
  Future<ReadingProgress?> upsertRow(
    _is.DatabaseSession session,
    ReadingProgress row, {
    required _is.ColumnSelections<ReadingProgressTable> conflictColumns,
    _is.ColumnSelections<ReadingProgressTable>? updateColumns,
    _is.WhereExpressionBuilder<ReadingProgressTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<ReadingProgress>(
      row,
      conflictColumns: conflictColumns(ReadingProgress.t),
      updateColumns: updateColumns?.call(ReadingProgress.t),
      updateWhere: updateWhere?.call(ReadingProgress.t),
      transaction: transaction,
    );
  }

  /// Updates all [ReadingProgress]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ReadingProgress>> update(
    _is.DatabaseSession session,
    List<ReadingProgress> rows, {
    _is.ColumnSelections<ReadingProgressTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<ReadingProgress>(
      rows,
      columns: columns?.call(ReadingProgress.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [ReadingProgress]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ReadingProgress> updateRow(
    _is.DatabaseSession session,
    ReadingProgress row, {
    _is.ColumnSelections<ReadingProgressTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<ReadingProgress>(
      row,
      columns: columns?.call(ReadingProgress.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ReadingProgress] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ReadingProgress?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ReadingProgressUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<ReadingProgress>(
      id,
      columnValues: columnValues(ReadingProgress.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ReadingProgress]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ReadingProgress>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ReadingProgressUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<ReadingProgressTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ReadingProgressTable>? orderBy,
    _is.OrderByListBuilder<ReadingProgressTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<ReadingProgress>(
      columnValues: columnValues(ReadingProgress.t.updateTable),
      where: where(ReadingProgress.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ReadingProgress.t),
      orderByList: orderByList?.call(ReadingProgress.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [ReadingProgress]s in the list and returns the deleted rows.
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
  Future<List<ReadingProgress>> delete(
    _is.DatabaseSession session,
    List<ReadingProgress> rows, {
    _is.OrderByBuilder<ReadingProgressTable>? orderBy,
    _is.OrderByListBuilder<ReadingProgressTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<ReadingProgress>(
      rows,
      orderBy: orderBy?.call(ReadingProgress.t),
      orderByList: orderByList?.call(ReadingProgress.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [ReadingProgress].
  Future<ReadingProgress> deleteRow(
    _is.DatabaseSession session,
    ReadingProgress row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ReadingProgress>(
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
  Future<List<ReadingProgress>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ReadingProgressTable> where,
    _is.OrderByBuilder<ReadingProgressTable>? orderBy,
    _is.OrderByListBuilder<ReadingProgressTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<ReadingProgress>(
      where: where(ReadingProgress.t),
      orderBy: orderBy?.call(ReadingProgress.t),
      orderByList: orderByList?.call(ReadingProgress.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ReadingProgressTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<ReadingProgress>(
      where: where?.call(ReadingProgress.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ReadingProgress] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ReadingProgressTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ReadingProgress>(
      where: where(ReadingProgress.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
