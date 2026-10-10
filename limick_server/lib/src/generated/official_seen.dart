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

/// Which official posts a reader has already been shown.
abstract class OfficialSeen
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  OfficialSeen._({
    this.id,
    required this.profileId,
    required this.officialPostId,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory OfficialSeen({
    int? id,
    required int profileId,
    required int officialPostId,
    DateTime? createdAt,
  }) = _OfficialSeenImpl;

  factory OfficialSeen.fromJson(Map<String, dynamic> jsonSerialization) {
    return OfficialSeen(
      id: jsonSerialization['id'] as int?,
      profileId: jsonSerialization['profileId'] as int,
      officialPostId: jsonSerialization['officialPostId'] as int,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = OfficialSeenTable();

  static const db = OfficialSeenRepository._();

  @override
  int? id;

  int profileId;

  int officialPostId;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [OfficialSeen]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  OfficialSeen copyWith({
    int? id,
    int? profileId,
    int? officialPostId,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OfficialSeen',
      if (id != null) 'id': id,
      'profileId': profileId,
      'officialPostId': officialPostId,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'OfficialSeen',
      if (id != null) 'id': id,
      'profileId': profileId,
      'officialPostId': officialPostId,
      'createdAt': createdAt.toJson(),
    };
  }

  static OfficialSeenInclude include() {
    return OfficialSeenInclude._();
  }

  static OfficialSeenIncludeList includeList({
    _is.WhereExpressionBuilder<OfficialSeenTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<OfficialSeenTable>? orderBy,
    _is.OrderByListBuilder<OfficialSeenTable>? orderByList,
    OfficialSeenInclude? include,
  }) {
    return OfficialSeenIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(OfficialSeen.t),
      orderByList: orderByList?.call(OfficialSeen.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OfficialSeenImpl extends OfficialSeen {
  _OfficialSeenImpl({
    int? id,
    required int profileId,
    required int officialPostId,
    DateTime? createdAt,
  }) : super._(
         id: id,
         profileId: profileId,
         officialPostId: officialPostId,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [OfficialSeen]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  OfficialSeen copyWith({
    Object? id = _Undefined,
    int? profileId,
    int? officialPostId,
    DateTime? createdAt,
  }) {
    return OfficialSeen(
      id: id is int? ? id : this.id,
      profileId: profileId ?? this.profileId,
      officialPostId: officialPostId ?? this.officialPostId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class OfficialSeenUpdateTable extends _is.UpdateTable<OfficialSeenTable> {
  OfficialSeenUpdateTable(super.table);

  _is.ColumnValue<int, int> profileId(int value) => _is.ColumnValue(
    table.profileId,
    value,
  );

  _is.ColumnValue<int, int> officialPostId(int value) => _is.ColumnValue(
    table.officialPostId,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class OfficialSeenTable extends _is.Table<int?> {
  OfficialSeenTable({super.tableRelation}) : super(tableName: 'official_seen') {
    updateTable = OfficialSeenUpdateTable(this);
    profileId = _is.ColumnInt(
      'profileId',
      this,
    );
    officialPostId = _is.ColumnInt(
      'officialPostId',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final OfficialSeenUpdateTable updateTable;

  late final _is.ColumnInt profileId;

  late final _is.ColumnInt officialPostId;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    profileId,
    officialPostId,
    createdAt,
  ];
}

class OfficialSeenInclude extends _is.IncludeObject {
  OfficialSeenInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => OfficialSeen.t;
}

class OfficialSeenIncludeList extends _is.IncludeList {
  OfficialSeenIncludeList._({
    _is.WhereExpressionBuilder<OfficialSeenTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(OfficialSeen.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => OfficialSeen.t;
}

class OfficialSeenRepository {
  const OfficialSeenRepository._();

  /// Returns a list of [OfficialSeen]s matching the given query parameters.
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
  Future<List<OfficialSeen>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<OfficialSeenTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<OfficialSeenTable>? orderBy,
    _is.OrderByListBuilder<OfficialSeenTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<OfficialSeen>(
      where: where?.call(OfficialSeen.t),
      orderBy: orderBy?.call(OfficialSeen.t),
      orderByList: orderByList?.call(OfficialSeen.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [OfficialSeen] matching the given query parameters.
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
  Future<OfficialSeen?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<OfficialSeenTable>? where,
    int? offset,
    _is.OrderByBuilder<OfficialSeenTable>? orderBy,
    _is.OrderByListBuilder<OfficialSeenTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<OfficialSeen>(
      where: where?.call(OfficialSeen.t),
      orderBy: orderBy?.call(OfficialSeen.t),
      orderByList: orderByList?.call(OfficialSeen.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [OfficialSeen] by its [id] or null if no such row exists.
  Future<OfficialSeen?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<OfficialSeen>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [OfficialSeen]s in the list and returns the inserted rows.
  ///
  /// The returned [OfficialSeen]s will have their `id` fields set.
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
  Future<List<OfficialSeen>> insert(
    _is.DatabaseSession session,
    List<OfficialSeen> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<OfficialSeen>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [OfficialSeen] and returns the inserted row.
  ///
  /// The returned [OfficialSeen] will have its `id` field set.
  Future<OfficialSeen> insertRow(
    _is.DatabaseSession session,
    OfficialSeen row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<OfficialSeen>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [OfficialSeen]s in the list and returns the resulting rows.
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
  /// The returned [OfficialSeen]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<OfficialSeen>> upsert(
    _is.DatabaseSession session,
    List<OfficialSeen> rows, {
    required _is.ColumnSelections<OfficialSeenTable> conflictColumns,
    _is.ColumnSelections<OfficialSeenTable>? updateColumns,
    _is.WhereExpressionBuilder<OfficialSeenTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<OfficialSeen>(
      rows,
      conflictColumns: conflictColumns(OfficialSeen.t),
      updateColumns: updateColumns?.call(OfficialSeen.t),
      updateWhere: updateWhere?.call(OfficialSeen.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [OfficialSeen] and returns the resulting row.
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
  /// The returned [OfficialSeen] will have its `id` field set.
  Future<OfficialSeen?> upsertRow(
    _is.DatabaseSession session,
    OfficialSeen row, {
    required _is.ColumnSelections<OfficialSeenTable> conflictColumns,
    _is.ColumnSelections<OfficialSeenTable>? updateColumns,
    _is.WhereExpressionBuilder<OfficialSeenTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<OfficialSeen>(
      row,
      conflictColumns: conflictColumns(OfficialSeen.t),
      updateColumns: updateColumns?.call(OfficialSeen.t),
      updateWhere: updateWhere?.call(OfficialSeen.t),
      transaction: transaction,
    );
  }

  /// Updates all [OfficialSeen]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<OfficialSeen>> update(
    _is.DatabaseSession session,
    List<OfficialSeen> rows, {
    _is.ColumnSelections<OfficialSeenTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<OfficialSeen>(
      rows,
      columns: columns?.call(OfficialSeen.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [OfficialSeen]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<OfficialSeen> updateRow(
    _is.DatabaseSession session,
    OfficialSeen row, {
    _is.ColumnSelections<OfficialSeenTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<OfficialSeen>(
      row,
      columns: columns?.call(OfficialSeen.t),
      transaction: transaction,
    );
  }

  /// Updates a single [OfficialSeen] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<OfficialSeen?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<OfficialSeenUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<OfficialSeen>(
      id,
      columnValues: columnValues(OfficialSeen.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [OfficialSeen]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<OfficialSeen>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<OfficialSeenUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<OfficialSeenTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<OfficialSeenTable>? orderBy,
    _is.OrderByListBuilder<OfficialSeenTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<OfficialSeen>(
      columnValues: columnValues(OfficialSeen.t.updateTable),
      where: where(OfficialSeen.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(OfficialSeen.t),
      orderByList: orderByList?.call(OfficialSeen.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [OfficialSeen]s in the list and returns the deleted rows.
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
  Future<List<OfficialSeen>> delete(
    _is.DatabaseSession session,
    List<OfficialSeen> rows, {
    _is.OrderByBuilder<OfficialSeenTable>? orderBy,
    _is.OrderByListBuilder<OfficialSeenTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<OfficialSeen>(
      rows,
      orderBy: orderBy?.call(OfficialSeen.t),
      orderByList: orderByList?.call(OfficialSeen.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [OfficialSeen].
  Future<OfficialSeen> deleteRow(
    _is.DatabaseSession session,
    OfficialSeen row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<OfficialSeen>(
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
  Future<List<OfficialSeen>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<OfficialSeenTable> where,
    _is.OrderByBuilder<OfficialSeenTable>? orderBy,
    _is.OrderByListBuilder<OfficialSeenTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<OfficialSeen>(
      where: where(OfficialSeen.t),
      orderBy: orderBy?.call(OfficialSeen.t),
      orderByList: orderByList?.call(OfficialSeen.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<OfficialSeenTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<OfficialSeen>(
      where: where?.call(OfficialSeen.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [OfficialSeen] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<OfficialSeenTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<OfficialSeen>(
      where: where(OfficialSeen.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
