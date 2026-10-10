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
import 'package:limick_client/src/protocol/protocol.dart' as _i0imvg6w;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'dto_feed.dart' as _i8qjxz8q;

abstract class FeedPage
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  FeedPage._({
    required this.items,
    required this.hasMore,
    bool? generating,
  }) : generating = generating ?? false;

  factory FeedPage({
    required List<_i8qjxz8q.FeedItem> items,
    required bool hasMore,
    bool? generating,
  }) = _FeedPageImpl;

  factory FeedPage.fromJson(Map<String, dynamic> jsonSerialization) {
    return FeedPage(
      items: _i0imvg6w.Protocol().deserialize<List<_i8qjxz8q.FeedItem>>(
        jsonSerialization['items'],
      ),
      hasMore: _isc.BoolJsonExtension.fromJson(jsonSerialization['hasMore']),
      generating: jsonSerialization['generating'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['generating']),
    );
  }

  List<_i8qjxz8q.FeedItem> items;

  bool hasMore;

  /// True when more posts are being generated for this user right now.
  bool generating;

  /// Returns a shallow copy of this [FeedPage]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  FeedPage copyWith({
    List<_i8qjxz8q.FeedItem>? items,
    bool? hasMore,
    bool? generating,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FeedPage',
      'items': items.toJson(valueToJson: (v) => v.toJson()),
      'hasMore': hasMore,
      'generating': generating,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FeedPage',
      'items': items.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'hasMore': hasMore,
      'generating': generating,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _FeedPageImpl extends FeedPage {
  _FeedPageImpl({
    required List<_i8qjxz8q.FeedItem> items,
    required bool hasMore,
    bool? generating,
  }) : super._(
         items: items,
         hasMore: hasMore,
         generating: generating,
       );

  /// Returns a shallow copy of this [FeedPage]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  FeedPage copyWith({
    List<_i8qjxz8q.FeedItem>? items,
    bool? hasMore,
    bool? generating,
  }) {
    return FeedPage(
      items: items ?? this.items.map((e0) => e0.copyWith()).toList(),
      hasMore: hasMore ?? this.hasMore,
      generating: generating ?? this.generating,
    );
  }
}
