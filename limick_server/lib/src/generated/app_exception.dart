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

/// A user-facing error. [message] is safe to show in the UI.
abstract class AppException
    implements
        _is.SerializableException,
        _is.SerializableModel,
        _is.ProtocolSerialization {
  AppException._({
    required this.message,
    String? code,
  }) : code = code ?? 'error';

  factory AppException({
    required String message,
    String? code,
  }) = _AppExceptionImpl;

  factory AppException.fromJson(Map<String, dynamic> jsonSerialization) {
    return AppException(
      message: jsonSerialization['message'] as String,
      code: jsonSerialization['code'] as String?,
    );
  }

  String message;

  String code;

  /// Returns a shallow copy of this [AppException]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  AppException copyWith({
    String? message,
    String? code,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AppException',
      'message': message,
      'code': code,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AppException',
      'message': message,
      'code': code,
    };
  }

  @override
  String toString() {
    return 'AppException(message: $message, code: $code)';
  }
}

class _AppExceptionImpl extends AppException {
  _AppExceptionImpl({
    required String message,
    String? code,
  }) : super._(
         message: message,
         code: code,
       );

  /// Returns a shallow copy of this [AppException]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  AppException copyWith({
    String? message,
    String? code,
  }) {
    return AppException(
      message: message ?? this.message,
      code: code ?? this.code,
    );
  }
}
