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
import 'notification_kind.dart' as _ipnxo26v;

abstract class ReaderNotification
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  ReaderNotification._({
    this.id,
    required this.profileId,
    required this.actorName,
    required this.actorHandle,
    required this.kind,
    this.postId,
    this.commentId,
    bool? read,
    DateTime? createdAt,
  }) : read = read ?? false,
       createdAt = createdAt ?? DateTime.now();

  factory ReaderNotification({
    int? id,
    required int profileId,
    required String actorName,
    required String actorHandle,
    required _ipnxo26v.NotificationKind kind,
    int? postId,
    int? commentId,
    bool? read,
    DateTime? createdAt,
  }) = _ReaderNotificationImpl;

  factory ReaderNotification.fromJson(Map<String, dynamic> jsonSerialization) {
    return ReaderNotification(
      id: jsonSerialization['id'] as int?,
      profileId: jsonSerialization['profileId'] as int,
      actorName: jsonSerialization['actorName'] as String,
      actorHandle: jsonSerialization['actorHandle'] as String,
      kind: _ipnxo26v.NotificationKind.fromJson(
        (jsonSerialization['kind'] as String),
      ),
      postId: jsonSerialization['postId'] as int?,
      commentId: jsonSerialization['commentId'] as int?,
      read: jsonSerialization['read'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['read']),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = ReaderNotificationTable();

  static const db = ReaderNotificationRepository._();

  @override
  int? id;

  int profileId;

  String actorName;

  String actorHandle;

  _ipnxo26v.NotificationKind kind;

  int? postId;

  int? commentId;

  bool read;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [ReaderNotification]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ReaderNotification copyWith({
    int? id,
    int? profileId,
    String? actorName,
    String? actorHandle,
    _ipnxo26v.NotificationKind? kind,
    int? postId,
    int? commentId,
    bool? read,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ReaderNotification',
      if (id != null) 'id': id,
      'profileId': profileId,
      'actorName': actorName,
      'actorHandle': actorHandle,
      'kind': kind.toJson(),
      if (postId != null) 'postId': postId,
      if (commentId != null) 'commentId': commentId,
      'read': read,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ReaderNotification',
      if (id != null) 'id': id,
      'profileId': profileId,
      'actorName': actorName,
      'actorHandle': actorHandle,
      'kind': kind.toJson(),
      if (postId != null) 'postId': postId,
      if (commentId != null) 'commentId': commentId,
      'read': read,
      'createdAt': createdAt.toJson(),
    };
  }

  static ReaderNotificationInclude include() {
    return ReaderNotificationInclude._();
  }

  static ReaderNotificationIncludeList includeList({
    _is.WhereExpressionBuilder<ReaderNotificationTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ReaderNotificationTable>? orderBy,
    _is.OrderByListBuilder<ReaderNotificationTable>? orderByList,
    ReaderNotificationInclude? include,
  }) {
    return ReaderNotificationIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ReaderNotification.t),
      orderByList: orderByList?.call(ReaderNotification.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ReaderNotificationImpl extends ReaderNotification {
  _ReaderNotificationImpl({
    int? id,
    required int profileId,
    required String actorName,
    required String actorHandle,
    required _ipnxo26v.NotificationKind kind,
    int? postId,
    int? commentId,
    bool? read,
    DateTime? createdAt,
  }) : super._(
         id: id,
         profileId: profileId,
         actorName: actorName,
         actorHandle: actorHandle,
         kind: kind,
         postId: postId,
         commentId: commentId,
         read: read,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [ReaderNotification]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ReaderNotification copyWith({
    Object? id = _Undefined,
    int? profileId,
    String? actorName,
    String? actorHandle,
    _ipnxo26v.NotificationKind? kind,
    Object? postId = _Undefined,
    Object? commentId = _Undefined,
    bool? read,
    DateTime? createdAt,
  }) {
    return ReaderNotification(
      id: id is int? ? id : this.id,
      profileId: profileId ?? this.profileId,
      actorName: actorName ?? this.actorName,
      actorHandle: actorHandle ?? this.actorHandle,
      kind: kind ?? this.kind,
      postId: postId is int? ? postId : this.postId,
      commentId: commentId is int? ? commentId : this.commentId,
      read: read ?? this.read,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class ReaderNotificationUpdateTable
    extends _is.UpdateTable<ReaderNotificationTable> {
  ReaderNotificationUpdateTable(super.table);

  _is.ColumnValue<int, int> profileId(int value) => _is.ColumnValue(
    table.profileId,
    value,
  );

  _is.ColumnValue<String, String> actorName(String value) => _is.ColumnValue(
    table.actorName,
    value,
  );

  _is.ColumnValue<String, String> actorHandle(String value) => _is.ColumnValue(
    table.actorHandle,
    value,
  );

  _is.ColumnValue<_ipnxo26v.NotificationKind, _ipnxo26v.NotificationKind> kind(
    _ipnxo26v.NotificationKind value,
  ) => _is.ColumnValue(
    table.kind,
    value,
  );

  _is.ColumnValue<int, int> postId(int? value) => _is.ColumnValue(
    table.postId,
    value,
  );

  _is.ColumnValue<int, int> commentId(int? value) => _is.ColumnValue(
    table.commentId,
    value,
  );

  _is.ColumnValue<bool, bool> read(bool value) => _is.ColumnValue(
    table.read,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class ReaderNotificationTable extends _is.Table<int?> {
  ReaderNotificationTable({super.tableRelation})
    : super(tableName: 'reader_notification') {
    updateTable = ReaderNotificationUpdateTable(this);
    profileId = _is.ColumnInt(
      'profileId',
      this,
    );
    actorName = _is.ColumnString(
      'actorName',
      this,
    );
    actorHandle = _is.ColumnString(
      'actorHandle',
      this,
    );
    kind = _is.ColumnEnum(
      'kind',
      this,
      _is.EnumSerialization.byName,
    );
    postId = _is.ColumnInt(
      'postId',
      this,
    );
    commentId = _is.ColumnInt(
      'commentId',
      this,
    );
    read = _is.ColumnBool(
      'read',
      this,
      hasDefault: true,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final ReaderNotificationUpdateTable updateTable;

  late final _is.ColumnInt profileId;

  late final _is.ColumnString actorName;

  late final _is.ColumnString actorHandle;

  late final _is.ColumnEnum<_ipnxo26v.NotificationKind> kind;

  late final _is.ColumnInt postId;

  late final _is.ColumnInt commentId;

  late final _is.ColumnBool read;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    profileId,
    actorName,
    actorHandle,
    kind,
    postId,
    commentId,
    read,
    createdAt,
  ];
}

class ReaderNotificationInclude extends _is.IncludeObject {
  ReaderNotificationInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => ReaderNotification.t;
}

class ReaderNotificationIncludeList extends _is.IncludeList {
  ReaderNotificationIncludeList._({
    _is.WhereExpressionBuilder<ReaderNotificationTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ReaderNotification.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => ReaderNotification.t;
}

class ReaderNotificationRepository {
  const ReaderNotificationRepository._();

  /// Returns a list of [ReaderNotification]s matching the given query parameters.
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
  Future<List<ReaderNotification>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ReaderNotificationTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ReaderNotificationTable>? orderBy,
    _is.OrderByListBuilder<ReaderNotificationTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ReaderNotification>(
      where: where?.call(ReaderNotification.t),
      orderBy: orderBy?.call(ReaderNotification.t),
      orderByList: orderByList?.call(ReaderNotification.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ReaderNotification] matching the given query parameters.
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
  Future<ReaderNotification?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ReaderNotificationTable>? where,
    int? offset,
    _is.OrderByBuilder<ReaderNotificationTable>? orderBy,
    _is.OrderByListBuilder<ReaderNotificationTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ReaderNotification>(
      where: where?.call(ReaderNotification.t),
      orderBy: orderBy?.call(ReaderNotification.t),
      orderByList: orderByList?.call(ReaderNotification.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ReaderNotification] by its [id] or null if no such row exists.
  Future<ReaderNotification?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ReaderNotification>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ReaderNotification]s in the list and returns the inserted rows.
  ///
  /// The returned [ReaderNotification]s will have their `id` fields set.
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
  Future<List<ReaderNotification>> insert(
    _is.DatabaseSession session,
    List<ReaderNotification> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<ReaderNotification>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [ReaderNotification] and returns the inserted row.
  ///
  /// The returned [ReaderNotification] will have its `id` field set.
  Future<ReaderNotification> insertRow(
    _is.DatabaseSession session,
    ReaderNotification row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<ReaderNotification>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [ReaderNotification]s in the list and returns the resulting rows.
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
  /// The returned [ReaderNotification]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ReaderNotification>> upsert(
    _is.DatabaseSession session,
    List<ReaderNotification> rows, {
    required _is.ColumnSelections<ReaderNotificationTable> conflictColumns,
    _is.ColumnSelections<ReaderNotificationTable>? updateColumns,
    _is.WhereExpressionBuilder<ReaderNotificationTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<ReaderNotification>(
      rows,
      conflictColumns: conflictColumns(ReaderNotification.t),
      updateColumns: updateColumns?.call(ReaderNotification.t),
      updateWhere: updateWhere?.call(ReaderNotification.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [ReaderNotification] and returns the resulting row.
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
  /// The returned [ReaderNotification] will have its `id` field set.
  Future<ReaderNotification?> upsertRow(
    _is.DatabaseSession session,
    ReaderNotification row, {
    required _is.ColumnSelections<ReaderNotificationTable> conflictColumns,
    _is.ColumnSelections<ReaderNotificationTable>? updateColumns,
    _is.WhereExpressionBuilder<ReaderNotificationTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<ReaderNotification>(
      row,
      conflictColumns: conflictColumns(ReaderNotification.t),
      updateColumns: updateColumns?.call(ReaderNotification.t),
      updateWhere: updateWhere?.call(ReaderNotification.t),
      transaction: transaction,
    );
  }

  /// Updates all [ReaderNotification]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ReaderNotification>> update(
    _is.DatabaseSession session,
    List<ReaderNotification> rows, {
    _is.ColumnSelections<ReaderNotificationTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<ReaderNotification>(
      rows,
      columns: columns?.call(ReaderNotification.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [ReaderNotification]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ReaderNotification> updateRow(
    _is.DatabaseSession session,
    ReaderNotification row, {
    _is.ColumnSelections<ReaderNotificationTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<ReaderNotification>(
      row,
      columns: columns?.call(ReaderNotification.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ReaderNotification] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ReaderNotification?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ReaderNotificationUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<ReaderNotification>(
      id,
      columnValues: columnValues(ReaderNotification.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ReaderNotification]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ReaderNotification>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ReaderNotificationUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<ReaderNotificationTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ReaderNotificationTable>? orderBy,
    _is.OrderByListBuilder<ReaderNotificationTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<ReaderNotification>(
      columnValues: columnValues(ReaderNotification.t.updateTable),
      where: where(ReaderNotification.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ReaderNotification.t),
      orderByList: orderByList?.call(ReaderNotification.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [ReaderNotification]s in the list and returns the deleted rows.
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
  Future<List<ReaderNotification>> delete(
    _is.DatabaseSession session,
    List<ReaderNotification> rows, {
    _is.OrderByBuilder<ReaderNotificationTable>? orderBy,
    _is.OrderByListBuilder<ReaderNotificationTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<ReaderNotification>(
      rows,
      orderBy: orderBy?.call(ReaderNotification.t),
      orderByList: orderByList?.call(ReaderNotification.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [ReaderNotification].
  Future<ReaderNotification> deleteRow(
    _is.DatabaseSession session,
    ReaderNotification row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ReaderNotification>(
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
  Future<List<ReaderNotification>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ReaderNotificationTable> where,
    _is.OrderByBuilder<ReaderNotificationTable>? orderBy,
    _is.OrderByListBuilder<ReaderNotificationTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<ReaderNotification>(
      where: where(ReaderNotification.t),
      orderBy: orderBy?.call(ReaderNotification.t),
      orderByList: orderByList?.call(ReaderNotification.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ReaderNotificationTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<ReaderNotification>(
      where: where?.call(ReaderNotification.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ReaderNotification] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ReaderNotificationTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ReaderNotification>(
      where: where(ReaderNotification.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
