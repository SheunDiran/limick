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
import 'topic.dart' as _iro94j51;

abstract class TopicAffinity
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  TopicAffinity._({
    this.id,
    required this.profileId,
    required this.topic,
    double? score,
  }) : score = score ?? 0.0;

  factory TopicAffinity({
    int? id,
    required int profileId,
    required _iro94j51.Topic topic,
    double? score,
  }) = _TopicAffinityImpl;

  factory TopicAffinity.fromJson(Map<String, dynamic> jsonSerialization) {
    return TopicAffinity(
      id: jsonSerialization['id'] as int?,
      profileId: jsonSerialization['profileId'] as int,
      topic: _iro94j51.Topic.fromJson((jsonSerialization['topic'] as String)),
      score: (jsonSerialization['score'] as num?)?.toDouble(),
    );
  }

  static final t = TopicAffinityTable();

  static const db = TopicAffinityRepository._();

  @override
  int? id;

  int profileId;

  _iro94j51.Topic topic;

  double score;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [TopicAffinity]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  TopicAffinity copyWith({
    int? id,
    int? profileId,
    _iro94j51.Topic? topic,
    double? score,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TopicAffinity',
      if (id != null) 'id': id,
      'profileId': profileId,
      'topic': topic.toJson(),
      'score': score,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'TopicAffinity',
      if (id != null) 'id': id,
      'profileId': profileId,
      'topic': topic.toJson(),
      'score': score,
    };
  }

  static TopicAffinityInclude include() {
    return TopicAffinityInclude._();
  }

  static TopicAffinityIncludeList includeList({
    _is.WhereExpressionBuilder<TopicAffinityTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<TopicAffinityTable>? orderBy,
    _is.OrderByListBuilder<TopicAffinityTable>? orderByList,
    TopicAffinityInclude? include,
  }) {
    return TopicAffinityIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TopicAffinity.t),
      orderByList: orderByList?.call(TopicAffinity.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TopicAffinityImpl extends TopicAffinity {
  _TopicAffinityImpl({
    int? id,
    required int profileId,
    required _iro94j51.Topic topic,
    double? score,
  }) : super._(
         id: id,
         profileId: profileId,
         topic: topic,
         score: score,
       );

  /// Returns a shallow copy of this [TopicAffinity]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  TopicAffinity copyWith({
    Object? id = _Undefined,
    int? profileId,
    _iro94j51.Topic? topic,
    double? score,
  }) {
    return TopicAffinity(
      id: id is int? ? id : this.id,
      profileId: profileId ?? this.profileId,
      topic: topic ?? this.topic,
      score: score ?? this.score,
    );
  }
}

class TopicAffinityUpdateTable extends _is.UpdateTable<TopicAffinityTable> {
  TopicAffinityUpdateTable(super.table);

  _is.ColumnValue<int, int> profileId(int value) => _is.ColumnValue(
    table.profileId,
    value,
  );

  _is.ColumnValue<_iro94j51.Topic, _iro94j51.Topic> topic(
    _iro94j51.Topic value,
  ) => _is.ColumnValue(
    table.topic,
    value,
  );

  _is.ColumnValue<double, double> score(double value) => _is.ColumnValue(
    table.score,
    value,
  );
}

class TopicAffinityTable extends _is.Table<int?> {
  TopicAffinityTable({super.tableRelation})
    : super(tableName: 'topic_affinity') {
    updateTable = TopicAffinityUpdateTable(this);
    profileId = _is.ColumnInt(
      'profileId',
      this,
    );
    topic = _is.ColumnEnum(
      'topic',
      this,
      _is.EnumSerialization.byName,
    );
    score = _is.ColumnDouble(
      'score',
      this,
      hasDefault: true,
    );
  }

  late final TopicAffinityUpdateTable updateTable;

  late final _is.ColumnInt profileId;

  late final _is.ColumnEnum<_iro94j51.Topic> topic;

  late final _is.ColumnDouble score;

  @override
  List<_is.Column> get columns => [
    id,
    profileId,
    topic,
    score,
  ];
}

class TopicAffinityInclude extends _is.IncludeObject {
  TopicAffinityInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => TopicAffinity.t;
}

class TopicAffinityIncludeList extends _is.IncludeList {
  TopicAffinityIncludeList._({
    _is.WhereExpressionBuilder<TopicAffinityTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(TopicAffinity.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => TopicAffinity.t;
}

class TopicAffinityRepository {
  const TopicAffinityRepository._();

  /// Returns a list of [TopicAffinity]s matching the given query parameters.
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
  Future<List<TopicAffinity>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<TopicAffinityTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<TopicAffinityTable>? orderBy,
    _is.OrderByListBuilder<TopicAffinityTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<TopicAffinity>(
      where: where?.call(TopicAffinity.t),
      orderBy: orderBy?.call(TopicAffinity.t),
      orderByList: orderByList?.call(TopicAffinity.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [TopicAffinity] matching the given query parameters.
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
  Future<TopicAffinity?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<TopicAffinityTable>? where,
    int? offset,
    _is.OrderByBuilder<TopicAffinityTable>? orderBy,
    _is.OrderByListBuilder<TopicAffinityTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<TopicAffinity>(
      where: where?.call(TopicAffinity.t),
      orderBy: orderBy?.call(TopicAffinity.t),
      orderByList: orderByList?.call(TopicAffinity.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [TopicAffinity] by its [id] or null if no such row exists.
  Future<TopicAffinity?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<TopicAffinity>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [TopicAffinity]s in the list and returns the inserted rows.
  ///
  /// The returned [TopicAffinity]s will have their `id` fields set.
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
  Future<List<TopicAffinity>> insert(
    _is.DatabaseSession session,
    List<TopicAffinity> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<TopicAffinity>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [TopicAffinity] and returns the inserted row.
  ///
  /// The returned [TopicAffinity] will have its `id` field set.
  Future<TopicAffinity> insertRow(
    _is.DatabaseSession session,
    TopicAffinity row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<TopicAffinity>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [TopicAffinity]s in the list and returns the resulting rows.
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
  /// The returned [TopicAffinity]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<TopicAffinity>> upsert(
    _is.DatabaseSession session,
    List<TopicAffinity> rows, {
    required _is.ColumnSelections<TopicAffinityTable> conflictColumns,
    _is.ColumnSelections<TopicAffinityTable>? updateColumns,
    _is.WhereExpressionBuilder<TopicAffinityTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<TopicAffinity>(
      rows,
      conflictColumns: conflictColumns(TopicAffinity.t),
      updateColumns: updateColumns?.call(TopicAffinity.t),
      updateWhere: updateWhere?.call(TopicAffinity.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [TopicAffinity] and returns the resulting row.
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
  /// The returned [TopicAffinity] will have its `id` field set.
  Future<TopicAffinity?> upsertRow(
    _is.DatabaseSession session,
    TopicAffinity row, {
    required _is.ColumnSelections<TopicAffinityTable> conflictColumns,
    _is.ColumnSelections<TopicAffinityTable>? updateColumns,
    _is.WhereExpressionBuilder<TopicAffinityTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<TopicAffinity>(
      row,
      conflictColumns: conflictColumns(TopicAffinity.t),
      updateColumns: updateColumns?.call(TopicAffinity.t),
      updateWhere: updateWhere?.call(TopicAffinity.t),
      transaction: transaction,
    );
  }

  /// Updates all [TopicAffinity]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<TopicAffinity>> update(
    _is.DatabaseSession session,
    List<TopicAffinity> rows, {
    _is.ColumnSelections<TopicAffinityTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<TopicAffinity>(
      rows,
      columns: columns?.call(TopicAffinity.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [TopicAffinity]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<TopicAffinity> updateRow(
    _is.DatabaseSession session,
    TopicAffinity row, {
    _is.ColumnSelections<TopicAffinityTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<TopicAffinity>(
      row,
      columns: columns?.call(TopicAffinity.t),
      transaction: transaction,
    );
  }

  /// Updates a single [TopicAffinity] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<TopicAffinity?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<TopicAffinityUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<TopicAffinity>(
      id,
      columnValues: columnValues(TopicAffinity.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [TopicAffinity]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<TopicAffinity>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<TopicAffinityUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<TopicAffinityTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<TopicAffinityTable>? orderBy,
    _is.OrderByListBuilder<TopicAffinityTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<TopicAffinity>(
      columnValues: columnValues(TopicAffinity.t.updateTable),
      where: where(TopicAffinity.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TopicAffinity.t),
      orderByList: orderByList?.call(TopicAffinity.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [TopicAffinity]s in the list and returns the deleted rows.
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
  Future<List<TopicAffinity>> delete(
    _is.DatabaseSession session,
    List<TopicAffinity> rows, {
    _is.OrderByBuilder<TopicAffinityTable>? orderBy,
    _is.OrderByListBuilder<TopicAffinityTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<TopicAffinity>(
      rows,
      orderBy: orderBy?.call(TopicAffinity.t),
      orderByList: orderByList?.call(TopicAffinity.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [TopicAffinity].
  Future<TopicAffinity> deleteRow(
    _is.DatabaseSession session,
    TopicAffinity row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<TopicAffinity>(
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
  Future<List<TopicAffinity>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<TopicAffinityTable> where,
    _is.OrderByBuilder<TopicAffinityTable>? orderBy,
    _is.OrderByListBuilder<TopicAffinityTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<TopicAffinity>(
      where: where(TopicAffinity.t),
      orderBy: orderBy?.call(TopicAffinity.t),
      orderByList: orderByList?.call(TopicAffinity.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<TopicAffinityTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<TopicAffinity>(
      where: where?.call(TopicAffinity.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [TopicAffinity] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<TopicAffinityTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<TopicAffinity>(
      where: where(TopicAffinity.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
