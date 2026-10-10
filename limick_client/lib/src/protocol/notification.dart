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
import 'notification_kind.dart' as _ipnxo26v;

abstract class ReaderNotification
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
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
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['read']),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int profileId;

  String actorName;

  String actorHandle;

  _ipnxo26v.NotificationKind kind;

  int? postId;

  int? commentId;

  bool read;

  DateTime createdAt;

  /// Returns a shallow copy of this [ReaderNotification]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
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

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
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
  @_isc.useResult
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
