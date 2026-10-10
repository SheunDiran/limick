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
import 'official_post_kind.dart' as _iwjxx537;

/// A post from the official @limick account. Daily posts are built from
/// real data (books, generated posts, activity counts); nothing is invented.
abstract class OfficialPost
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  OfficialPost._({
    this.id,
    required this.kind,
    required this.title,
    required this.body,
    this.bookId,
    this.postId,
    this.action,
    this.actionLabel,
    int? position,
    this.day,
    DateTime? createdAt,
  }) : position = position ?? 0,
       createdAt = createdAt ?? DateTime.now();

  factory OfficialPost({
    int? id,
    required _iwjxx537.OfficialPostKind kind,
    required String title,
    required String body,
    int? bookId,
    int? postId,
    String? action,
    String? actionLabel,
    int? position,
    String? day,
    DateTime? createdAt,
  }) = _OfficialPostImpl;

  factory OfficialPost.fromJson(Map<String, dynamic> jsonSerialization) {
    return OfficialPost(
      id: jsonSerialization['id'] as int?,
      kind: _iwjxx537.OfficialPostKind.fromJson(
        (jsonSerialization['kind'] as String),
      ),
      title: jsonSerialization['title'] as String,
      body: jsonSerialization['body'] as String,
      bookId: jsonSerialization['bookId'] as int?,
      postId: jsonSerialization['postId'] as int?,
      action: jsonSerialization['action'] as String?,
      actionLabel: jsonSerialization['actionLabel'] as String?,
      position: jsonSerialization['position'] as int?,
      day: jsonSerialization['day'] as String?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = OfficialPostTable();

  static const db = OfficialPostRepository._();

  @override
  int? id;

  _iwjxx537.OfficialPostKind kind;

  String title;

  String body;

  /// A book to open from the post, if any.
  int? bookId;

  /// A generated post to open from the post, if any.
  int? postId;

  /// What the call-to-action button does: openBook, openPost, startBreak,
  /// openRooms, openWords, openDiscover.
  String? action;

  String? actionLabel;

  /// Tips are shown in this order.
  int position;

  /// yyyy-mm-dd for daily posts, so each kind is published once a day.
  String? day;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [OfficialPost]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  OfficialPost copyWith({
    int? id,
    _iwjxx537.OfficialPostKind? kind,
    String? title,
    String? body,
    int? bookId,
    int? postId,
    String? action,
    String? actionLabel,
    int? position,
    String? day,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OfficialPost',
      if (id != null) 'id': id,
      'kind': kind.toJson(),
      'title': title,
      'body': body,
      if (bookId != null) 'bookId': bookId,
      if (postId != null) 'postId': postId,
      if (action != null) 'action': action,
      if (actionLabel != null) 'actionLabel': actionLabel,
      'position': position,
      if (day != null) 'day': day,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'OfficialPost',
      if (id != null) 'id': id,
      'kind': kind.toJson(),
      'title': title,
      'body': body,
      if (bookId != null) 'bookId': bookId,
      if (postId != null) 'postId': postId,
      if (action != null) 'action': action,
      if (actionLabel != null) 'actionLabel': actionLabel,
      'position': position,
      if (day != null) 'day': day,
      'createdAt': createdAt.toJson(),
    };
  }

  static OfficialPostInclude include() {
    return OfficialPostInclude._();
  }

  static OfficialPostIncludeList includeList({
    _is.WhereExpressionBuilder<OfficialPostTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<OfficialPostTable>? orderBy,
    _is.OrderByListBuilder<OfficialPostTable>? orderByList,
    OfficialPostInclude? include,
  }) {
    return OfficialPostIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(OfficialPost.t),
      orderByList: orderByList?.call(OfficialPost.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OfficialPostImpl extends OfficialPost {
  _OfficialPostImpl({
    int? id,
    required _iwjxx537.OfficialPostKind kind,
    required String title,
    required String body,
    int? bookId,
    int? postId,
    String? action,
    String? actionLabel,
    int? position,
    String? day,
    DateTime? createdAt,
  }) : super._(
         id: id,
         kind: kind,
         title: title,
         body: body,
         bookId: bookId,
         postId: postId,
         action: action,
         actionLabel: actionLabel,
         position: position,
         day: day,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [OfficialPost]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  OfficialPost copyWith({
    Object? id = _Undefined,
    _iwjxx537.OfficialPostKind? kind,
    String? title,
    String? body,
    Object? bookId = _Undefined,
    Object? postId = _Undefined,
    Object? action = _Undefined,
    Object? actionLabel = _Undefined,
    int? position,
    Object? day = _Undefined,
    DateTime? createdAt,
  }) {
    return OfficialPost(
      id: id is int? ? id : this.id,
      kind: kind ?? this.kind,
      title: title ?? this.title,
      body: body ?? this.body,
      bookId: bookId is int? ? bookId : this.bookId,
      postId: postId is int? ? postId : this.postId,
      action: action is String? ? action : this.action,
      actionLabel: actionLabel is String? ? actionLabel : this.actionLabel,
      position: position ?? this.position,
      day: day is String? ? day : this.day,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class OfficialPostUpdateTable extends _is.UpdateTable<OfficialPostTable> {
  OfficialPostUpdateTable(super.table);

  _is.ColumnValue<_iwjxx537.OfficialPostKind, _iwjxx537.OfficialPostKind> kind(
    _iwjxx537.OfficialPostKind value,
  ) => _is.ColumnValue(
    table.kind,
    value,
  );

  _is.ColumnValue<String, String> title(String value) => _is.ColumnValue(
    table.title,
    value,
  );

  _is.ColumnValue<String, String> body(String value) => _is.ColumnValue(
    table.body,
    value,
  );

  _is.ColumnValue<int, int> bookId(int? value) => _is.ColumnValue(
    table.bookId,
    value,
  );

  _is.ColumnValue<int, int> postId(int? value) => _is.ColumnValue(
    table.postId,
    value,
  );

  _is.ColumnValue<String, String> action(String? value) => _is.ColumnValue(
    table.action,
    value,
  );

  _is.ColumnValue<String, String> actionLabel(String? value) => _is.ColumnValue(
    table.actionLabel,
    value,
  );

  _is.ColumnValue<int, int> position(int value) => _is.ColumnValue(
    table.position,
    value,
  );

  _is.ColumnValue<String, String> day(String? value) => _is.ColumnValue(
    table.day,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class OfficialPostTable extends _is.Table<int?> {
  OfficialPostTable({super.tableRelation}) : super(tableName: 'official_post') {
    updateTable = OfficialPostUpdateTable(this);
    kind = _is.ColumnEnum(
      'kind',
      this,
      _is.EnumSerialization.byName,
    );
    title = _is.ColumnString(
      'title',
      this,
    );
    body = _is.ColumnString(
      'body',
      this,
    );
    bookId = _is.ColumnInt(
      'bookId',
      this,
    );
    postId = _is.ColumnInt(
      'postId',
      this,
    );
    action = _is.ColumnString(
      'action',
      this,
    );
    actionLabel = _is.ColumnString(
      'actionLabel',
      this,
    );
    position = _is.ColumnInt(
      'position',
      this,
      hasDefault: true,
    );
    day = _is.ColumnString(
      'day',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final OfficialPostUpdateTable updateTable;

  late final _is.ColumnEnum<_iwjxx537.OfficialPostKind> kind;

  late final _is.ColumnString title;

  late final _is.ColumnString body;

  /// A book to open from the post, if any.
  late final _is.ColumnInt bookId;

  /// A generated post to open from the post, if any.
  late final _is.ColumnInt postId;

  /// What the call-to-action button does: openBook, openPost, startBreak,
  /// openRooms, openWords, openDiscover.
  late final _is.ColumnString action;

  late final _is.ColumnString actionLabel;

  /// Tips are shown in this order.
  late final _is.ColumnInt position;

  /// yyyy-mm-dd for daily posts, so each kind is published once a day.
  late final _is.ColumnString day;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    kind,
    title,
    body,
    bookId,
    postId,
    action,
    actionLabel,
    position,
    day,
    createdAt,
  ];
}

class OfficialPostInclude extends _is.IncludeObject {
  OfficialPostInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => OfficialPost.t;
}

class OfficialPostIncludeList extends _is.IncludeList {
  OfficialPostIncludeList._({
    _is.WhereExpressionBuilder<OfficialPostTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(OfficialPost.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => OfficialPost.t;
}

class OfficialPostRepository {
  const OfficialPostRepository._();

  /// Returns a list of [OfficialPost]s matching the given query parameters.
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
  Future<List<OfficialPost>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<OfficialPostTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<OfficialPostTable>? orderBy,
    _is.OrderByListBuilder<OfficialPostTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<OfficialPost>(
      where: where?.call(OfficialPost.t),
      orderBy: orderBy?.call(OfficialPost.t),
      orderByList: orderByList?.call(OfficialPost.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [OfficialPost] matching the given query parameters.
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
  Future<OfficialPost?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<OfficialPostTable>? where,
    int? offset,
    _is.OrderByBuilder<OfficialPostTable>? orderBy,
    _is.OrderByListBuilder<OfficialPostTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<OfficialPost>(
      where: where?.call(OfficialPost.t),
      orderBy: orderBy?.call(OfficialPost.t),
      orderByList: orderByList?.call(OfficialPost.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [OfficialPost] by its [id] or null if no such row exists.
  Future<OfficialPost?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<OfficialPost>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [OfficialPost]s in the list and returns the inserted rows.
  ///
  /// The returned [OfficialPost]s will have their `id` fields set.
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
  Future<List<OfficialPost>> insert(
    _is.DatabaseSession session,
    List<OfficialPost> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<OfficialPost>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [OfficialPost] and returns the inserted row.
  ///
  /// The returned [OfficialPost] will have its `id` field set.
  Future<OfficialPost> insertRow(
    _is.DatabaseSession session,
    OfficialPost row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<OfficialPost>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [OfficialPost]s in the list and returns the resulting rows.
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
  /// The returned [OfficialPost]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<OfficialPost>> upsert(
    _is.DatabaseSession session,
    List<OfficialPost> rows, {
    required _is.ColumnSelections<OfficialPostTable> conflictColumns,
    _is.ColumnSelections<OfficialPostTable>? updateColumns,
    _is.WhereExpressionBuilder<OfficialPostTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<OfficialPost>(
      rows,
      conflictColumns: conflictColumns(OfficialPost.t),
      updateColumns: updateColumns?.call(OfficialPost.t),
      updateWhere: updateWhere?.call(OfficialPost.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [OfficialPost] and returns the resulting row.
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
  /// The returned [OfficialPost] will have its `id` field set.
  Future<OfficialPost?> upsertRow(
    _is.DatabaseSession session,
    OfficialPost row, {
    required _is.ColumnSelections<OfficialPostTable> conflictColumns,
    _is.ColumnSelections<OfficialPostTable>? updateColumns,
    _is.WhereExpressionBuilder<OfficialPostTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<OfficialPost>(
      row,
      conflictColumns: conflictColumns(OfficialPost.t),
      updateColumns: updateColumns?.call(OfficialPost.t),
      updateWhere: updateWhere?.call(OfficialPost.t),
      transaction: transaction,
    );
  }

  /// Updates all [OfficialPost]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<OfficialPost>> update(
    _is.DatabaseSession session,
    List<OfficialPost> rows, {
    _is.ColumnSelections<OfficialPostTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<OfficialPost>(
      rows,
      columns: columns?.call(OfficialPost.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [OfficialPost]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<OfficialPost> updateRow(
    _is.DatabaseSession session,
    OfficialPost row, {
    _is.ColumnSelections<OfficialPostTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<OfficialPost>(
      row,
      columns: columns?.call(OfficialPost.t),
      transaction: transaction,
    );
  }

  /// Updates a single [OfficialPost] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<OfficialPost?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<OfficialPostUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<OfficialPost>(
      id,
      columnValues: columnValues(OfficialPost.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [OfficialPost]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<OfficialPost>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<OfficialPostUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<OfficialPostTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<OfficialPostTable>? orderBy,
    _is.OrderByListBuilder<OfficialPostTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<OfficialPost>(
      columnValues: columnValues(OfficialPost.t.updateTable),
      where: where(OfficialPost.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(OfficialPost.t),
      orderByList: orderByList?.call(OfficialPost.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [OfficialPost]s in the list and returns the deleted rows.
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
  Future<List<OfficialPost>> delete(
    _is.DatabaseSession session,
    List<OfficialPost> rows, {
    _is.OrderByBuilder<OfficialPostTable>? orderBy,
    _is.OrderByListBuilder<OfficialPostTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<OfficialPost>(
      rows,
      orderBy: orderBy?.call(OfficialPost.t),
      orderByList: orderByList?.call(OfficialPost.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [OfficialPost].
  Future<OfficialPost> deleteRow(
    _is.DatabaseSession session,
    OfficialPost row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<OfficialPost>(
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
  Future<List<OfficialPost>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<OfficialPostTable> where,
    _is.OrderByBuilder<OfficialPostTable>? orderBy,
    _is.OrderByListBuilder<OfficialPostTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<OfficialPost>(
      where: where(OfficialPost.t),
      orderBy: orderBy?.call(OfficialPost.t),
      orderByList: orderByList?.call(OfficialPost.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<OfficialPostTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<OfficialPost>(
      where: where?.call(OfficialPost.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [OfficialPost] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<OfficialPostTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<OfficialPost>(
      where: where(OfficialPost.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
