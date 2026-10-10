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

abstract class BookAffinity
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
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
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = BookAffinityTable();

  static const db = BookAffinityRepository._();

  @override
  int? id;

  int profileId;

  int bookId;

  double score;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [BookAffinity]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
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

  static BookAffinityInclude include() {
    return BookAffinityInclude._();
  }

  static BookAffinityIncludeList includeList({
    _is.WhereExpressionBuilder<BookAffinityTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<BookAffinityTable>? orderBy,
    _is.OrderByListBuilder<BookAffinityTable>? orderByList,
    BookAffinityInclude? include,
  }) {
    return BookAffinityIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(BookAffinity.t),
      orderByList: orderByList?.call(BookAffinity.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
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
  @_is.useResult
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

class BookAffinityUpdateTable extends _is.UpdateTable<BookAffinityTable> {
  BookAffinityUpdateTable(super.table);

  _is.ColumnValue<int, int> profileId(int value) => _is.ColumnValue(
    table.profileId,
    value,
  );

  _is.ColumnValue<int, int> bookId(int value) => _is.ColumnValue(
    table.bookId,
    value,
  );

  _is.ColumnValue<double, double> score(double value) => _is.ColumnValue(
    table.score,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class BookAffinityTable extends _is.Table<int?> {
  BookAffinityTable({super.tableRelation}) : super(tableName: 'book_affinity') {
    updateTable = BookAffinityUpdateTable(this);
    profileId = _is.ColumnInt(
      'profileId',
      this,
    );
    bookId = _is.ColumnInt(
      'bookId',
      this,
    );
    score = _is.ColumnDouble(
      'score',
      this,
      hasDefault: true,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final BookAffinityUpdateTable updateTable;

  late final _is.ColumnInt profileId;

  late final _is.ColumnInt bookId;

  late final _is.ColumnDouble score;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    profileId,
    bookId,
    score,
    createdAt,
  ];
}

class BookAffinityInclude extends _is.IncludeObject {
  BookAffinityInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => BookAffinity.t;
}

class BookAffinityIncludeList extends _is.IncludeList {
  BookAffinityIncludeList._({
    _is.WhereExpressionBuilder<BookAffinityTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(BookAffinity.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => BookAffinity.t;
}

class BookAffinityRepository {
  const BookAffinityRepository._();

  /// Returns a list of [BookAffinity]s matching the given query parameters.
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
  Future<List<BookAffinity>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<BookAffinityTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<BookAffinityTable>? orderBy,
    _is.OrderByListBuilder<BookAffinityTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<BookAffinity>(
      where: where?.call(BookAffinity.t),
      orderBy: orderBy?.call(BookAffinity.t),
      orderByList: orderByList?.call(BookAffinity.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [BookAffinity] matching the given query parameters.
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
  Future<BookAffinity?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<BookAffinityTable>? where,
    int? offset,
    _is.OrderByBuilder<BookAffinityTable>? orderBy,
    _is.OrderByListBuilder<BookAffinityTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<BookAffinity>(
      where: where?.call(BookAffinity.t),
      orderBy: orderBy?.call(BookAffinity.t),
      orderByList: orderByList?.call(BookAffinity.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [BookAffinity] by its [id] or null if no such row exists.
  Future<BookAffinity?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<BookAffinity>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [BookAffinity]s in the list and returns the inserted rows.
  ///
  /// The returned [BookAffinity]s will have their `id` fields set.
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
  Future<List<BookAffinity>> insert(
    _is.DatabaseSession session,
    List<BookAffinity> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<BookAffinity>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [BookAffinity] and returns the inserted row.
  ///
  /// The returned [BookAffinity] will have its `id` field set.
  Future<BookAffinity> insertRow(
    _is.DatabaseSession session,
    BookAffinity row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<BookAffinity>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [BookAffinity]s in the list and returns the resulting rows.
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
  /// The returned [BookAffinity]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<BookAffinity>> upsert(
    _is.DatabaseSession session,
    List<BookAffinity> rows, {
    required _is.ColumnSelections<BookAffinityTable> conflictColumns,
    _is.ColumnSelections<BookAffinityTable>? updateColumns,
    _is.WhereExpressionBuilder<BookAffinityTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<BookAffinity>(
      rows,
      conflictColumns: conflictColumns(BookAffinity.t),
      updateColumns: updateColumns?.call(BookAffinity.t),
      updateWhere: updateWhere?.call(BookAffinity.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [BookAffinity] and returns the resulting row.
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
  /// The returned [BookAffinity] will have its `id` field set.
  Future<BookAffinity?> upsertRow(
    _is.DatabaseSession session,
    BookAffinity row, {
    required _is.ColumnSelections<BookAffinityTable> conflictColumns,
    _is.ColumnSelections<BookAffinityTable>? updateColumns,
    _is.WhereExpressionBuilder<BookAffinityTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<BookAffinity>(
      row,
      conflictColumns: conflictColumns(BookAffinity.t),
      updateColumns: updateColumns?.call(BookAffinity.t),
      updateWhere: updateWhere?.call(BookAffinity.t),
      transaction: transaction,
    );
  }

  /// Updates all [BookAffinity]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<BookAffinity>> update(
    _is.DatabaseSession session,
    List<BookAffinity> rows, {
    _is.ColumnSelections<BookAffinityTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<BookAffinity>(
      rows,
      columns: columns?.call(BookAffinity.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [BookAffinity]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<BookAffinity> updateRow(
    _is.DatabaseSession session,
    BookAffinity row, {
    _is.ColumnSelections<BookAffinityTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<BookAffinity>(
      row,
      columns: columns?.call(BookAffinity.t),
      transaction: transaction,
    );
  }

  /// Updates a single [BookAffinity] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<BookAffinity?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<BookAffinityUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<BookAffinity>(
      id,
      columnValues: columnValues(BookAffinity.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [BookAffinity]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<BookAffinity>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<BookAffinityUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<BookAffinityTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<BookAffinityTable>? orderBy,
    _is.OrderByListBuilder<BookAffinityTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<BookAffinity>(
      columnValues: columnValues(BookAffinity.t.updateTable),
      where: where(BookAffinity.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(BookAffinity.t),
      orderByList: orderByList?.call(BookAffinity.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [BookAffinity]s in the list and returns the deleted rows.
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
  Future<List<BookAffinity>> delete(
    _is.DatabaseSession session,
    List<BookAffinity> rows, {
    _is.OrderByBuilder<BookAffinityTable>? orderBy,
    _is.OrderByListBuilder<BookAffinityTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<BookAffinity>(
      rows,
      orderBy: orderBy?.call(BookAffinity.t),
      orderByList: orderByList?.call(BookAffinity.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [BookAffinity].
  Future<BookAffinity> deleteRow(
    _is.DatabaseSession session,
    BookAffinity row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<BookAffinity>(
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
  Future<List<BookAffinity>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<BookAffinityTable> where,
    _is.OrderByBuilder<BookAffinityTable>? orderBy,
    _is.OrderByListBuilder<BookAffinityTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<BookAffinity>(
      where: where(BookAffinity.t),
      orderBy: orderBy?.call(BookAffinity.t),
      orderByList: orderByList?.call(BookAffinity.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<BookAffinityTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<BookAffinity>(
      where: where?.call(BookAffinity.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [BookAffinity] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<BookAffinityTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<BookAffinity>(
      where: where(BookAffinity.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
