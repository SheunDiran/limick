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

abstract class BookFollow
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  BookFollow._({
    this.id,
    required this.profileId,
    required this.bookId,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory BookFollow({
    int? id,
    required int profileId,
    required int bookId,
    DateTime? createdAt,
  }) = _BookFollowImpl;

  factory BookFollow.fromJson(Map<String, dynamic> jsonSerialization) {
    return BookFollow(
      id: jsonSerialization['id'] as int?,
      profileId: jsonSerialization['profileId'] as int,
      bookId: jsonSerialization['bookId'] as int,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = BookFollowTable();

  static const db = BookFollowRepository._();

  @override
  int? id;

  int profileId;

  int bookId;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [BookFollow]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  BookFollow copyWith({
    int? id,
    int? profileId,
    int? bookId,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BookFollow',
      if (id != null) 'id': id,
      'profileId': profileId,
      'bookId': bookId,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'BookFollow',
      if (id != null) 'id': id,
      'profileId': profileId,
      'bookId': bookId,
      'createdAt': createdAt.toJson(),
    };
  }

  static BookFollowInclude include() {
    return BookFollowInclude._();
  }

  static BookFollowIncludeList includeList({
    _is.WhereExpressionBuilder<BookFollowTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<BookFollowTable>? orderBy,
    _is.OrderByListBuilder<BookFollowTable>? orderByList,
    BookFollowInclude? include,
  }) {
    return BookFollowIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(BookFollow.t),
      orderByList: orderByList?.call(BookFollow.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BookFollowImpl extends BookFollow {
  _BookFollowImpl({
    int? id,
    required int profileId,
    required int bookId,
    DateTime? createdAt,
  }) : super._(
         id: id,
         profileId: profileId,
         bookId: bookId,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [BookFollow]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  BookFollow copyWith({
    Object? id = _Undefined,
    int? profileId,
    int? bookId,
    DateTime? createdAt,
  }) {
    return BookFollow(
      id: id is int? ? id : this.id,
      profileId: profileId ?? this.profileId,
      bookId: bookId ?? this.bookId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class BookFollowUpdateTable extends _is.UpdateTable<BookFollowTable> {
  BookFollowUpdateTable(super.table);

  _is.ColumnValue<int, int> profileId(int value) => _is.ColumnValue(
    table.profileId,
    value,
  );

  _is.ColumnValue<int, int> bookId(int value) => _is.ColumnValue(
    table.bookId,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class BookFollowTable extends _is.Table<int?> {
  BookFollowTable({super.tableRelation}) : super(tableName: 'book_follow') {
    updateTable = BookFollowUpdateTable(this);
    profileId = _is.ColumnInt(
      'profileId',
      this,
    );
    bookId = _is.ColumnInt(
      'bookId',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final BookFollowUpdateTable updateTable;

  late final _is.ColumnInt profileId;

  late final _is.ColumnInt bookId;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    profileId,
    bookId,
    createdAt,
  ];
}

class BookFollowInclude extends _is.IncludeObject {
  BookFollowInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => BookFollow.t;
}

class BookFollowIncludeList extends _is.IncludeList {
  BookFollowIncludeList._({
    _is.WhereExpressionBuilder<BookFollowTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(BookFollow.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => BookFollow.t;
}

class BookFollowRepository {
  const BookFollowRepository._();

  /// Returns a list of [BookFollow]s matching the given query parameters.
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
  Future<List<BookFollow>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<BookFollowTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<BookFollowTable>? orderBy,
    _is.OrderByListBuilder<BookFollowTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<BookFollow>(
      where: where?.call(BookFollow.t),
      orderBy: orderBy?.call(BookFollow.t),
      orderByList: orderByList?.call(BookFollow.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [BookFollow] matching the given query parameters.
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
  Future<BookFollow?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<BookFollowTable>? where,
    int? offset,
    _is.OrderByBuilder<BookFollowTable>? orderBy,
    _is.OrderByListBuilder<BookFollowTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<BookFollow>(
      where: where?.call(BookFollow.t),
      orderBy: orderBy?.call(BookFollow.t),
      orderByList: orderByList?.call(BookFollow.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [BookFollow] by its [id] or null if no such row exists.
  Future<BookFollow?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<BookFollow>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [BookFollow]s in the list and returns the inserted rows.
  ///
  /// The returned [BookFollow]s will have their `id` fields set.
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
  Future<List<BookFollow>> insert(
    _is.DatabaseSession session,
    List<BookFollow> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<BookFollow>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [BookFollow] and returns the inserted row.
  ///
  /// The returned [BookFollow] will have its `id` field set.
  Future<BookFollow> insertRow(
    _is.DatabaseSession session,
    BookFollow row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<BookFollow>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [BookFollow]s in the list and returns the resulting rows.
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
  /// The returned [BookFollow]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<BookFollow>> upsert(
    _is.DatabaseSession session,
    List<BookFollow> rows, {
    required _is.ColumnSelections<BookFollowTable> conflictColumns,
    _is.ColumnSelections<BookFollowTable>? updateColumns,
    _is.WhereExpressionBuilder<BookFollowTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<BookFollow>(
      rows,
      conflictColumns: conflictColumns(BookFollow.t),
      updateColumns: updateColumns?.call(BookFollow.t),
      updateWhere: updateWhere?.call(BookFollow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [BookFollow] and returns the resulting row.
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
  /// The returned [BookFollow] will have its `id` field set.
  Future<BookFollow?> upsertRow(
    _is.DatabaseSession session,
    BookFollow row, {
    required _is.ColumnSelections<BookFollowTable> conflictColumns,
    _is.ColumnSelections<BookFollowTable>? updateColumns,
    _is.WhereExpressionBuilder<BookFollowTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<BookFollow>(
      row,
      conflictColumns: conflictColumns(BookFollow.t),
      updateColumns: updateColumns?.call(BookFollow.t),
      updateWhere: updateWhere?.call(BookFollow.t),
      transaction: transaction,
    );
  }

  /// Updates all [BookFollow]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<BookFollow>> update(
    _is.DatabaseSession session,
    List<BookFollow> rows, {
    _is.ColumnSelections<BookFollowTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<BookFollow>(
      rows,
      columns: columns?.call(BookFollow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [BookFollow]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<BookFollow> updateRow(
    _is.DatabaseSession session,
    BookFollow row, {
    _is.ColumnSelections<BookFollowTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<BookFollow>(
      row,
      columns: columns?.call(BookFollow.t),
      transaction: transaction,
    );
  }

  /// Updates a single [BookFollow] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<BookFollow?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<BookFollowUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<BookFollow>(
      id,
      columnValues: columnValues(BookFollow.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [BookFollow]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<BookFollow>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<BookFollowUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<BookFollowTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<BookFollowTable>? orderBy,
    _is.OrderByListBuilder<BookFollowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<BookFollow>(
      columnValues: columnValues(BookFollow.t.updateTable),
      where: where(BookFollow.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(BookFollow.t),
      orderByList: orderByList?.call(BookFollow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [BookFollow]s in the list and returns the deleted rows.
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
  Future<List<BookFollow>> delete(
    _is.DatabaseSession session,
    List<BookFollow> rows, {
    _is.OrderByBuilder<BookFollowTable>? orderBy,
    _is.OrderByListBuilder<BookFollowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<BookFollow>(
      rows,
      orderBy: orderBy?.call(BookFollow.t),
      orderByList: orderByList?.call(BookFollow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [BookFollow].
  Future<BookFollow> deleteRow(
    _is.DatabaseSession session,
    BookFollow row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<BookFollow>(
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
  Future<List<BookFollow>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<BookFollowTable> where,
    _is.OrderByBuilder<BookFollowTable>? orderBy,
    _is.OrderByListBuilder<BookFollowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<BookFollow>(
      where: where(BookFollow.t),
      orderBy: orderBy?.call(BookFollow.t),
      orderByList: orderByList?.call(BookFollow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<BookFollowTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<BookFollow>(
      where: where?.call(BookFollow.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [BookFollow] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<BookFollowTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<BookFollow>(
      where: where(BookFollow.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
