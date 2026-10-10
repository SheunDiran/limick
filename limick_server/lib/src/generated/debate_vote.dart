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

abstract class DebateVote
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  DebateVote._({
    this.id,
    required this.profileId,
    required this.postId,
    required this.agree,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory DebateVote({
    int? id,
    required int profileId,
    required int postId,
    required bool agree,
    DateTime? createdAt,
  }) = _DebateVoteImpl;

  factory DebateVote.fromJson(Map<String, dynamic> jsonSerialization) {
    return DebateVote(
      id: jsonSerialization['id'] as int?,
      profileId: jsonSerialization['profileId'] as int,
      postId: jsonSerialization['postId'] as int,
      agree: _is.BoolJsonExtension.fromJson(jsonSerialization['agree']),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = DebateVoteTable();

  static const db = DebateVoteRepository._();

  @override
  int? id;

  int profileId;

  int postId;

  bool agree;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [DebateVote]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  DebateVote copyWith({
    int? id,
    int? profileId,
    int? postId,
    bool? agree,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DebateVote',
      if (id != null) 'id': id,
      'profileId': profileId,
      'postId': postId,
      'agree': agree,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DebateVote',
      if (id != null) 'id': id,
      'profileId': profileId,
      'postId': postId,
      'agree': agree,
      'createdAt': createdAt.toJson(),
    };
  }

  static DebateVoteInclude include() {
    return DebateVoteInclude._();
  }

  static DebateVoteIncludeList includeList({
    _is.WhereExpressionBuilder<DebateVoteTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<DebateVoteTable>? orderBy,
    _is.OrderByListBuilder<DebateVoteTable>? orderByList,
    DebateVoteInclude? include,
  }) {
    return DebateVoteIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DebateVote.t),
      orderByList: orderByList?.call(DebateVote.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DebateVoteImpl extends DebateVote {
  _DebateVoteImpl({
    int? id,
    required int profileId,
    required int postId,
    required bool agree,
    DateTime? createdAt,
  }) : super._(
         id: id,
         profileId: profileId,
         postId: postId,
         agree: agree,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [DebateVote]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  DebateVote copyWith({
    Object? id = _Undefined,
    int? profileId,
    int? postId,
    bool? agree,
    DateTime? createdAt,
  }) {
    return DebateVote(
      id: id is int? ? id : this.id,
      profileId: profileId ?? this.profileId,
      postId: postId ?? this.postId,
      agree: agree ?? this.agree,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class DebateVoteUpdateTable extends _is.UpdateTable<DebateVoteTable> {
  DebateVoteUpdateTable(super.table);

  _is.ColumnValue<int, int> profileId(int value) => _is.ColumnValue(
    table.profileId,
    value,
  );

  _is.ColumnValue<int, int> postId(int value) => _is.ColumnValue(
    table.postId,
    value,
  );

  _is.ColumnValue<bool, bool> agree(bool value) => _is.ColumnValue(
    table.agree,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class DebateVoteTable extends _is.Table<int?> {
  DebateVoteTable({super.tableRelation}) : super(tableName: 'debate_vote') {
    updateTable = DebateVoteUpdateTable(this);
    profileId = _is.ColumnInt(
      'profileId',
      this,
    );
    postId = _is.ColumnInt(
      'postId',
      this,
    );
    agree = _is.ColumnBool(
      'agree',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final DebateVoteUpdateTable updateTable;

  late final _is.ColumnInt profileId;

  late final _is.ColumnInt postId;

  late final _is.ColumnBool agree;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    profileId,
    postId,
    agree,
    createdAt,
  ];
}

class DebateVoteInclude extends _is.IncludeObject {
  DebateVoteInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => DebateVote.t;
}

class DebateVoteIncludeList extends _is.IncludeList {
  DebateVoteIncludeList._({
    _is.WhereExpressionBuilder<DebateVoteTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(DebateVote.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => DebateVote.t;
}

class DebateVoteRepository {
  const DebateVoteRepository._();

  /// Returns a list of [DebateVote]s matching the given query parameters.
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
  Future<List<DebateVote>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<DebateVoteTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<DebateVoteTable>? orderBy,
    _is.OrderByListBuilder<DebateVoteTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<DebateVote>(
      where: where?.call(DebateVote.t),
      orderBy: orderBy?.call(DebateVote.t),
      orderByList: orderByList?.call(DebateVote.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [DebateVote] matching the given query parameters.
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
  Future<DebateVote?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<DebateVoteTable>? where,
    int? offset,
    _is.OrderByBuilder<DebateVoteTable>? orderBy,
    _is.OrderByListBuilder<DebateVoteTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<DebateVote>(
      where: where?.call(DebateVote.t),
      orderBy: orderBy?.call(DebateVote.t),
      orderByList: orderByList?.call(DebateVote.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [DebateVote] by its [id] or null if no such row exists.
  Future<DebateVote?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<DebateVote>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [DebateVote]s in the list and returns the inserted rows.
  ///
  /// The returned [DebateVote]s will have their `id` fields set.
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
  Future<List<DebateVote>> insert(
    _is.DatabaseSession session,
    List<DebateVote> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<DebateVote>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [DebateVote] and returns the inserted row.
  ///
  /// The returned [DebateVote] will have its `id` field set.
  Future<DebateVote> insertRow(
    _is.DatabaseSession session,
    DebateVote row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<DebateVote>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [DebateVote]s in the list and returns the resulting rows.
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
  /// The returned [DebateVote]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<DebateVote>> upsert(
    _is.DatabaseSession session,
    List<DebateVote> rows, {
    required _is.ColumnSelections<DebateVoteTable> conflictColumns,
    _is.ColumnSelections<DebateVoteTable>? updateColumns,
    _is.WhereExpressionBuilder<DebateVoteTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<DebateVote>(
      rows,
      conflictColumns: conflictColumns(DebateVote.t),
      updateColumns: updateColumns?.call(DebateVote.t),
      updateWhere: updateWhere?.call(DebateVote.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [DebateVote] and returns the resulting row.
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
  /// The returned [DebateVote] will have its `id` field set.
  Future<DebateVote?> upsertRow(
    _is.DatabaseSession session,
    DebateVote row, {
    required _is.ColumnSelections<DebateVoteTable> conflictColumns,
    _is.ColumnSelections<DebateVoteTable>? updateColumns,
    _is.WhereExpressionBuilder<DebateVoteTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<DebateVote>(
      row,
      conflictColumns: conflictColumns(DebateVote.t),
      updateColumns: updateColumns?.call(DebateVote.t),
      updateWhere: updateWhere?.call(DebateVote.t),
      transaction: transaction,
    );
  }

  /// Updates all [DebateVote]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<DebateVote>> update(
    _is.DatabaseSession session,
    List<DebateVote> rows, {
    _is.ColumnSelections<DebateVoteTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<DebateVote>(
      rows,
      columns: columns?.call(DebateVote.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [DebateVote]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<DebateVote> updateRow(
    _is.DatabaseSession session,
    DebateVote row, {
    _is.ColumnSelections<DebateVoteTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<DebateVote>(
      row,
      columns: columns?.call(DebateVote.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DebateVote] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<DebateVote?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<DebateVoteUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<DebateVote>(
      id,
      columnValues: columnValues(DebateVote.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [DebateVote]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<DebateVote>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<DebateVoteUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<DebateVoteTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<DebateVoteTable>? orderBy,
    _is.OrderByListBuilder<DebateVoteTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<DebateVote>(
      columnValues: columnValues(DebateVote.t.updateTable),
      where: where(DebateVote.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DebateVote.t),
      orderByList: orderByList?.call(DebateVote.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [DebateVote]s in the list and returns the deleted rows.
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
  Future<List<DebateVote>> delete(
    _is.DatabaseSession session,
    List<DebateVote> rows, {
    _is.OrderByBuilder<DebateVoteTable>? orderBy,
    _is.OrderByListBuilder<DebateVoteTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<DebateVote>(
      rows,
      orderBy: orderBy?.call(DebateVote.t),
      orderByList: orderByList?.call(DebateVote.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [DebateVote].
  Future<DebateVote> deleteRow(
    _is.DatabaseSession session,
    DebateVote row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<DebateVote>(
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
  Future<List<DebateVote>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<DebateVoteTable> where,
    _is.OrderByBuilder<DebateVoteTable>? orderBy,
    _is.OrderByListBuilder<DebateVoteTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<DebateVote>(
      where: where(DebateVote.t),
      orderBy: orderBy?.call(DebateVote.t),
      orderByList: orderByList?.call(DebateVote.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<DebateVoteTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<DebateVote>(
      where: where?.call(DebateVote.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [DebateVote] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<DebateVoteTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<DebateVote>(
      where: where(DebateVote.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
