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

/// Cache entry used for rate limiting. Server only.
abstract class RateLimitMarker
    implements _is.SerializableModel, _is.ProtocolSerialization {
  RateLimitMarker._({DateTime? createdAt})
    : createdAt = createdAt ?? DateTime.now();

  factory RateLimitMarker({DateTime? createdAt}) = _RateLimitMarkerImpl;

  factory RateLimitMarker.fromJson(Map<String, dynamic> jsonSerialization) {
    return RateLimitMarker(
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  DateTime createdAt;

  /// Returns a shallow copy of this [RateLimitMarker]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  RateLimitMarker copyWith({DateTime? createdAt});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RateLimitMarker',
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _RateLimitMarkerImpl extends RateLimitMarker {
  _RateLimitMarkerImpl({DateTime? createdAt}) : super._(createdAt: createdAt);

  /// Returns a shallow copy of this [RateLimitMarker]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  RateLimitMarker copyWith({DateTime? createdAt}) {
    return RateLimitMarker(createdAt: createdAt ?? this.createdAt);
  }
}
