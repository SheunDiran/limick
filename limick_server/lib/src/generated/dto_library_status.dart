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

/// Public, live numbers about the library. Shown in the app and useful
/// for checking that the background pipeline is working.
abstract class LibraryStatus
    implements _is.SerializableModel, _is.ProtocolSerialization {
  LibraryStatus._({
    required this.booksCatalogued,
    required this.booksReady,
    required this.booksQueued,
    required this.posts,
    required this.generationEnabled,
  });

  factory LibraryStatus({
    required int booksCatalogued,
    required int booksReady,
    required int booksQueued,
    required int posts,
    required bool generationEnabled,
  }) = _LibraryStatusImpl;

  factory LibraryStatus.fromJson(Map<String, dynamic> jsonSerialization) {
    return LibraryStatus(
      booksCatalogued: jsonSerialization['booksCatalogued'] as int,
      booksReady: jsonSerialization['booksReady'] as int,
      booksQueued: jsonSerialization['booksQueued'] as int,
      posts: jsonSerialization['posts'] as int,
      generationEnabled: _is.BoolJsonExtension.fromJson(
        jsonSerialization['generationEnabled'],
      ),
    );
  }

  int booksCatalogued;

  int booksReady;

  int booksQueued;

  int posts;

  bool generationEnabled;

  /// Returns a shallow copy of this [LibraryStatus]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  LibraryStatus copyWith({
    int? booksCatalogued,
    int? booksReady,
    int? booksQueued,
    int? posts,
    bool? generationEnabled,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LibraryStatus',
      'booksCatalogued': booksCatalogued,
      'booksReady': booksReady,
      'booksQueued': booksQueued,
      'posts': posts,
      'generationEnabled': generationEnabled,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'LibraryStatus',
      'booksCatalogued': booksCatalogued,
      'booksReady': booksReady,
      'booksQueued': booksQueued,
      'posts': posts,
      'generationEnabled': generationEnabled,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _LibraryStatusImpl extends LibraryStatus {
  _LibraryStatusImpl({
    required int booksCatalogued,
    required int booksReady,
    required int booksQueued,
    required int posts,
    required bool generationEnabled,
  }) : super._(
         booksCatalogued: booksCatalogued,
         booksReady: booksReady,
         booksQueued: booksQueued,
         posts: posts,
         generationEnabled: generationEnabled,
       );

  /// Returns a shallow copy of this [LibraryStatus]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  LibraryStatus copyWith({
    int? booksCatalogued,
    int? booksReady,
    int? booksQueued,
    int? posts,
    bool? generationEnabled,
  }) {
    return LibraryStatus(
      booksCatalogued: booksCatalogued ?? this.booksCatalogued,
      booksReady: booksReady ?? this.booksReady,
      booksQueued: booksQueued ?? this.booksQueued,
      posts: posts ?? this.posts,
      generationEnabled: generationEnabled ?? this.generationEnabled,
    );
  }
}
