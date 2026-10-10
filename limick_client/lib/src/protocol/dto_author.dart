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

/// The public face of a user, attached to comments and messages.
abstract class Author
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Author._({
    required this.id,
    required this.handle,
    required this.displayName,
    required this.avatarHue,
    bool? official,
    this.bookId,
  }) : official = official ?? false;

  factory Author({
    required int id,
    required String handle,
    required String displayName,
    required int avatarHue,
    bool? official,
    int? bookId,
  }) = _AuthorImpl;

  factory Author.fromJson(Map<String, dynamic> jsonSerialization) {
    return Author(
      id: jsonSerialization['id'] as int,
      handle: jsonSerialization['handle'] as String,
      displayName: jsonSerialization['displayName'] as String,
      avatarHue: jsonSerialization['avatarHue'] as int,
      official: jsonSerialization['official'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['official']),
      bookId: jsonSerialization['bookId'] as int?,
    );
  }

  int id;

  String handle;

  String displayName;

  int avatarHue;

  /// The platform's own account.
  bool official;

  /// Set when this is a book account speaking (AI reply).
  int? bookId;

  /// Returns a shallow copy of this [Author]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Author copyWith({
    int? id,
    String? handle,
    String? displayName,
    int? avatarHue,
    bool? official,
    int? bookId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Author',
      'id': id,
      'handle': handle,
      'displayName': displayName,
      'avatarHue': avatarHue,
      'official': official,
      if (bookId != null) 'bookId': bookId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Author',
      'id': id,
      'handle': handle,
      'displayName': displayName,
      'avatarHue': avatarHue,
      'official': official,
      if (bookId != null) 'bookId': bookId,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AuthorImpl extends Author {
  _AuthorImpl({
    required int id,
    required String handle,
    required String displayName,
    required int avatarHue,
    bool? official,
    int? bookId,
  }) : super._(
         id: id,
         handle: handle,
         displayName: displayName,
         avatarHue: avatarHue,
         official: official,
         bookId: bookId,
       );

  /// Returns a shallow copy of this [Author]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Author copyWith({
    int? id,
    String? handle,
    String? displayName,
    int? avatarHue,
    bool? official,
    Object? bookId = _Undefined,
  }) {
    return Author(
      id: id ?? this.id,
      handle: handle ?? this.handle,
      displayName: displayName ?? this.displayName,
      avatarHue: avatarHue ?? this.avatarHue,
      official: official ?? this.official,
      bookId: bookId is int? ? bookId : this.bookId,
    );
  }
}
