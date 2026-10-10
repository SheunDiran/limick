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
import 'package:limick_server/src/generated/protocol.dart' as _i8uqouhs;
import 'package:serverpod/serverpod.dart' as _is;
import 'topic.dart' as _iro94j51;

/// Limick's own data for a signed-in user.
abstract class Reader implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Reader._({
    this.id,
    this.authUserId,
    required this.handle,
    required this.displayName,
    String? bio,
    this.field,
    required this.interests,
    int? dailyGoalMinutes,
    bool? onboarded,
    int? avatarHue,
    int? streakDays,
    this.lastActiveDay,
    int? tzOffsetMinutes,
    DateTime? createdAt,
  }) : bio = bio ?? '',
       dailyGoalMinutes = dailyGoalMinutes ?? 15,
       onboarded = onboarded ?? false,
       avatarHue = avatarHue ?? 210,
       streakDays = streakDays ?? 0,
       tzOffsetMinutes = tzOffsetMinutes ?? 0,
       createdAt = createdAt ?? DateTime.now();

  factory Reader({
    int? id,
    _is.UuidValue? authUserId,
    required String handle,
    required String displayName,
    String? bio,
    String? field,
    required List<_iro94j51.Topic> interests,
    int? dailyGoalMinutes,
    bool? onboarded,
    int? avatarHue,
    int? streakDays,
    String? lastActiveDay,
    int? tzOffsetMinutes,
    DateTime? createdAt,
  }) = _ReaderImpl;

  factory Reader.fromJson(Map<String, dynamic> jsonSerialization) {
    return Reader(
      id: jsonSerialization['id'] as int?,
      authUserId: jsonSerialization['authUserId'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(
              jsonSerialization['authUserId'],
            ),
      handle: jsonSerialization['handle'] as String,
      displayName: jsonSerialization['displayName'] as String,
      bio: jsonSerialization['bio'] as String?,
      field: jsonSerialization['field'] as String?,
      interests: _i8uqouhs.Protocol().deserialize<List<_iro94j51.Topic>>(
        jsonSerialization['interests'],
      ),
      dailyGoalMinutes: jsonSerialization['dailyGoalMinutes'] as int?,
      onboarded: jsonSerialization['onboarded'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['onboarded']),
      avatarHue: jsonSerialization['avatarHue'] as int?,
      streakDays: jsonSerialization['streakDays'] as int?,
      lastActiveDay: jsonSerialization['lastActiveDay'] as String?,
      tzOffsetMinutes: jsonSerialization['tzOffsetMinutes'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = ReaderTable();

  static const db = ReaderRepository._();

  @override
  int? id;

  _is.UuidValue? authUserId;

  String handle;

  String displayName;

  String bio;

  String? field;

  List<_iro94j51.Topic> interests;

  int dailyGoalMinutes;

  bool onboarded;

  int avatarHue;

  int streakDays;

  String? lastActiveDay;

  int tzOffsetMinutes;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Reader]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Reader copyWith({
    int? id,
    _is.UuidValue? authUserId,
    String? handle,
    String? displayName,
    String? bio,
    String? field,
    List<_iro94j51.Topic>? interests,
    int? dailyGoalMinutes,
    bool? onboarded,
    int? avatarHue,
    int? streakDays,
    String? lastActiveDay,
    int? tzOffsetMinutes,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Reader',
      if (id != null) 'id': id,
      if (authUserId != null) 'authUserId': authUserId?.toJson(),
      'handle': handle,
      'displayName': displayName,
      'bio': bio,
      if (field != null) 'field': field,
      'interests': interests.toJson(valueToJson: (v) => v.toJson()),
      'dailyGoalMinutes': dailyGoalMinutes,
      'onboarded': onboarded,
      'avatarHue': avatarHue,
      'streakDays': streakDays,
      if (lastActiveDay != null) 'lastActiveDay': lastActiveDay,
      'tzOffsetMinutes': tzOffsetMinutes,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Reader',
      if (id != null) 'id': id,
      'handle': handle,
      'displayName': displayName,
      'bio': bio,
      if (field != null) 'field': field,
      'interests': interests.toJson(valueToJson: (v) => v.toJson()),
      'dailyGoalMinutes': dailyGoalMinutes,
      'onboarded': onboarded,
      'avatarHue': avatarHue,
      'streakDays': streakDays,
      if (lastActiveDay != null) 'lastActiveDay': lastActiveDay,
      'tzOffsetMinutes': tzOffsetMinutes,
      'createdAt': createdAt.toJson(),
    };
  }

  static ReaderInclude include() {
    return ReaderInclude._();
  }

  static ReaderIncludeList includeList({
    _is.WhereExpressionBuilder<ReaderTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ReaderTable>? orderBy,
    _is.OrderByListBuilder<ReaderTable>? orderByList,
    ReaderInclude? include,
  }) {
    return ReaderIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Reader.t),
      orderByList: orderByList?.call(Reader.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ReaderImpl extends Reader {
  _ReaderImpl({
    int? id,
    _is.UuidValue? authUserId,
    required String handle,
    required String displayName,
    String? bio,
    String? field,
    required List<_iro94j51.Topic> interests,
    int? dailyGoalMinutes,
    bool? onboarded,
    int? avatarHue,
    int? streakDays,
    String? lastActiveDay,
    int? tzOffsetMinutes,
    DateTime? createdAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         handle: handle,
         displayName: displayName,
         bio: bio,
         field: field,
         interests: interests,
         dailyGoalMinutes: dailyGoalMinutes,
         onboarded: onboarded,
         avatarHue: avatarHue,
         streakDays: streakDays,
         lastActiveDay: lastActiveDay,
         tzOffsetMinutes: tzOffsetMinutes,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Reader]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Reader copyWith({
    Object? id = _Undefined,
    Object? authUserId = _Undefined,
    String? handle,
    String? displayName,
    String? bio,
    Object? field = _Undefined,
    List<_iro94j51.Topic>? interests,
    int? dailyGoalMinutes,
    bool? onboarded,
    int? avatarHue,
    int? streakDays,
    Object? lastActiveDay = _Undefined,
    int? tzOffsetMinutes,
    DateTime? createdAt,
  }) {
    return Reader(
      id: id is int? ? id : this.id,
      authUserId: authUserId is _is.UuidValue? ? authUserId : this.authUserId,
      handle: handle ?? this.handle,
      displayName: displayName ?? this.displayName,
      bio: bio ?? this.bio,
      field: field is String? ? field : this.field,
      interests: interests ?? this.interests.map((e0) => e0).toList(),
      dailyGoalMinutes: dailyGoalMinutes ?? this.dailyGoalMinutes,
      onboarded: onboarded ?? this.onboarded,
      avatarHue: avatarHue ?? this.avatarHue,
      streakDays: streakDays ?? this.streakDays,
      lastActiveDay: lastActiveDay is String?
          ? lastActiveDay
          : this.lastActiveDay,
      tzOffsetMinutes: tzOffsetMinutes ?? this.tzOffsetMinutes,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class ReaderUpdateTable extends _is.UpdateTable<ReaderTable> {
  ReaderUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> authUserId(
    _is.UuidValue? value,
  ) => _is.ColumnValue(
    table.authUserId,
    value,
  );

  _is.ColumnValue<String, String> handle(String value) => _is.ColumnValue(
    table.handle,
    value,
  );

  _is.ColumnValue<String, String> displayName(String value) => _is.ColumnValue(
    table.displayName,
    value,
  );

  _is.ColumnValue<String, String> bio(String value) => _is.ColumnValue(
    table.bio,
    value,
  );

  _is.ColumnValue<String, String> field(String? value) => _is.ColumnValue(
    table.field,
    value,
  );

  _is.ColumnValue<List<_iro94j51.Topic>, List<_iro94j51.Topic>> interests(
    List<_iro94j51.Topic> value,
  ) => _is.ColumnValue(
    table.interests,
    value,
  );

  _is.ColumnValue<int, int> dailyGoalMinutes(int value) => _is.ColumnValue(
    table.dailyGoalMinutes,
    value,
  );

  _is.ColumnValue<bool, bool> onboarded(bool value) => _is.ColumnValue(
    table.onboarded,
    value,
  );

  _is.ColumnValue<int, int> avatarHue(int value) => _is.ColumnValue(
    table.avatarHue,
    value,
  );

  _is.ColumnValue<int, int> streakDays(int value) => _is.ColumnValue(
    table.streakDays,
    value,
  );

  _is.ColumnValue<String, String> lastActiveDay(String? value) =>
      _is.ColumnValue(
        table.lastActiveDay,
        value,
      );

  _is.ColumnValue<int, int> tzOffsetMinutes(int value) => _is.ColumnValue(
    table.tzOffsetMinutes,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class ReaderTable extends _is.Table<int?> {
  ReaderTable({super.tableRelation}) : super(tableName: 'reader') {
    updateTable = ReaderUpdateTable(this);
    authUserId = _is.ColumnUuid(
      'authUserId',
      this,
    );
    handle = _is.ColumnString(
      'handle',
      this,
    );
    displayName = _is.ColumnString(
      'displayName',
      this,
    );
    bio = _is.ColumnString(
      'bio',
      this,
      hasDefault: true,
    );
    field = _is.ColumnString(
      'field',
      this,
    );
    interests = _is.ColumnSerializable<List<_iro94j51.Topic>>(
      'interests',
      this,
    );
    dailyGoalMinutes = _is.ColumnInt(
      'dailyGoalMinutes',
      this,
      hasDefault: true,
    );
    onboarded = _is.ColumnBool(
      'onboarded',
      this,
      hasDefault: true,
    );
    avatarHue = _is.ColumnInt(
      'avatarHue',
      this,
      hasDefault: true,
    );
    streakDays = _is.ColumnInt(
      'streakDays',
      this,
      hasDefault: true,
    );
    lastActiveDay = _is.ColumnString(
      'lastActiveDay',
      this,
    );
    tzOffsetMinutes = _is.ColumnInt(
      'tzOffsetMinutes',
      this,
      hasDefault: true,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final ReaderUpdateTable updateTable;

  late final _is.ColumnUuid authUserId;

  late final _is.ColumnString handle;

  late final _is.ColumnString displayName;

  late final _is.ColumnString bio;

  late final _is.ColumnString field;

  late final _is.ColumnSerializable<List<_iro94j51.Topic>> interests;

  late final _is.ColumnInt dailyGoalMinutes;

  late final _is.ColumnBool onboarded;

  late final _is.ColumnInt avatarHue;

  late final _is.ColumnInt streakDays;

  late final _is.ColumnString lastActiveDay;

  late final _is.ColumnInt tzOffsetMinutes;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    authUserId,
    handle,
    displayName,
    bio,
    field,
    interests,
    dailyGoalMinutes,
    onboarded,
    avatarHue,
    streakDays,
    lastActiveDay,
    tzOffsetMinutes,
    createdAt,
  ];
}

class ReaderInclude extends _is.IncludeObject {
  ReaderInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => Reader.t;
}

class ReaderIncludeList extends _is.IncludeList {
  ReaderIncludeList._({
    _is.WhereExpressionBuilder<ReaderTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Reader.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Reader.t;
}

class ReaderRepository {
  const ReaderRepository._();

  /// Returns a list of [Reader]s matching the given query parameters.
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
  Future<List<Reader>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ReaderTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ReaderTable>? orderBy,
    _is.OrderByListBuilder<ReaderTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Reader>(
      where: where?.call(Reader.t),
      orderBy: orderBy?.call(Reader.t),
      orderByList: orderByList?.call(Reader.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Reader] matching the given query parameters.
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
  Future<Reader?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ReaderTable>? where,
    int? offset,
    _is.OrderByBuilder<ReaderTable>? orderBy,
    _is.OrderByListBuilder<ReaderTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Reader>(
      where: where?.call(Reader.t),
      orderBy: orderBy?.call(Reader.t),
      orderByList: orderByList?.call(Reader.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Reader] by its [id] or null if no such row exists.
  Future<Reader?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Reader>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Reader]s in the list and returns the inserted rows.
  ///
  /// The returned [Reader]s will have their `id` fields set.
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
  Future<List<Reader>> insert(
    _is.DatabaseSession session,
    List<Reader> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Reader>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Reader] and returns the inserted row.
  ///
  /// The returned [Reader] will have its `id` field set.
  Future<Reader> insertRow(
    _is.DatabaseSession session,
    Reader row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Reader>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Reader]s in the list and returns the resulting rows.
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
  /// The returned [Reader]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Reader>> upsert(
    _is.DatabaseSession session,
    List<Reader> rows, {
    required _is.ColumnSelections<ReaderTable> conflictColumns,
    _is.ColumnSelections<ReaderTable>? updateColumns,
    _is.WhereExpressionBuilder<ReaderTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Reader>(
      rows,
      conflictColumns: conflictColumns(Reader.t),
      updateColumns: updateColumns?.call(Reader.t),
      updateWhere: updateWhere?.call(Reader.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Reader] and returns the resulting row.
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
  /// The returned [Reader] will have its `id` field set.
  Future<Reader?> upsertRow(
    _is.DatabaseSession session,
    Reader row, {
    required _is.ColumnSelections<ReaderTable> conflictColumns,
    _is.ColumnSelections<ReaderTable>? updateColumns,
    _is.WhereExpressionBuilder<ReaderTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Reader>(
      row,
      conflictColumns: conflictColumns(Reader.t),
      updateColumns: updateColumns?.call(Reader.t),
      updateWhere: updateWhere?.call(Reader.t),
      transaction: transaction,
    );
  }

  /// Updates all [Reader]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Reader>> update(
    _is.DatabaseSession session,
    List<Reader> rows, {
    _is.ColumnSelections<ReaderTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Reader>(
      rows,
      columns: columns?.call(Reader.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Reader]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Reader> updateRow(
    _is.DatabaseSession session,
    Reader row, {
    _is.ColumnSelections<ReaderTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Reader>(
      row,
      columns: columns?.call(Reader.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Reader] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Reader?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ReaderUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Reader>(
      id,
      columnValues: columnValues(Reader.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Reader]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Reader>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ReaderUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<ReaderTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ReaderTable>? orderBy,
    _is.OrderByListBuilder<ReaderTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Reader>(
      columnValues: columnValues(Reader.t.updateTable),
      where: where(Reader.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Reader.t),
      orderByList: orderByList?.call(Reader.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Reader]s in the list and returns the deleted rows.
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
  Future<List<Reader>> delete(
    _is.DatabaseSession session,
    List<Reader> rows, {
    _is.OrderByBuilder<ReaderTable>? orderBy,
    _is.OrderByListBuilder<ReaderTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Reader>(
      rows,
      orderBy: orderBy?.call(Reader.t),
      orderByList: orderByList?.call(Reader.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Reader].
  Future<Reader> deleteRow(
    _is.DatabaseSession session,
    Reader row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Reader>(
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
  Future<List<Reader>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ReaderTable> where,
    _is.OrderByBuilder<ReaderTable>? orderBy,
    _is.OrderByListBuilder<ReaderTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Reader>(
      where: where(Reader.t),
      orderBy: orderBy?.call(Reader.t),
      orderByList: orderByList?.call(Reader.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ReaderTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Reader>(
      where: where?.call(Reader.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Reader] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ReaderTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Reader>(
      where: where(Reader.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
