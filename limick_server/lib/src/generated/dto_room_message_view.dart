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
import 'dto_author.dart' as _irki9rqm;
import 'room_message.dart' as _i2z40emo;

abstract class RoomMessageView
    implements _is.SerializableModel, _is.ProtocolSerialization {
  RoomMessageView._({
    required this.message,
    required this.author,
  });

  factory RoomMessageView({
    required _i2z40emo.RoomMessage message,
    required _irki9rqm.Author author,
  }) = _RoomMessageViewImpl;

  factory RoomMessageView.fromJson(Map<String, dynamic> jsonSerialization) {
    return RoomMessageView(
      message: _i8uqouhs.Protocol().deserialize<_i2z40emo.RoomMessage>(
        jsonSerialization['message'],
      ),
      author: _i8uqouhs.Protocol().deserialize<_irki9rqm.Author>(
        jsonSerialization['author'],
      ),
    );
  }

  _i2z40emo.RoomMessage message;

  _irki9rqm.Author author;

  /// Returns a shallow copy of this [RoomMessageView]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  RoomMessageView copyWith({
    _i2z40emo.RoomMessage? message,
    _irki9rqm.Author? author,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RoomMessageView',
      'message': message.toJson(),
      'author': author.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RoomMessageView',
      'message': message.toJsonForProtocol(),
      'author': author.toJsonForProtocol(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _RoomMessageViewImpl extends RoomMessageView {
  _RoomMessageViewImpl({
    required _i2z40emo.RoomMessage message,
    required _irki9rqm.Author author,
  }) : super._(
         message: message,
         author: author,
       );

  /// Returns a shallow copy of this [RoomMessageView]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  RoomMessageView copyWith({
    _i2z40emo.RoomMessage? message,
    _irki9rqm.Author? author,
  }) {
    return RoomMessageView(
      message: message ?? this.message.copyWith(),
      author: author ?? this.author.copyWith(),
    );
  }
}
