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

/// How long a post was on screen, sent in batches by the client.
abstract class ViewSignal
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ViewSignal._({
    required this.postId,
    required this.dwellMs,
  });

  factory ViewSignal({
    required int postId,
    required int dwellMs,
  }) = _ViewSignalImpl;

  factory ViewSignal.fromJson(Map<String, dynamic> jsonSerialization) {
    return ViewSignal(
      postId: jsonSerialization['postId'] as int,
      dwellMs: jsonSerialization['dwellMs'] as int,
    );
  }

  int postId;

  int dwellMs;

  /// Returns a shallow copy of this [ViewSignal]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ViewSignal copyWith({
    int? postId,
    int? dwellMs,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ViewSignal',
      'postId': postId,
      'dwellMs': dwellMs,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ViewSignal',
      'postId': postId,
      'dwellMs': dwellMs,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _ViewSignalImpl extends ViewSignal {
  _ViewSignalImpl({
    required int postId,
    required int dwellMs,
  }) : super._(
         postId: postId,
         dwellMs: dwellMs,
       );

  /// Returns a shallow copy of this [ViewSignal]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ViewSignal copyWith({
    int? postId,
    int? dwellMs,
  }) {
    return ViewSignal(
      postId: postId ?? this.postId,
      dwellMs: dwellMs ?? this.dwellMs,
    );
  }
}
