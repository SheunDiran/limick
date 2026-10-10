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
import 'topic.dart' as _iro94j51;

abstract class ProfileStats
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ProfileStats._({
    required this.postsRead,
    required this.wordsSaved,
    required this.booksOpened,
    required this.quizzesAnswered,
    required this.quizzesCorrect,
    required this.streakDays,
    required this.booksFollowed,
    required this.comments,
    required this.topTopics,
  });

  factory ProfileStats({
    required int postsRead,
    required int wordsSaved,
    required int booksOpened,
    required int quizzesAnswered,
    required int quizzesCorrect,
    required int streakDays,
    required int booksFollowed,
    required int comments,
    required List<_iro94j51.Topic> topTopics,
  }) = _ProfileStatsImpl;

  factory ProfileStats.fromJson(Map<String, dynamic> jsonSerialization) {
    return ProfileStats(
      postsRead: jsonSerialization['postsRead'] as int,
      wordsSaved: jsonSerialization['wordsSaved'] as int,
      booksOpened: jsonSerialization['booksOpened'] as int,
      quizzesAnswered: jsonSerialization['quizzesAnswered'] as int,
      quizzesCorrect: jsonSerialization['quizzesCorrect'] as int,
      streakDays: jsonSerialization['streakDays'] as int,
      booksFollowed: jsonSerialization['booksFollowed'] as int,
      comments: jsonSerialization['comments'] as int,
      topTopics: _i0imvg6w.Protocol().deserialize<List<_iro94j51.Topic>>(
        jsonSerialization['topTopics'],
      ),
    );
  }

  int postsRead;

  int wordsSaved;

  int booksOpened;

  int quizzesAnswered;

  int quizzesCorrect;

  int streakDays;

  int booksFollowed;

  int comments;

  List<_iro94j51.Topic> topTopics;

  /// Returns a shallow copy of this [ProfileStats]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ProfileStats copyWith({
    int? postsRead,
    int? wordsSaved,
    int? booksOpened,
    int? quizzesAnswered,
    int? quizzesCorrect,
    int? streakDays,
    int? booksFollowed,
    int? comments,
    List<_iro94j51.Topic>? topTopics,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ProfileStats',
      'postsRead': postsRead,
      'wordsSaved': wordsSaved,
      'booksOpened': booksOpened,
      'quizzesAnswered': quizzesAnswered,
      'quizzesCorrect': quizzesCorrect,
      'streakDays': streakDays,
      'booksFollowed': booksFollowed,
      'comments': comments,
      'topTopics': topTopics.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ProfileStats',
      'postsRead': postsRead,
      'wordsSaved': wordsSaved,
      'booksOpened': booksOpened,
      'quizzesAnswered': quizzesAnswered,
      'quizzesCorrect': quizzesCorrect,
      'streakDays': streakDays,
      'booksFollowed': booksFollowed,
      'comments': comments,
      'topTopics': topTopics.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _ProfileStatsImpl extends ProfileStats {
  _ProfileStatsImpl({
    required int postsRead,
    required int wordsSaved,
    required int booksOpened,
    required int quizzesAnswered,
    required int quizzesCorrect,
    required int streakDays,
    required int booksFollowed,
    required int comments,
    required List<_iro94j51.Topic> topTopics,
  }) : super._(
         postsRead: postsRead,
         wordsSaved: wordsSaved,
         booksOpened: booksOpened,
         quizzesAnswered: quizzesAnswered,
         quizzesCorrect: quizzesCorrect,
         streakDays: streakDays,
         booksFollowed: booksFollowed,
         comments: comments,
         topTopics: topTopics,
       );

  /// Returns a shallow copy of this [ProfileStats]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ProfileStats copyWith({
    int? postsRead,
    int? wordsSaved,
    int? booksOpened,
    int? quizzesAnswered,
    int? quizzesCorrect,
    int? streakDays,
    int? booksFollowed,
    int? comments,
    List<_iro94j51.Topic>? topTopics,
  }) {
    return ProfileStats(
      postsRead: postsRead ?? this.postsRead,
      wordsSaved: wordsSaved ?? this.wordsSaved,
      booksOpened: booksOpened ?? this.booksOpened,
      quizzesAnswered: quizzesAnswered ?? this.quizzesAnswered,
      quizzesCorrect: quizzesCorrect ?? this.quizzesCorrect,
      streakDays: streakDays ?? this.streakDays,
      booksFollowed: booksFollowed ?? this.booksFollowed,
      comments: comments ?? this.comments,
      topTopics: topTopics ?? this.topTopics.map((e0) => e0).toList(),
    );
  }
}
