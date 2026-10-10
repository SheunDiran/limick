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

abstract class StudyBreak
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  StudyBreak._({
    this.id,
    required this.profileId,
    required this.plannedMinutes,
    DateTime? startedAt,
    this.endedAt,
  }) : startedAt = startedAt ?? DateTime.now();

  factory StudyBreak({
    int? id,
    required int profileId,
    required int plannedMinutes,
    DateTime? startedAt,
    DateTime? endedAt,
  }) = _StudyBreakImpl;

  factory StudyBreak.fromJson(Map<String, dynamic> jsonSerialization) {
    return StudyBreak(
      id: jsonSerialization['id'] as int?,
      profileId: jsonSerialization['profileId'] as int,
      plannedMinutes: jsonSerialization['plannedMinutes'] as int,
      startedAt: jsonSerialization['startedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['startedAt']),
      endedAt: jsonSerialization['endedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['endedAt']),
    );
  }

  static final t = StudyBreakTable();

  static const db = StudyBreakRepository._();

  @override
  int? id;

  int profileId;

  int plannedMinutes;

  DateTime startedAt;

  DateTime? endedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [StudyBreak]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  StudyBreak copyWith({
    int? id,
    int? profileId,
    int? plannedMinutes,
    DateTime? startedAt,
    DateTime? endedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StudyBreak',
      if (id != null) 'id': id,
      'profileId': profileId,
      'plannedMinutes': plannedMinutes,
      'startedAt': startedAt.toJson(),
      if (endedAt != null) 'endedAt': endedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'StudyBreak',
      if (id != null) 'id': id,
      'profileId': profileId,
      'plannedMinutes': plannedMinutes,
      'startedAt': startedAt.toJson(),
      if (endedAt != null) 'endedAt': endedAt?.toJson(),
    };
  }

  static StudyBreakInclude include() {
    return StudyBreakInclude._();
  }

  static StudyBreakIncludeList includeList({
    _is.WhereExpressionBuilder<StudyBreakTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<StudyBreakTable>? orderBy,
    _is.OrderByListBuilder<StudyBreakTable>? orderByList,
    StudyBreakInclude? include,
  }) {
    return StudyBreakIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StudyBreak.t),
      orderByList: orderByList?.call(StudyBreak.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StudyBreakImpl extends StudyBreak {
  _StudyBreakImpl({
    int? id,
    required int profileId,
    required int plannedMinutes,
    DateTime? startedAt,
    DateTime? endedAt,
  }) : super._(
         id: id,
         profileId: profileId,
         plannedMinutes: plannedMinutes,
         startedAt: startedAt,
         endedAt: endedAt,
       );

  /// Returns a shallow copy of this [StudyBreak]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  StudyBreak copyWith({
    Object? id = _Undefined,
    int? profileId,
    int? plannedMinutes,
    DateTime? startedAt,
    Object? endedAt = _Undefined,
  }) {
    return StudyBreak(
      id: id is int? ? id : this.id,
      profileId: profileId ?? this.profileId,
      plannedMinutes: plannedMinutes ?? this.plannedMinutes,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt is DateTime? ? endedAt : this.endedAt,
    );
  }
}

class StudyBreakUpdateTable extends _is.UpdateTable<StudyBreakTable> {
  StudyBreakUpdateTable(super.table);

  _is.ColumnValue<int, int> profileId(int value) => _is.ColumnValue(
    table.profileId,
    value,
  );

  _is.ColumnValue<int, int> plannedMinutes(int value) => _is.ColumnValue(
    table.plannedMinutes,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> startedAt(DateTime value) =>
      _is.ColumnValue(
        table.startedAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> endedAt(DateTime? value) =>
      _is.ColumnValue(
        table.endedAt,
        value,
      );
}

class StudyBreakTable extends _is.Table<int?> {
  StudyBreakTable({super.tableRelation}) : super(tableName: 'study_break') {
    updateTable = StudyBreakUpdateTable(this);
    profileId = _is.ColumnInt(
      'profileId',
      this,
    );
    plannedMinutes = _is.ColumnInt(
      'plannedMinutes',
      this,
    );
    startedAt = _is.ColumnDateTime(
      'startedAt',
      this,
      hasDefault: true,
    );
    endedAt = _is.ColumnDateTime(
      'endedAt',
      this,
    );
  }

  late final StudyBreakUpdateTable updateTable;

  late final _is.ColumnInt profileId;

  late final _is.ColumnInt plannedMinutes;

  late final _is.ColumnDateTime startedAt;

  late final _is.ColumnDateTime endedAt;

  @override
  List<_is.Column> get columns => [
    id,
    profileId,
    plannedMinutes,
    startedAt,
    endedAt,
  ];
}

class StudyBreakInclude extends _is.IncludeObject {
  StudyBreakInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => StudyBreak.t;
}

class StudyBreakIncludeList extends _is.IncludeList {
  StudyBreakIncludeList._({
    _is.WhereExpressionBuilder<StudyBreakTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(StudyBreak.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => StudyBreak.t;
}

class StudyBreakRepository {
  const StudyBreakRepository._();

  /// Returns a list of [StudyBreak]s matching the given query parameters.
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
  Future<List<StudyBreak>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<StudyBreakTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<StudyBreakTable>? orderBy,
    _is.OrderByListBuilder<StudyBreakTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<StudyBreak>(
      where: where?.call(StudyBreak.t),
      orderBy: orderBy?.call(StudyBreak.t),
      orderByList: orderByList?.call(StudyBreak.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [StudyBreak] matching the given query parameters.
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
  Future<StudyBreak?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<StudyBreakTable>? where,
    int? offset,
    _is.OrderByBuilder<StudyBreakTable>? orderBy,
    _is.OrderByListBuilder<StudyBreakTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<StudyBreak>(
      where: where?.call(StudyBreak.t),
      orderBy: orderBy?.call(StudyBreak.t),
      orderByList: orderByList?.call(StudyBreak.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [StudyBreak] by its [id] or null if no such row exists.
  Future<StudyBreak?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<StudyBreak>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [StudyBreak]s in the list and returns the inserted rows.
  ///
  /// The returned [StudyBreak]s will have their `id` fields set.
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
  Future<List<StudyBreak>> insert(
    _is.DatabaseSession session,
    List<StudyBreak> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<StudyBreak>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [StudyBreak] and returns the inserted row.
  ///
  /// The returned [StudyBreak] will have its `id` field set.
  Future<StudyBreak> insertRow(
    _is.DatabaseSession session,
    StudyBreak row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<StudyBreak>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [StudyBreak]s in the list and returns the resulting rows.
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
  /// The returned [StudyBreak]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<StudyBreak>> upsert(
    _is.DatabaseSession session,
    List<StudyBreak> rows, {
    required _is.ColumnSelections<StudyBreakTable> conflictColumns,
    _is.ColumnSelections<StudyBreakTable>? updateColumns,
    _is.WhereExpressionBuilder<StudyBreakTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<StudyBreak>(
      rows,
      conflictColumns: conflictColumns(StudyBreak.t),
      updateColumns: updateColumns?.call(StudyBreak.t),
      updateWhere: updateWhere?.call(StudyBreak.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [StudyBreak] and returns the resulting row.
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
  /// The returned [StudyBreak] will have its `id` field set.
  Future<StudyBreak?> upsertRow(
    _is.DatabaseSession session,
    StudyBreak row, {
    required _is.ColumnSelections<StudyBreakTable> conflictColumns,
    _is.ColumnSelections<StudyBreakTable>? updateColumns,
    _is.WhereExpressionBuilder<StudyBreakTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<StudyBreak>(
      row,
      conflictColumns: conflictColumns(StudyBreak.t),
      updateColumns: updateColumns?.call(StudyBreak.t),
      updateWhere: updateWhere?.call(StudyBreak.t),
      transaction: transaction,
    );
  }

  /// Updates all [StudyBreak]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<StudyBreak>> update(
    _is.DatabaseSession session,
    List<StudyBreak> rows, {
    _is.ColumnSelections<StudyBreakTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<StudyBreak>(
      rows,
      columns: columns?.call(StudyBreak.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [StudyBreak]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<StudyBreak> updateRow(
    _is.DatabaseSession session,
    StudyBreak row, {
    _is.ColumnSelections<StudyBreakTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<StudyBreak>(
      row,
      columns: columns?.call(StudyBreak.t),
      transaction: transaction,
    );
  }

  /// Updates a single [StudyBreak] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<StudyBreak?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<StudyBreakUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<StudyBreak>(
      id,
      columnValues: columnValues(StudyBreak.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [StudyBreak]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<StudyBreak>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<StudyBreakUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<StudyBreakTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<StudyBreakTable>? orderBy,
    _is.OrderByListBuilder<StudyBreakTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<StudyBreak>(
      columnValues: columnValues(StudyBreak.t.updateTable),
      where: where(StudyBreak.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StudyBreak.t),
      orderByList: orderByList?.call(StudyBreak.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [StudyBreak]s in the list and returns the deleted rows.
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
  Future<List<StudyBreak>> delete(
    _is.DatabaseSession session,
    List<StudyBreak> rows, {
    _is.OrderByBuilder<StudyBreakTable>? orderBy,
    _is.OrderByListBuilder<StudyBreakTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<StudyBreak>(
      rows,
      orderBy: orderBy?.call(StudyBreak.t),
      orderByList: orderByList?.call(StudyBreak.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [StudyBreak].
  Future<StudyBreak> deleteRow(
    _is.DatabaseSession session,
    StudyBreak row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<StudyBreak>(
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
  Future<List<StudyBreak>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<StudyBreakTable> where,
    _is.OrderByBuilder<StudyBreakTable>? orderBy,
    _is.OrderByListBuilder<StudyBreakTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<StudyBreak>(
      where: where(StudyBreak.t),
      orderBy: orderBy?.call(StudyBreak.t),
      orderByList: orderByList?.call(StudyBreak.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<StudyBreakTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<StudyBreak>(
      where: where?.call(StudyBreak.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [StudyBreak] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<StudyBreakTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<StudyBreak>(
      where: where(StudyBreak.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
