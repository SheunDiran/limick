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
import 'dart:async' as _ida;
import 'package:http/http.dart' as _i85jenna;
import 'package:limick_client/src/protocol/book.dart' as _i5tn6nrb;
import 'package:limick_client/src/protocol/dto_author.dart' as _igl91g7y;
import 'package:limick_client/src/protocol/dto_book_detail.dart' as _if2meqjg;
import 'package:limick_client/src/protocol/dto_break_summary.dart' as _ipohq6op;
import 'package:limick_client/src/protocol/dto_chapter_content.dart'
    as _i0wj6hma;
import 'package:limick_client/src/protocol/dto_comment_event.dart' as _iuk66ey6;
import 'package:limick_client/src/protocol/dto_comment_view.dart' as _ileb9px8;
import 'package:limick_client/src/protocol/dto_continue.dart' as _i50xy7df;
import 'package:limick_client/src/protocol/dto_feed.dart' as _i2a5226i;
import 'package:limick_client/src/protocol/dto_feed_page.dart' as _ioxiasn3;
import 'package:limick_client/src/protocol/dto_library_status.dart'
    as _i2s76435;
import 'package:limick_client/src/protocol/dto_me.dart' as _ia3wfgcv;
import 'package:limick_client/src/protocol/dto_onboarding.dart' as _itf5sm15;
import 'package:limick_client/src/protocol/dto_profile_stats.dart' as _ilqwmwet;
import 'package:limick_client/src/protocol/dto_public_profile.dart'
    as _iruz11o4;
import 'package:limick_client/src/protocol/dto_quiz_result.dart' as _ip6mgp95;
import 'package:limick_client/src/protocol/dto_room_event.dart' as _i6rbd8g1;
import 'package:limick_client/src/protocol/dto_room_message_view.dart'
    as _ijflktyh;
import 'package:limick_client/src/protocol/dto_room_view.dart' as _i17464ln;
import 'package:limick_client/src/protocol/dto_view_signal.dart' as _ikggovgk;
import 'package:limick_client/src/protocol/reader.dart' as _i1rt7yr0;
import 'package:limick_client/src/protocol/reading_progress.dart' as _i7xi8k16;
import 'package:limick_client/src/protocol/saved_word.dart' as _imgi0cxh;
import 'package:limick_client/src/protocol/study_break.dart' as _iu9bznc7;
import 'package:limick_client/src/protocol/topic.dart' as _ileau18m;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _iaic;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'protocol.dart' as _il2as5qe;

/// By extending [EmailIdpBaseEndpoint], the email identity provider endpoints
/// are made available on the server and enable the corresponding sign-in widget
/// on the client.
/// {@category Endpoint}
class EndpointEmailIdp extends _iaic.EndpointEmailIdpBase {
  EndpointEmailIdp(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'emailIdp';

  /// Logs in the user and returns a new session.
  ///
  /// Throws an [EmailAccountLoginException] in case of errors, with reason:
  /// - [EmailAccountLoginExceptionReason.invalidCredentials] if the email or
  ///   password is incorrect.
  /// - [EmailAccountLoginExceptionReason.tooManyAttempts] if there have been
  ///   too many failed login attempts.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _ida.Future<_iacc.AuthSuccess> login({
    required String email,
    required String password,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
    'emailIdp',
    'login',
    {
      'email': email,
      'password': password,
    },
  );

  /// Starts the registration for a new user account with an email-based login
  /// associated to it.
  ///
  /// Upon successful completion of this method, an email will have been
  /// sent to [email] with a verification link, which the user must open to
  /// complete the registration.
  ///
  /// Always returns a account request ID, which can be used to complete the
  /// registration. If the email is already registered, the returned ID will not
  /// be valid.
  @override
  _ida.Future<_isc.UuidValue> startRegistration({required String email}) =>
      caller.callServerEndpoint<_isc.UuidValue>(
        'emailIdp',
        'startRegistration',
        {'email': email},
      );

  /// Verifies an account request code and returns a token
  /// that can be used to complete the account creation.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if no request exists
  ///   for the given [accountRequestId] or [verificationCode] is invalid.
  @override
  _ida.Future<String> verifyRegistrationCode({
    required _isc.UuidValue accountRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyRegistrationCode',
    {
      'accountRequestId': accountRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a new account registration, creating a new auth user with a
  /// profile and attaching the given email account to it.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if the [registrationToken]
  ///   is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  ///
  /// Returns a session for the newly created user.
  @override
  _ida.Future<_iacc.AuthSuccess> finishRegistration({
    required String registrationToken,
    required String password,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
    'emailIdp',
    'finishRegistration',
    {
      'registrationToken': registrationToken,
      'password': password,
    },
  );

  /// Requests a password reset for [email].
  ///
  /// If the email address is registered, an email with reset instructions will
  /// be send out. If the email is unknown, this method will have no effect.
  ///
  /// Always returns a password reset request ID, which can be used to complete
  /// the reset. If the email is not registered, the returned ID will not be
  /// valid.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to request a password reset.
  ///
  @override
  _ida.Future<_isc.UuidValue> startPasswordReset({required String email}) =>
      caller.callServerEndpoint<_isc.UuidValue>(
        'emailIdp',
        'startPasswordReset',
        {'email': email},
      );

  /// Verifies a password reset code and returns a finishPasswordResetToken
  /// that can be used to finish the password reset.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to verify the password reset.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// If multiple steps are required to complete the password reset, this endpoint
  /// should be overridden to return credentials for the next step instead
  /// of the credentials for setting the password.
  @override
  _ida.Future<String> verifyPasswordResetCode({
    required _isc.UuidValue passwordResetRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyPasswordResetCode',
    {
      'passwordResetRequestId': passwordResetRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a password reset request by setting a new password.
  ///
  /// The [verificationCode] returned from [verifyPasswordResetCode] is used to
  /// validate the password reset request.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.policyViolation] if the new
  ///   password does not comply with the password policy.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _ida.Future<void> finishPasswordReset({
    required String finishPasswordResetToken,
    required String newPassword,
  }) => caller.callServerEndpoint<void>(
    'emailIdp',
    'finishPasswordReset',
    {
      'finishPasswordResetToken': finishPasswordResetToken,
      'newPassword': newPassword,
    },
  );

  @override
  _ida.Future<bool> hasAccount() => caller.callServerEndpoint<bool>(
    'emailIdp',
    'hasAccount',
    {},
  );
}

/// By extending [RefreshJwtTokensEndpoint], the JWT token refresh endpoint
/// is made available on the server and enables automatic token refresh on the client.
/// {@category Endpoint}
class EndpointJwtRefresh extends _iacc.EndpointRefreshJwtTokens {
  EndpointJwtRefresh(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'jwtRefresh';

  /// Creates a new token pair for the given [refreshToken].
  ///
  /// If [refreshToken] is omitted, cookie-mode web clients fall back to the
  /// configured HttpOnly refresh cookie. When neither source is present this
  /// throws [RefreshTokenNotFoundException], the same public "no usable refresh
  /// credential" exception used for unknown refresh tokens.
  ///
  /// Can throw the following exceptions:
  /// -[RefreshTokenMalformedException]: refresh token is malformed and could
  ///   not be parsed. Not expected to happen for tokens issued by the server.
  /// -[RefreshTokenNotFoundException]: refresh token is unknown to the server.
  ///   Either the token was deleted or generated by a different server.
  /// -[RefreshTokenExpiredException]: refresh token has expired. Will happen
  ///   only if it has not been used within configured `refreshTokenLifetime`.
  /// -[RefreshTokenInvalidSecretException]: refresh token is incorrect, meaning
  ///   it does not refer to the current secret refresh token. This indicates
  ///   either a malfunctioning client or a malicious attempt by someone who has
  ///   obtained the refresh token. In this case the underlying refresh token
  ///   will be deleted, and access to it will expire fully when the last access
  ///   token is elapsed.
  ///
  /// This endpoint is unauthenticated, meaning the client won't include any
  /// authentication information with the call.
  @override
  _ida.Future<_iacc.AuthSuccess> refreshAccessToken({String? refreshToken}) =>
      caller.callServerEndpoint<_iacc.AuthSuccess>(
        'jwtRefresh',
        'refreshAccessToken',
        {'refreshToken': refreshToken},
        authenticated: false,
      );
}

/// The catalogue, book profiles and the reader.
/// {@category Endpoint}
class EndpointBook extends _isc.EndpointRef {
  EndpointBook(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'book';

  /// Searches ~60k public-domain books by title or author. With an empty
  /// query, returns the featured and most active books (optionally by topic).
  _ida.Future<List<_i5tn6nrb.Book>> search(
    String query,
    _ileau18m.Topic? topic,
    int offset,
  ) => caller.callServerEndpoint<List<_i5tn6nrb.Book>>(
    'book',
    'search',
    {
      'query': query,
      'topic': topic,
      'offset': offset,
    },
  );

  _ida.Future<List<_i50xy7df.ContinueReading>> continueReading() =>
      caller.callServerEndpoint<List<_i50xy7df.ContinueReading>>(
        'book',
        'continueReading',
        {},
      );

  _ida.Future<_if2meqjg.BookDetail> detail(int bookId) =>
      caller.callServerEndpoint<_if2meqjg.BookDetail>(
        'book',
        'detail',
        {'bookId': bookId},
      );

  _ida.Future<_if2meqjg.BookDetail> byHandle(String handle) =>
      caller.callServerEndpoint<_if2meqjg.BookDetail>(
        'book',
        'byHandle',
        {'handle': handle},
      );

  /// Follows a book. Following also queues the book for ingestion and raises
  /// its generation target, so its posts start arriving in the feed.
  _ida.Future<_i5tn6nrb.Book> setFollowing(
    int bookId,
    bool following,
  ) => caller.callServerEndpoint<_i5tn6nrb.Book>(
    'book',
    'setFollowing',
    {
      'bookId': bookId,
      'following': following,
    },
  );

  /// Asks for a book to be downloaded and prepared for reading.
  _ida.Future<_i5tn6nrb.Book> prepare(int bookId) =>
      caller.callServerEndpoint<_i5tn6nrb.Book>(
        'book',
        'prepare',
        {'bookId': bookId},
      );

  /// One chapter of a book. Chapters are cached in memory because readers
  /// page back and forth.
  _ida.Future<_i0wj6hma.ChapterContent> chapter(
    int bookId,
    int position,
  ) => caller.callServerEndpoint<_i0wj6hma.ChapterContent>(
    'book',
    'chapter',
    {
      'bookId': bookId,
      'position': position,
    },
  );

  _ida.Future<_i7xi8k16.ReadingProgress> saveProgress(
    int bookId,
    int chapterPosition,
    double scrollFraction,
  ) => caller.callServerEndpoint<_i7xi8k16.ReadingProgress>(
    'book',
    'saveProgress',
    {
      'bookId': bookId,
      'chapterPosition': chapterPosition,
      'scrollFraction': scrollFraction,
    },
  );
}

/// Comment threads under posts, with live updates.
/// {@category Endpoint}
class EndpointComment extends _isc.EndpointRef {
  EndpointComment(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'comment';

  /// All comments for a post: top level by popularity, replies in order.
  _ida.Future<List<_ileb9px8.CommentView>> list(int postId) =>
      caller.callServerEndpoint<List<_ileb9px8.CommentView>>(
        'comment',
        'list',
        {'postId': postId},
      );

  _ida.Future<_ileb9px8.CommentView> add(
    int postId,
    String body,
    int? parentId,
  ) => caller.callServerEndpoint<_ileb9px8.CommentView>(
    'comment',
    'add',
    {
      'postId': postId,
      'body': body,
      'parentId': parentId,
    },
  );

  _ida.Future<void> delete(int commentId) => caller.callServerEndpoint<void>(
    'comment',
    'delete',
    {'commentId': commentId},
  );

  _ida.Future<int> setLiked(
    int commentId,
    bool liked,
  ) => caller.callServerEndpoint<int>(
    'comment',
    'setLiked',
    {
      'commentId': commentId,
      'liked': liked,
    },
  );

  /// Live updates for an open thread. Comments from blocked users are
  /// filtered per viewer.
  _ida.Stream<_iuk66ey6.CommentEvent> watch(int postId) =>
      caller.callStreamingServerEndpoint<
        _ida.Stream<_iuk66ey6.CommentEvent>,
        _iuk66ey6.CommentEvent
      >(
        'comment',
        'watch',
        {'postId': postId},
        {},
      );
}

/// Feeds and every interaction with a post.
/// {@category Endpoint}
class EndpointFeed extends _isc.EndpointRef {
  EndpointFeed(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'feed';

  /// The personalised feed. [excludeIds] are posts already shown in this
  /// session, so paging never repeats a card.
  _ida.Future<_ioxiasn3.FeedPage> forYou(List<int> excludeIds) =>
      caller.callServerEndpoint<_ioxiasn3.FeedPage>(
        'feed',
        'forYou',
        {'excludeIds': excludeIds},
      );

  _ida.Future<_ioxiasn3.FeedPage> following(int? beforeId) =>
      caller.callServerEndpoint<_ioxiasn3.FeedPage>(
        'feed',
        'following',
        {'beforeId': beforeId},
      );

  _ida.Future<_i2a5226i.FeedItem> post(int postId) =>
      caller.callServerEndpoint<_i2a5226i.FeedItem>(
        'feed',
        'post',
        {'postId': postId},
      );

  /// A book's own timeline, in reading order.
  _ida.Future<_ioxiasn3.FeedPage> bookPosts(
    int bookId,
    int? afterId,
  ) => caller.callServerEndpoint<_ioxiasn3.FeedPage>(
    'feed',
    'bookPosts',
    {
      'bookId': bookId,
      'afterId': afterId,
    },
  );

  _ida.Future<_ioxiasn3.FeedPage> saved(int? beforeSaveId) =>
      caller.callServerEndpoint<_ioxiasn3.FeedPage>(
        'feed',
        'saved',
        {'beforeSaveId': beforeSaveId},
      );

  /// Dwell times from the client. These teach the ranking what the user
  /// actually reads, and mark posts as seen.
  _ida.Future<void> recordViews(List<_ikggovgk.ViewSignal> views) =>
      caller.callServerEndpoint<void>(
        'feed',
        'recordViews',
        {'views': views},
      );

  _ida.Future<int> setLiked(
    int postId,
    bool liked,
  ) => caller.callServerEndpoint<int>(
    'feed',
    'setLiked',
    {
      'postId': postId,
      'liked': liked,
    },
  );

  _ida.Future<bool> setSaved(
    int postId,
    bool saved,
  ) => caller.callServerEndpoint<bool>(
    'feed',
    'setSaved',
    {
      'postId': postId,
      'saved': saved,
    },
  );

  _ida.Future<_ip6mgp95.QuizResult> answerQuiz(
    int postId,
    int choiceIndex,
  ) => caller.callServerEndpoint<_ip6mgp95.QuizResult>(
    'feed',
    'answerQuiz',
    {
      'postId': postId,
      'choiceIndex': choiceIndex,
    },
  );

  /// Records an agree/disagree vote and returns the post with fresh counts
  /// and both sides of the argument.
  _ida.Future<_i2a5226i.FeedItem> vote(
    int postId,
    bool agree,
  ) => caller.callServerEndpoint<_i2a5226i.FeedItem>(
    'feed',
    'vote',
    {
      'postId': postId,
      'agree': agree,
    },
  );

  /// The strongest interest signal: the user went from a post to the book.
  _ida.Future<void> openedBook(int postId) => caller.callServerEndpoint<void>(
    'feed',
    'openedBook',
    {'postId': postId},
  );
}

/// Public, live numbers about the library pipeline.
/// {@category Endpoint}
class EndpointLibrary extends _isc.EndpointRef {
  EndpointLibrary(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'library';

  _ida.Future<_i2s76435.LibraryStatus> status() =>
      caller.callServerEndpoint<_i2s76435.LibraryStatus>(
        'library',
        'status',
        {},
      );
}

/// Reporting content and blocking people.
/// {@category Endpoint}
class EndpointModeration extends _isc.EndpointRef {
  EndpointModeration(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'moderation';

  _ida.Future<void> report(
    String targetType,
    int targetId,
    String reason,
  ) => caller.callServerEndpoint<void>(
    'moderation',
    'report',
    {
      'targetType': targetType,
      'targetId': targetId,
      'reason': reason,
    },
  );

  _ida.Future<void> setBlocked(
    int profileId,
    bool blocked,
  ) => caller.callServerEndpoint<void>(
    'moderation',
    'setBlocked',
    {
      'profileId': profileId,
      'blocked': blocked,
    },
  );

  _ida.Future<List<_igl91g7y.Author>> blocked() =>
      caller.callServerEndpoint<List<_igl91g7y.Author>>(
        'moderation',
        'blocked',
        {},
      );
}

/// Onboarding, profiles, streaks, stats, data export and account deletion.
/// {@category Endpoint}
class EndpointProfile extends _isc.EndpointRef {
  EndpointProfile(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'profile';

  /// Called on every launch. Also keeps the daily streak up to date.
  _ida.Future<_ia3wfgcv.Me> me(int tzOffsetMinutes) =>
      caller.callServerEndpoint<_ia3wfgcv.Me>(
        'profile',
        'me',
        {'tzOffsetMinutes': tzOffsetMinutes},
      );

  _ida.Future<bool> isHandleAvailable(String handle) =>
      caller.callServerEndpoint<bool>(
        'profile',
        'isHandleAvailable',
        {'handle': handle},
      );

  /// Creates the profile and seeds the recommendation engine from the user's
  /// field, interests and favourite books.
  _ida.Future<_ia3wfgcv.Me> completeOnboarding(
    _itf5sm15.OnboardingInput input,
  ) => caller.callServerEndpoint<_ia3wfgcv.Me>(
    'profile',
    'completeOnboarding',
    {'input': input},
  );

  _ida.Future<_i1rt7yr0.Reader> updateProfile({
    required String displayName,
    required String bio,
    String? field,
    int? avatarHue,
    int? dailyGoalMinutes,
  }) => caller.callServerEndpoint<_i1rt7yr0.Reader>(
    'profile',
    'updateProfile',
    {
      'displayName': displayName,
      'bio': bio,
      'field': field,
      'avatarHue': avatarHue,
      'dailyGoalMinutes': dailyGoalMinutes,
    },
  );

  _ida.Future<_iruz11o4.PublicProfile> getProfile(String handle) =>
      caller.callServerEndpoint<_iruz11o4.PublicProfile>(
        'profile',
        'getProfile',
        {'handle': handle},
      );

  _ida.Future<_ilqwmwet.ProfileStats> stats() =>
      caller.callServerEndpoint<_ilqwmwet.ProfileStats>(
        'profile',
        'stats',
        {},
      );

  /// Everything Limick stores about the user, as JSON (GDPR data portability).
  _ida.Future<String> exportData() => caller.callServerEndpoint<String>(
    'profile',
    'exportData',
    {},
  );

  /// Permanently deletes the user's Limick data and their sign-in account.
  _ida.Future<void> deleteAccount() => caller.callServerEndpoint<void>(
    'profile',
    'deleteAccount',
    {},
  );
}

/// Public rooms: one per topic, plus a book club per book. Real time via
/// Serverpod streams.
/// {@category Endpoint}
class EndpointRoom extends _isc.EndpointRef {
  EndpointRoom(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'room';

  _ida.Future<List<_i17464ln.RoomView>> list() =>
      caller.callServerEndpoint<List<_i17464ln.RoomView>>(
        'room',
        'list',
        {},
      );

  _ida.Future<_i17464ln.RoomView> get(int roomId) =>
      caller.callServerEndpoint<_i17464ln.RoomView>(
        'room',
        'get',
        {'roomId': roomId},
      );

  /// The book club for a book, created the first time someone opens it.
  _ida.Future<_i17464ln.RoomView> forBook(int bookId) =>
      caller.callServerEndpoint<_i17464ln.RoomView>(
        'room',
        'forBook',
        {'bookId': bookId},
      );

  _ida.Future<_i17464ln.RoomView> setJoined(
    int roomId,
    bool joined,
  ) => caller.callServerEndpoint<_i17464ln.RoomView>(
    'room',
    'setJoined',
    {
      'roomId': roomId,
      'joined': joined,
    },
  );

  /// Messages, newest first. Opening the latest page marks the room read.
  _ida.Future<List<_ijflktyh.RoomMessageView>> messages(
    int roomId,
    int? beforeId,
  ) => caller.callServerEndpoint<List<_ijflktyh.RoomMessageView>>(
    'room',
    'messages',
    {
      'roomId': roomId,
      'beforeId': beforeId,
    },
  );

  _ida.Future<_ijflktyh.RoomMessageView> send(
    int roomId,
    String body,
  ) => caller.callServerEndpoint<_ijflktyh.RoomMessageView>(
    'room',
    'send',
    {
      'roomId': roomId,
      'body': body,
    },
  );

  _ida.Future<void> delete(int messageId) => caller.callServerEndpoint<void>(
    'room',
    'delete',
    {'messageId': messageId},
  );

  _ida.Future<void> markRead(int roomId) => caller.callServerEndpoint<void>(
    'room',
    'markRead',
    {'roomId': roomId},
  );

  /// Live room events. Counts this connection as "online" while it is open.
  _ida.Stream<_i6rbd8g1.RoomEvent> live(int roomId) =>
      caller.callStreamingServerEndpoint<
        _ida.Stream<_i6rbd8g1.RoomEvent>,
        _i6rbd8g1.RoomEvent
      >(
        'room',
        'live',
        {'roomId': roomId},
        {},
      );
}

/// Timed study breaks. The break lives on the server so it survives app
/// restarts and works across devices; the summary shows what was learned.
/// {@category Endpoint}
class EndpointStudyBreak extends _isc.EndpointRef {
  EndpointStudyBreak(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'studyBreak';

  _ida.Future<_iu9bznc7.StudyBreak> start(int minutes) =>
      caller.callServerEndpoint<_iu9bznc7.StudyBreak>(
        'studyBreak',
        'start',
        {'minutes': minutes},
      );

  _ida.Future<_iu9bznc7.StudyBreak?> active() =>
      caller.callServerEndpoint<_iu9bznc7.StudyBreak?>(
        'studyBreak',
        'active',
        {},
      );

  /// Ends the break (if it is still running) and summarises it.
  _ida.Future<_ipohq6op.BreakSummary> end(int breakId) =>
      caller.callServerEndpoint<_ipohq6op.BreakSummary>(
        'studyBreak',
        'end',
        {'breakId': breakId},
      );
}

/// The word bank: words saved from posts, reviewed with a Leitner schedule.
/// {@category Endpoint}
class EndpointWord extends _isc.EndpointRef {
  EndpointWord(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'word';

  _ida.Future<_imgi0cxh.SavedWord> saveFromPost(int postId) =>
      caller.callServerEndpoint<_imgi0cxh.SavedWord>(
        'word',
        'saveFromPost',
        {'postId': postId},
      );

  _ida.Future<List<_imgi0cxh.SavedWord>> list() =>
      caller.callServerEndpoint<List<_imgi0cxh.SavedWord>>(
        'word',
        'list',
        {},
      );

  _ida.Future<List<_imgi0cxh.SavedWord>> due() =>
      caller.callServerEndpoint<List<_imgi0cxh.SavedWord>>(
        'word',
        'due',
        {},
      );

  /// Remembered words move up a box and come back later; forgotten words go
  /// back to box 0 and return in a few hours.
  _ida.Future<_imgi0cxh.SavedWord> review(
    int wordId,
    bool remembered,
  ) => caller.callServerEndpoint<_imgi0cxh.SavedWord>(
    'word',
    'review',
    {
      'wordId': wordId,
      'remembered': remembered,
    },
  );

  _ida.Future<void> remove(int wordId) => caller.callServerEndpoint<void>(
    'word',
    'remove',
    {'wordId': wordId},
  );
}

class Modules {
  Modules(Client client) {
    serverpod_auth_idp = _iaic.Caller(client);
    serverpod_auth_core = _iacc.Caller(client);
  }

  late final _iaic.Caller serverpod_auth_idp;

  late final _iacc.Caller serverpod_auth_core;
}

class Client extends _isc.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _isc.MethodCallContext,
      Object,
      StackTrace,
    )?
    onFailedCall,
    Function(_isc.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
    _i85jenna.Client? httpClientOverride,
  }) : super(
         host,
         _il2as5qe.Protocol(),
         securityContext: securityContext,
         streamingConnectionTimeout: streamingConnectionTimeout,
         connectionTimeout: connectionTimeout,
         onFailedCall: onFailedCall,
         onSucceededCall: onSucceededCall,
         disconnectStreamsOnLostInternetConnection:
             disconnectStreamsOnLostInternetConnection,
         httpClientOverride: httpClientOverride,
       ) {
    emailIdp = EndpointEmailIdp(this);
    jwtRefresh = EndpointJwtRefresh(this);
    book = EndpointBook(this);
    comment = EndpointComment(this);
    feed = EndpointFeed(this);
    library = EndpointLibrary(this);
    moderation = EndpointModeration(this);
    profile = EndpointProfile(this);
    room = EndpointRoom(this);
    studyBreak = EndpointStudyBreak(this);
    word = EndpointWord(this);
    modules = Modules(this);
  }

  late final EndpointEmailIdp emailIdp;

  late final EndpointJwtRefresh jwtRefresh;

  late final EndpointBook book;

  late final EndpointComment comment;

  late final EndpointFeed feed;

  late final EndpointLibrary library;

  late final EndpointModeration moderation;

  late final EndpointProfile profile;

  late final EndpointRoom room;

  late final EndpointStudyBreak studyBreak;

  late final EndpointWord word;

  late final Modules modules;

  @override
  Map<String, _isc.EndpointRef> get endpointRefLookup => {
    'emailIdp': emailIdp,
    'jwtRefresh': jwtRefresh,
    'book': book,
    'comment': comment,
    'feed': feed,
    'library': library,
    'moderation': moderation,
    'profile': profile,
    'room': room,
    'studyBreak': studyBreak,
    'word': word,
  };

  @override
  Map<String, _isc.ModuleEndpointCaller> get moduleLookup => {
    'serverpod_auth_idp': modules.serverpod_auth_idp,
    'serverpod_auth_core': modules.serverpod_auth_core,
  };
}
