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
import 'book.dart' as _ik00prxe;
import 'feed_item_kind.dart' as _i5lurufd;
import 'official_post.dart' as _i2bhchuw;
import 'post.dart' as _iwx4avst;
import 'saved_word.dart' as _itxlv1gb;

/// One card in a feed: a post with the viewer's state, or a word review.
abstract class FeedItem
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  FeedItem._({
    required this.kind,
    this.post,
    this.book,
    this.chapterTitle,
    bool? liked,
    bool? saved,
    bool? followingBook,
    this.quizChoice,
    this.quizCorrectIndex,
    this.quizExplanation,
    this.quizCounts,
    this.debateVote,
    this.reason,
    this.review,
    this.official,
  }) : liked = liked ?? false,
       saved = saved ?? false,
       followingBook = followingBook ?? false;

  factory FeedItem({
    required _i5lurufd.FeedItemKind kind,
    _iwx4avst.Post? post,
    _ik00prxe.Book? book,
    String? chapterTitle,
    bool? liked,
    bool? saved,
    bool? followingBook,
    int? quizChoice,
    int? quizCorrectIndex,
    String? quizExplanation,
    List<int>? quizCounts,
    bool? debateVote,
    String? reason,
    _itxlv1gb.SavedWord? review,
    _i2bhchuw.OfficialPost? official,
  }) = _FeedItemImpl;

  factory FeedItem.fromJson(Map<String, dynamic> jsonSerialization) {
    return FeedItem(
      kind: _i5lurufd.FeedItemKind.fromJson(
        (jsonSerialization['kind'] as String),
      ),
      post: jsonSerialization['post'] == null
          ? null
          : _i0imvg6w.Protocol().deserialize<_iwx4avst.Post>(
              jsonSerialization['post'],
            ),
      book: jsonSerialization['book'] == null
          ? null
          : _i0imvg6w.Protocol().deserialize<_ik00prxe.Book>(
              jsonSerialization['book'],
            ),
      chapterTitle: jsonSerialization['chapterTitle'] as String?,
      liked: jsonSerialization['liked'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['liked']),
      saved: jsonSerialization['saved'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['saved']),
      followingBook: jsonSerialization['followingBook'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['followingBook']),
      quizChoice: jsonSerialization['quizChoice'] as int?,
      quizCorrectIndex: jsonSerialization['quizCorrectIndex'] as int?,
      quizExplanation: jsonSerialization['quizExplanation'] as String?,
      quizCounts: jsonSerialization['quizCounts'] == null
          ? null
          : _i0imvg6w.Protocol().deserialize<List<int>>(
              jsonSerialization['quizCounts'],
            ),
      debateVote: jsonSerialization['debateVote'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['debateVote']),
      reason: jsonSerialization['reason'] as String?,
      review: jsonSerialization['review'] == null
          ? null
          : _i0imvg6w.Protocol().deserialize<_itxlv1gb.SavedWord>(
              jsonSerialization['review'],
            ),
      official: jsonSerialization['official'] == null
          ? null
          : _i0imvg6w.Protocol().deserialize<_i2bhchuw.OfficialPost>(
              jsonSerialization['official'],
            ),
    );
  }

  _i5lurufd.FeedItemKind kind;

  _iwx4avst.Post? post;

  _ik00prxe.Book? book;

  String? chapterTitle;

  bool liked;

  bool saved;

  bool followingBook;

  int? quizChoice;

  int? quizCorrectIndex;

  String? quizExplanation;

  /// Real answer counts per option, revealed after the reader answers.
  List<int>? quizCounts;

  bool? debateVote;

  String? reason;

  _itxlv1gb.SavedWord? review;

  _i2bhchuw.OfficialPost? official;

  /// Returns a shallow copy of this [FeedItem]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  FeedItem copyWith({
    _i5lurufd.FeedItemKind? kind,
    _iwx4avst.Post? post,
    _ik00prxe.Book? book,
    String? chapterTitle,
    bool? liked,
    bool? saved,
    bool? followingBook,
    int? quizChoice,
    int? quizCorrectIndex,
    String? quizExplanation,
    List<int>? quizCounts,
    bool? debateVote,
    String? reason,
    _itxlv1gb.SavedWord? review,
    _i2bhchuw.OfficialPost? official,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FeedItem',
      'kind': kind.toJson(),
      if (post != null) 'post': post?.toJson(),
      if (book != null) 'book': book?.toJson(),
      if (chapterTitle != null) 'chapterTitle': chapterTitle,
      'liked': liked,
      'saved': saved,
      'followingBook': followingBook,
      if (quizChoice != null) 'quizChoice': quizChoice,
      if (quizCorrectIndex != null) 'quizCorrectIndex': quizCorrectIndex,
      if (quizExplanation != null) 'quizExplanation': quizExplanation,
      if (quizCounts != null) 'quizCounts': quizCounts?.toJson(),
      if (debateVote != null) 'debateVote': debateVote,
      if (reason != null) 'reason': reason,
      if (review != null) 'review': review?.toJson(),
      if (official != null) 'official': official?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FeedItem',
      'kind': kind.toJson(),
      if (post != null) 'post': post?.toJsonForProtocol(),
      if (book != null) 'book': book?.toJsonForProtocol(),
      if (chapterTitle != null) 'chapterTitle': chapterTitle,
      'liked': liked,
      'saved': saved,
      'followingBook': followingBook,
      if (quizChoice != null) 'quizChoice': quizChoice,
      if (quizCorrectIndex != null) 'quizCorrectIndex': quizCorrectIndex,
      if (quizExplanation != null) 'quizExplanation': quizExplanation,
      if (quizCounts != null) 'quizCounts': quizCounts?.toJson(),
      if (debateVote != null) 'debateVote': debateVote,
      if (reason != null) 'reason': reason,
      if (review != null) 'review': review?.toJsonForProtocol(),
      if (official != null) 'official': official?.toJsonForProtocol(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FeedItemImpl extends FeedItem {
  _FeedItemImpl({
    required _i5lurufd.FeedItemKind kind,
    _iwx4avst.Post? post,
    _ik00prxe.Book? book,
    String? chapterTitle,
    bool? liked,
    bool? saved,
    bool? followingBook,
    int? quizChoice,
    int? quizCorrectIndex,
    String? quizExplanation,
    List<int>? quizCounts,
    bool? debateVote,
    String? reason,
    _itxlv1gb.SavedWord? review,
    _i2bhchuw.OfficialPost? official,
  }) : super._(
         kind: kind,
         post: post,
         book: book,
         chapterTitle: chapterTitle,
         liked: liked,
         saved: saved,
         followingBook: followingBook,
         quizChoice: quizChoice,
         quizCorrectIndex: quizCorrectIndex,
         quizExplanation: quizExplanation,
         quizCounts: quizCounts,
         debateVote: debateVote,
         reason: reason,
         review: review,
         official: official,
       );

  /// Returns a shallow copy of this [FeedItem]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  FeedItem copyWith({
    _i5lurufd.FeedItemKind? kind,
    Object? post = _Undefined,
    Object? book = _Undefined,
    Object? chapterTitle = _Undefined,
    bool? liked,
    bool? saved,
    bool? followingBook,
    Object? quizChoice = _Undefined,
    Object? quizCorrectIndex = _Undefined,
    Object? quizExplanation = _Undefined,
    Object? quizCounts = _Undefined,
    Object? debateVote = _Undefined,
    Object? reason = _Undefined,
    Object? review = _Undefined,
    Object? official = _Undefined,
  }) {
    return FeedItem(
      kind: kind ?? this.kind,
      post: post is _iwx4avst.Post? ? post : this.post?.copyWith(),
      book: book is _ik00prxe.Book? ? book : this.book?.copyWith(),
      chapterTitle: chapterTitle is String? ? chapterTitle : this.chapterTitle,
      liked: liked ?? this.liked,
      saved: saved ?? this.saved,
      followingBook: followingBook ?? this.followingBook,
      quizChoice: quizChoice is int? ? quizChoice : this.quizChoice,
      quizCorrectIndex: quizCorrectIndex is int?
          ? quizCorrectIndex
          : this.quizCorrectIndex,
      quizExplanation: quizExplanation is String?
          ? quizExplanation
          : this.quizExplanation,
      quizCounts: quizCounts is List<int>?
          ? quizCounts
          : this.quizCounts?.map((e0) => e0).toList(),
      debateVote: debateVote is bool? ? debateVote : this.debateVote,
      reason: reason is String? ? reason : this.reason,
      review: review is _itxlv1gb.SavedWord? ? review : this.review?.copyWith(),
      official: official is _i2bhchuw.OfficialPost?
          ? official
          : this.official?.copyWith(),
    );
  }
}
