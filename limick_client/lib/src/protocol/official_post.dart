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
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'official_post_kind.dart' as _iwjxx537;

/// A post from the official @limick account. Daily posts are built from
/// real data (books, generated posts, activity counts); nothing is invented.
abstract class OfficialPost
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
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
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
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

  /// Returns a shallow copy of this [OfficialPost]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
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

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
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
  @_isc.useResult
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
