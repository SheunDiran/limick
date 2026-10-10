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

abstract class QuizAnswer
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  QuizAnswer._({
    this.id,
    required this.profileId,
    required this.postId,
    required this.choiceIndex,
    required this.correct,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory QuizAnswer({
    int? id,
    required int profileId,
    required int postId,
    required int choiceIndex,
    required bool correct,
    DateTime? createdAt,
  }) = _QuizAnswerImpl;

  factory QuizAnswer.fromJson(Map<String, dynamic> jsonSerialization) {
    return QuizAnswer(
      id: jsonSerialization['id'] as int?,
      profileId: jsonSerialization['profileId'] as int,
      postId: jsonSerialization['postId'] as int,
      choiceIndex: jsonSerialization['choiceIndex'] as int,
      correct: _is.BoolJsonExtension.fromJson(jsonSerialization['correct']),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = QuizAnswerTable();

  static const db = QuizAnswerRepository._();

  @override
  int? id;

  int profileId;

  int postId;

  int choiceIndex;

  bool correct;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [QuizAnswer]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  QuizAnswer copyWith({
    int? id,
    int? profileId,
    int? postId,
    int? choiceIndex,
    bool? correct,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'QuizAnswer',
      if (id != null) 'id': id,
      'profileId': profileId,
      'postId': postId,
      'choiceIndex': choiceIndex,
      'correct': correct,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'QuizAnswer',
      if (id != null) 'id': id,
      'profileId': profileId,
      'postId': postId,
      'choiceIndex': choiceIndex,
      'correct': correct,
      'createdAt': createdAt.toJson(),
    };
  }

  static QuizAnswerInclude include() {
    return QuizAnswerInclude._();
  }

  static QuizAnswerIncludeList includeList({
    _is.WhereExpressionBuilder<QuizAnswerTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<QuizAnswerTable>? orderBy,
    _is.OrderByListBuilder<QuizAnswerTable>? orderByList,
    QuizAnswerInclude? include,
  }) {
    return QuizAnswerIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(QuizAnswer.t),
      orderByList: orderByList?.call(QuizAnswer.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _QuizAnswerImpl extends QuizAnswer {
  _QuizAnswerImpl({
    int? id,
    required int profileId,
    required int postId,
    required int choiceIndex,
    required bool correct,
    DateTime? createdAt,
  }) : super._(
         id: id,
         profileId: profileId,
         postId: postId,
         choiceIndex: choiceIndex,
         correct: correct,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [QuizAnswer]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  QuizAnswer copyWith({
    Object? id = _Undefined,
    int? profileId,
    int? postId,
    int? choiceIndex,
    bool? correct,
    DateTime? createdAt,
  }) {
    return QuizAnswer(
      id: id is int? ? id : this.id,
      profileId: profileId ?? this.profileId,
      postId: postId ?? this.postId,
      choiceIndex: choiceIndex ?? this.choiceIndex,
      correct: correct ?? this.correct,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class QuizAnswerUpdateTable extends _is.UpdateTable<QuizAnswerTable> {
  QuizAnswerUpdateTable(super.table);

  _is.ColumnValue<int, int> profileId(int value) => _is.ColumnValue(
    table.profileId,
    value,
  );

  _is.ColumnValue<int, int> postId(int value) => _is.ColumnValue(
    table.postId,
    value,
  );

  _is.ColumnValue<int, int> choiceIndex(int value) => _is.ColumnValue(
    table.choiceIndex,
    value,
  );

  _is.ColumnValue<bool, bool> correct(bool value) => _is.ColumnValue(
    table.correct,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class QuizAnswerTable extends _is.Table<int?> {
  QuizAnswerTable({super.tableRelation}) : super(tableName: 'quiz_answer') {
    updateTable = QuizAnswerUpdateTable(this);
    profileId = _is.ColumnInt(
      'profileId',
      this,
    );
    postId = _is.ColumnInt(
      'postId',
      this,
    );
    choiceIndex = _is.ColumnInt(
      'choiceIndex',
      this,
    );
    correct = _is.ColumnBool(
      'correct',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final QuizAnswerUpdateTable updateTable;

  late final _is.ColumnInt profileId;

  late final _is.ColumnInt postId;

  late final _is.ColumnInt choiceIndex;

  late final _is.ColumnBool correct;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    profileId,
    postId,
    choiceIndex,
    correct,
    createdAt,
  ];
}

class QuizAnswerInclude extends _is.IncludeObject {
  QuizAnswerInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => QuizAnswer.t;
}

class QuizAnswerIncludeList extends _is.IncludeList {
  QuizAnswerIncludeList._({
    _is.WhereExpressionBuilder<QuizAnswerTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(QuizAnswer.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => QuizAnswer.t;
}

class QuizAnswerRepository {
  const QuizAnswerRepository._();

  /// Returns a list of [QuizAnswer]s matching the given query parameters.
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
  Future<List<QuizAnswer>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<QuizAnswerTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<QuizAnswerTable>? orderBy,
    _is.OrderByListBuilder<QuizAnswerTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<QuizAnswer>(
      where: where?.call(QuizAnswer.t),
      orderBy: orderBy?.call(QuizAnswer.t),
      orderByList: orderByList?.call(QuizAnswer.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [QuizAnswer] matching the given query parameters.
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
  Future<QuizAnswer?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<QuizAnswerTable>? where,
    int? offset,
    _is.OrderByBuilder<QuizAnswerTable>? orderBy,
    _is.OrderByListBuilder<QuizAnswerTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<QuizAnswer>(
      where: where?.call(QuizAnswer.t),
      orderBy: orderBy?.call(QuizAnswer.t),
      orderByList: orderByList?.call(QuizAnswer.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [QuizAnswer] by its [id] or null if no such row exists.
  Future<QuizAnswer?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<QuizAnswer>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [QuizAnswer]s in the list and returns the inserted rows.
  ///
  /// The returned [QuizAnswer]s will have their `id` fields set.
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
  Future<List<QuizAnswer>> insert(
    _is.DatabaseSession session,
    List<QuizAnswer> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<QuizAnswer>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [QuizAnswer] and returns the inserted row.
  ///
  /// The returned [QuizAnswer] will have its `id` field set.
  Future<QuizAnswer> insertRow(
    _is.DatabaseSession session,
    QuizAnswer row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<QuizAnswer>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [QuizAnswer]s in the list and returns the resulting rows.
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
  /// The returned [QuizAnswer]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<QuizAnswer>> upsert(
    _is.DatabaseSession session,
    List<QuizAnswer> rows, {
    required _is.ColumnSelections<QuizAnswerTable> conflictColumns,
    _is.ColumnSelections<QuizAnswerTable>? updateColumns,
    _is.WhereExpressionBuilder<QuizAnswerTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<QuizAnswer>(
      rows,
      conflictColumns: conflictColumns(QuizAnswer.t),
      updateColumns: updateColumns?.call(QuizAnswer.t),
      updateWhere: updateWhere?.call(QuizAnswer.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [QuizAnswer] and returns the resulting row.
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
  /// The returned [QuizAnswer] will have its `id` field set.
  Future<QuizAnswer?> upsertRow(
    _is.DatabaseSession session,
    QuizAnswer row, {
    required _is.ColumnSelections<QuizAnswerTable> conflictColumns,
    _is.ColumnSelections<QuizAnswerTable>? updateColumns,
    _is.WhereExpressionBuilder<QuizAnswerTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<QuizAnswer>(
      row,
      conflictColumns: conflictColumns(QuizAnswer.t),
      updateColumns: updateColumns?.call(QuizAnswer.t),
      updateWhere: updateWhere?.call(QuizAnswer.t),
      transaction: transaction,
    );
  }

  /// Updates all [QuizAnswer]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<QuizAnswer>> update(
    _is.DatabaseSession session,
    List<QuizAnswer> rows, {
    _is.ColumnSelections<QuizAnswerTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<QuizAnswer>(
      rows,
      columns: columns?.call(QuizAnswer.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [QuizAnswer]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<QuizAnswer> updateRow(
    _is.DatabaseSession session,
    QuizAnswer row, {
    _is.ColumnSelections<QuizAnswerTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<QuizAnswer>(
      row,
      columns: columns?.call(QuizAnswer.t),
      transaction: transaction,
    );
  }

  /// Updates a single [QuizAnswer] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<QuizAnswer?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<QuizAnswerUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<QuizAnswer>(
      id,
      columnValues: columnValues(QuizAnswer.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [QuizAnswer]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<QuizAnswer>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<QuizAnswerUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<QuizAnswerTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<QuizAnswerTable>? orderBy,
    _is.OrderByListBuilder<QuizAnswerTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<QuizAnswer>(
      columnValues: columnValues(QuizAnswer.t.updateTable),
      where: where(QuizAnswer.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(QuizAnswer.t),
      orderByList: orderByList?.call(QuizAnswer.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [QuizAnswer]s in the list and returns the deleted rows.
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
  Future<List<QuizAnswer>> delete(
    _is.DatabaseSession session,
    List<QuizAnswer> rows, {
    _is.OrderByBuilder<QuizAnswerTable>? orderBy,
    _is.OrderByListBuilder<QuizAnswerTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<QuizAnswer>(
      rows,
      orderBy: orderBy?.call(QuizAnswer.t),
      orderByList: orderByList?.call(QuizAnswer.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [QuizAnswer].
  Future<QuizAnswer> deleteRow(
    _is.DatabaseSession session,
    QuizAnswer row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<QuizAnswer>(
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
  Future<List<QuizAnswer>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<QuizAnswerTable> where,
    _is.OrderByBuilder<QuizAnswerTable>? orderBy,
    _is.OrderByListBuilder<QuizAnswerTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<QuizAnswer>(
      where: where(QuizAnswer.t),
      orderBy: orderBy?.call(QuizAnswer.t),
      orderByList: orderByList?.call(QuizAnswer.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<QuizAnswerTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<QuizAnswer>(
      where: where?.call(QuizAnswer.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [QuizAnswer] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<QuizAnswerTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<QuizAnswer>(
      where: where(QuizAnswer.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
