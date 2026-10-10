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

abstract class PostView
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  PostView._({
    this.id,
    required this.profileId,
    required this.postId,
    int? dwellMs,
    DateTime? createdAt,
  }) : dwellMs = dwellMs ?? 0,
       createdAt = createdAt ?? DateTime.now();

  factory PostView({
    int? id,
    required int profileId,
    required int postId,
    int? dwellMs,
    DateTime? createdAt,
  }) = _PostViewImpl;

  factory PostView.fromJson(Map<String, dynamic> jsonSerialization) {
    return PostView(
      id: jsonSerialization['id'] as int?,
      profileId: jsonSerialization['profileId'] as int,
      postId: jsonSerialization['postId'] as int,
      dwellMs: jsonSerialization['dwellMs'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = PostViewTable();

  static const db = PostViewRepository._();

  @override
  int? id;

  int profileId;

  int postId;

  int dwellMs;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [PostView]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  PostView copyWith({
    int? id,
    int? profileId,
    int? postId,
    int? dwellMs,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PostView',
      if (id != null) 'id': id,
      'profileId': profileId,
      'postId': postId,
      'dwellMs': dwellMs,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PostView',
      if (id != null) 'id': id,
      'profileId': profileId,
      'postId': postId,
      'dwellMs': dwellMs,
      'createdAt': createdAt.toJson(),
    };
  }

  static PostViewInclude include() {
    return PostViewInclude._();
  }

  static PostViewIncludeList includeList({
    _is.WhereExpressionBuilder<PostViewTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PostViewTable>? orderBy,
    _is.OrderByListBuilder<PostViewTable>? orderByList,
    PostViewInclude? include,
  }) {
    return PostViewIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PostView.t),
      orderByList: orderByList?.call(PostView.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PostViewImpl extends PostView {
  _PostViewImpl({
    int? id,
    required int profileId,
    required int postId,
    int? dwellMs,
    DateTime? createdAt,
  }) : super._(
         id: id,
         profileId: profileId,
         postId: postId,
         dwellMs: dwellMs,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [PostView]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  PostView copyWith({
    Object? id = _Undefined,
    int? profileId,
    int? postId,
    int? dwellMs,
    DateTime? createdAt,
  }) {
    return PostView(
      id: id is int? ? id : this.id,
      profileId: profileId ?? this.profileId,
      postId: postId ?? this.postId,
      dwellMs: dwellMs ?? this.dwellMs,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class PostViewUpdateTable extends _is.UpdateTable<PostViewTable> {
  PostViewUpdateTable(super.table);

  _is.ColumnValue<int, int> profileId(int value) => _is.ColumnValue(
    table.profileId,
    value,
  );

  _is.ColumnValue<int, int> postId(int value) => _is.ColumnValue(
    table.postId,
    value,
  );

  _is.ColumnValue<int, int> dwellMs(int value) => _is.ColumnValue(
    table.dwellMs,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class PostViewTable extends _is.Table<int?> {
  PostViewTable({super.tableRelation}) : super(tableName: 'post_view') {
    updateTable = PostViewUpdateTable(this);
    profileId = _is.ColumnInt(
      'profileId',
      this,
    );
    postId = _is.ColumnInt(
      'postId',
      this,
    );
    dwellMs = _is.ColumnInt(
      'dwellMs',
      this,
      hasDefault: true,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final PostViewUpdateTable updateTable;

  late final _is.ColumnInt profileId;

  late final _is.ColumnInt postId;

  late final _is.ColumnInt dwellMs;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    profileId,
    postId,
    dwellMs,
    createdAt,
  ];
}

class PostViewInclude extends _is.IncludeObject {
  PostViewInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => PostView.t;
}

class PostViewIncludeList extends _is.IncludeList {
  PostViewIncludeList._({
    _is.WhereExpressionBuilder<PostViewTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(PostView.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => PostView.t;
}

class PostViewRepository {
  const PostViewRepository._();

  /// Returns a list of [PostView]s matching the given query parameters.
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
  Future<List<PostView>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PostViewTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PostViewTable>? orderBy,
    _is.OrderByListBuilder<PostViewTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<PostView>(
      where: where?.call(PostView.t),
      orderBy: orderBy?.call(PostView.t),
      orderByList: orderByList?.call(PostView.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [PostView] matching the given query parameters.
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
  Future<PostView?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PostViewTable>? where,
    int? offset,
    _is.OrderByBuilder<PostViewTable>? orderBy,
    _is.OrderByListBuilder<PostViewTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<PostView>(
      where: where?.call(PostView.t),
      orderBy: orderBy?.call(PostView.t),
      orderByList: orderByList?.call(PostView.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [PostView] by its [id] or null if no such row exists.
  Future<PostView?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<PostView>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [PostView]s in the list and returns the inserted rows.
  ///
  /// The returned [PostView]s will have their `id` fields set.
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
  Future<List<PostView>> insert(
    _is.DatabaseSession session,
    List<PostView> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<PostView>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [PostView] and returns the inserted row.
  ///
  /// The returned [PostView] will have its `id` field set.
  Future<PostView> insertRow(
    _is.DatabaseSession session,
    PostView row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<PostView>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [PostView]s in the list and returns the resulting rows.
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
  /// The returned [PostView]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PostView>> upsert(
    _is.DatabaseSession session,
    List<PostView> rows, {
    required _is.ColumnSelections<PostViewTable> conflictColumns,
    _is.ColumnSelections<PostViewTable>? updateColumns,
    _is.WhereExpressionBuilder<PostViewTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<PostView>(
      rows,
      conflictColumns: conflictColumns(PostView.t),
      updateColumns: updateColumns?.call(PostView.t),
      updateWhere: updateWhere?.call(PostView.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [PostView] and returns the resulting row.
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
  /// The returned [PostView] will have its `id` field set.
  Future<PostView?> upsertRow(
    _is.DatabaseSession session,
    PostView row, {
    required _is.ColumnSelections<PostViewTable> conflictColumns,
    _is.ColumnSelections<PostViewTable>? updateColumns,
    _is.WhereExpressionBuilder<PostViewTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<PostView>(
      row,
      conflictColumns: conflictColumns(PostView.t),
      updateColumns: updateColumns?.call(PostView.t),
      updateWhere: updateWhere?.call(PostView.t),
      transaction: transaction,
    );
  }

  /// Updates all [PostView]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PostView>> update(
    _is.DatabaseSession session,
    List<PostView> rows, {
    _is.ColumnSelections<PostViewTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<PostView>(
      rows,
      columns: columns?.call(PostView.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [PostView]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<PostView> updateRow(
    _is.DatabaseSession session,
    PostView row, {
    _is.ColumnSelections<PostViewTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<PostView>(
      row,
      columns: columns?.call(PostView.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PostView] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<PostView?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<PostViewUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<PostView>(
      id,
      columnValues: columnValues(PostView.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [PostView]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PostView>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<PostViewUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<PostViewTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PostViewTable>? orderBy,
    _is.OrderByListBuilder<PostViewTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<PostView>(
      columnValues: columnValues(PostView.t.updateTable),
      where: where(PostView.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PostView.t),
      orderByList: orderByList?.call(PostView.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [PostView]s in the list and returns the deleted rows.
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
  Future<List<PostView>> delete(
    _is.DatabaseSession session,
    List<PostView> rows, {
    _is.OrderByBuilder<PostViewTable>? orderBy,
    _is.OrderByListBuilder<PostViewTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<PostView>(
      rows,
      orderBy: orderBy?.call(PostView.t),
      orderByList: orderByList?.call(PostView.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [PostView].
  Future<PostView> deleteRow(
    _is.DatabaseSession session,
    PostView row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<PostView>(
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
  Future<List<PostView>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<PostViewTable> where,
    _is.OrderByBuilder<PostViewTable>? orderBy,
    _is.OrderByListBuilder<PostViewTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<PostView>(
      where: where(PostView.t),
      orderBy: orderBy?.call(PostView.t),
      orderByList: orderByList?.call(PostView.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PostViewTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<PostView>(
      where: where?.call(PostView.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [PostView] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<PostViewTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<PostView>(
      where: where(PostView.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
