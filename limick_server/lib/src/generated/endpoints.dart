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
import 'package:limick_server/src/generated/dto_onboarding.dart' as _igeonouv;
import 'package:limick_server/src/generated/dto_view_signal.dart' as _ik2oo8gm;
import 'package:limick_server/src/generated/future_calls.dart' as _impq36kq;
import 'package:limick_server/src/generated/topic.dart' as _icd6enen;
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _iais;
import '../auth/email_idp_endpoint.dart' as _iuc1hd5t;
import '../auth/jwt_refresh_endpoint.dart' as _inwq3ztq;
import '../endpoints/book_endpoint.dart' as _io0dh9pt;
import '../endpoints/comment_endpoint.dart' as _i2tyagcg;
import '../endpoints/feed_endpoint.dart' as _i8rwrucy;
import '../endpoints/library_endpoint.dart' as _iqlmnpik;
import '../endpoints/moderation_endpoint.dart' as _inrg2i73;
import '../endpoints/notification_endpoint.dart' as _ihb11yhk;
import '../endpoints/profile_endpoint.dart' as _i2cx2pww;
import '../endpoints/room_endpoint.dart' as _io7erjyw;
import '../endpoints/study_break_endpoint.dart' as _izclnwua;
import '../endpoints/word_endpoint.dart' as _izbf9x2s;
export 'future_calls.dart' show ServerpodFutureCallsGetter;

class Endpoints extends _is.EndpointDispatch {
  @override
  void initializeEndpoints(_is.Server server) {
    var endpoints = <String, _is.Endpoint>{
      'emailIdp': _iuc1hd5t.EmailIdpEndpoint()
        ..initialize(
          server,
          'emailIdp',
          null,
        ),
      'jwtRefresh': _inwq3ztq.JwtRefreshEndpoint()
        ..initialize(
          server,
          'jwtRefresh',
          null,
        ),
      'book': _io0dh9pt.BookEndpoint()
        ..initialize(
          server,
          'book',
          null,
        ),
      'comment': _i2tyagcg.CommentEndpoint()
        ..initialize(
          server,
          'comment',
          null,
        ),
      'feed': _i8rwrucy.FeedEndpoint()
        ..initialize(
          server,
          'feed',
          null,
        ),
      'library': _iqlmnpik.LibraryEndpoint()
        ..initialize(
          server,
          'library',
          null,
        ),
      'moderation': _inrg2i73.ModerationEndpoint()
        ..initialize(
          server,
          'moderation',
          null,
        ),
      'notification': _ihb11yhk.NotificationEndpoint()
        ..initialize(
          server,
          'notification',
          null,
        ),
      'profile': _i2cx2pww.ProfileEndpoint()
        ..initialize(
          server,
          'profile',
          null,
        ),
      'room': _io7erjyw.RoomEndpoint()
        ..initialize(
          server,
          'room',
          null,
        ),
      'studyBreak': _izclnwua.StudyBreakEndpoint()
        ..initialize(
          server,
          'studyBreak',
          null,
        ),
      'word': _izbf9x2s.WordEndpoint()
        ..initialize(
          server,
          'word',
          null,
        ),
    };
    connectors['emailIdp'] = _is.EndpointConnector(
      name: 'emailIdp',
      endpoint: endpoints['emailIdp']!,
      methodConnectors: {
        'login': _is.MethodConnector(
          name: 'login',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'password': _is.ParameterDescription(
              name: 'password',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint).login(
                    session,
                    email: params['email'],
                    password: params['password'],
                  ),
        ),
        'startRegistration': _is.MethodConnector(
          name: 'startRegistration',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .startRegistration(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyRegistrationCode': _is.MethodConnector(
          name: 'verifyRegistrationCode',
          params: {
            'accountRequestId': _is.ParameterDescription(
              name: 'accountRequestId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _is.ParameterDescription(
              name: 'verificationCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .verifyRegistrationCode(
                    session,
                    accountRequestId: params['accountRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishRegistration': _is.MethodConnector(
          name: 'finishRegistration',
          params: {
            'registrationToken': _is.ParameterDescription(
              name: 'registrationToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'password': _is.ParameterDescription(
              name: 'password',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .finishRegistration(
                    session,
                    registrationToken: params['registrationToken'],
                    password: params['password'],
                  ),
        ),
        'startPasswordReset': _is.MethodConnector(
          name: 'startPasswordReset',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .startPasswordReset(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyPasswordResetCode': _is.MethodConnector(
          name: 'verifyPasswordResetCode',
          params: {
            'passwordResetRequestId': _is.ParameterDescription(
              name: 'passwordResetRequestId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _is.ParameterDescription(
              name: 'verificationCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .verifyPasswordResetCode(
                    session,
                    passwordResetRequestId: params['passwordResetRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishPasswordReset': _is.MethodConnector(
          name: 'finishPasswordReset',
          params: {
            'finishPasswordResetToken': _is.ParameterDescription(
              name: 'finishPasswordResetToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'newPassword': _is.ParameterDescription(
              name: 'newPassword',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .finishPasswordReset(
                    session,
                    finishPasswordResetToken:
                        params['finishPasswordResetToken'],
                    newPassword: params['newPassword'],
                  ),
        ),
        'hasAccount': _is.MethodConnector(
          name: 'hasAccount',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .hasAccount(session),
        ),
      },
    );
    connectors['jwtRefresh'] = _is.EndpointConnector(
      name: 'jwtRefresh',
      endpoint: endpoints['jwtRefresh']!,
      methodConnectors: {
        'refreshAccessToken': _is.MethodConnector(
          name: 'refreshAccessToken',
          params: {
            'refreshToken': _is.ParameterDescription(
              name: 'refreshToken',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['jwtRefresh'] as _inwq3ztq.JwtRefreshEndpoint)
                      .refreshAccessToken(
                        session,
                        refreshToken: params['refreshToken'],
                      ),
        ),
      },
    );
    connectors['book'] = _is.EndpointConnector(
      name: 'book',
      endpoint: endpoints['book']!,
      methodConnectors: {
        'search': _is.MethodConnector(
          name: 'search',
          params: {
            'query': _is.ParameterDescription(
              name: 'query',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'topic': _is.ParameterDescription(
              name: 'topic',
              type: _is.getType<_icd6enen.Topic?>(),
              nullable: true,
            ),
            'offset': _is.ParameterDescription(
              name: 'offset',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['book'] as _io0dh9pt.BookEndpoint).search(
                session,
                params['query'],
                params['topic'],
                params['offset'],
              ),
        ),
        'continueReading': _is.MethodConnector(
          name: 'continueReading',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['book'] as _io0dh9pt.BookEndpoint)
                  .continueReading(session),
        ),
        'detail': _is.MethodConnector(
          name: 'detail',
          params: {
            'bookId': _is.ParameterDescription(
              name: 'bookId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['book'] as _io0dh9pt.BookEndpoint).detail(
                session,
                params['bookId'],
              ),
        ),
        'byHandle': _is.MethodConnector(
          name: 'byHandle',
          params: {
            'handle': _is.ParameterDescription(
              name: 'handle',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['book'] as _io0dh9pt.BookEndpoint).byHandle(
                session,
                params['handle'],
              ),
        ),
        'setFollowing': _is.MethodConnector(
          name: 'setFollowing',
          params: {
            'bookId': _is.ParameterDescription(
              name: 'bookId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'following': _is.ParameterDescription(
              name: 'following',
              type: _is.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['book'] as _io0dh9pt.BookEndpoint).setFollowing(
                    session,
                    params['bookId'],
                    params['following'],
                  ),
        ),
        'prepare': _is.MethodConnector(
          name: 'prepare',
          params: {
            'bookId': _is.ParameterDescription(
              name: 'bookId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['book'] as _io0dh9pt.BookEndpoint).prepare(
                session,
                params['bookId'],
              ),
        ),
        'chapter': _is.MethodConnector(
          name: 'chapter',
          params: {
            'bookId': _is.ParameterDescription(
              name: 'bookId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'position': _is.ParameterDescription(
              name: 'position',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['book'] as _io0dh9pt.BookEndpoint).chapter(
                session,
                params['bookId'],
                params['position'],
              ),
        ),
        'saveProgress': _is.MethodConnector(
          name: 'saveProgress',
          params: {
            'bookId': _is.ParameterDescription(
              name: 'bookId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'chapterPosition': _is.ParameterDescription(
              name: 'chapterPosition',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'scrollFraction': _is.ParameterDescription(
              name: 'scrollFraction',
              type: _is.getType<double>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['book'] as _io0dh9pt.BookEndpoint).saveProgress(
                    session,
                    params['bookId'],
                    params['chapterPosition'],
                    params['scrollFraction'],
                  ),
        ),
      },
    );
    connectors['comment'] = _is.EndpointConnector(
      name: 'comment',
      endpoint: endpoints['comment']!,
      methodConnectors: {
        'list': _is.MethodConnector(
          name: 'list',
          params: {
            'postId': _is.ParameterDescription(
              name: 'postId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['comment'] as _i2tyagcg.CommentEndpoint).list(
                    session,
                    params['postId'],
                  ),
        ),
        'add': _is.MethodConnector(
          name: 'add',
          params: {
            'postId': _is.ParameterDescription(
              name: 'postId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'body': _is.ParameterDescription(
              name: 'body',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'parentId': _is.ParameterDescription(
              name: 'parentId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['comment'] as _i2tyagcg.CommentEndpoint).add(
                    session,
                    params['postId'],
                    params['body'],
                    params['parentId'],
                  ),
        ),
        'delete': _is.MethodConnector(
          name: 'delete',
          params: {
            'commentId': _is.ParameterDescription(
              name: 'commentId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['comment'] as _i2tyagcg.CommentEndpoint).delete(
                    session,
                    params['commentId'],
                  ),
        ),
        'setLiked': _is.MethodConnector(
          name: 'setLiked',
          params: {
            'commentId': _is.ParameterDescription(
              name: 'commentId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'liked': _is.ParameterDescription(
              name: 'liked',
              type: _is.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['comment'] as _i2tyagcg.CommentEndpoint).setLiked(
                    session,
                    params['commentId'],
                    params['liked'],
                  ),
        ),
        'watch': _is.MethodStreamConnector(
          name: 'watch',
          params: {
            'postId': _is.ParameterDescription(
              name: 'postId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          streamParams: {},
          returnType: _is.MethodStreamReturnType.streamType,
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
                Map<String, Stream> streamParams,
              ) => (endpoints['comment'] as _i2tyagcg.CommentEndpoint).watch(
                session,
                params['postId'],
              ),
        ),
      },
    );
    connectors['feed'] = _is.EndpointConnector(
      name: 'feed',
      endpoint: endpoints['feed']!,
      methodConnectors: {
        'forYou': _is.MethodConnector(
          name: 'forYou',
          params: {
            'excludeIds': _is.ParameterDescription(
              name: 'excludeIds',
              type: _is.getType<List<int>>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['feed'] as _i8rwrucy.FeedEndpoint).forYou(
                session,
                params['excludeIds'],
              ),
        ),
        'following': _is.MethodConnector(
          name: 'following',
          params: {
            'beforeId': _is.ParameterDescription(
              name: 'beforeId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['feed'] as _i8rwrucy.FeedEndpoint).following(
                    session,
                    params['beforeId'],
                  ),
        ),
        'post': _is.MethodConnector(
          name: 'post',
          params: {
            'postId': _is.ParameterDescription(
              name: 'postId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['feed'] as _i8rwrucy.FeedEndpoint).post(
                session,
                params['postId'],
              ),
        ),
        'bookPosts': _is.MethodConnector(
          name: 'bookPosts',
          params: {
            'bookId': _is.ParameterDescription(
              name: 'bookId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'afterId': _is.ParameterDescription(
              name: 'afterId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['feed'] as _i8rwrucy.FeedEndpoint).bookPosts(
                    session,
                    params['bookId'],
                    params['afterId'],
                  ),
        ),
        'saved': _is.MethodConnector(
          name: 'saved',
          params: {
            'beforeSaveId': _is.ParameterDescription(
              name: 'beforeSaveId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['feed'] as _i8rwrucy.FeedEndpoint).saved(
                session,
                params['beforeSaveId'],
              ),
        ),
        'recordViews': _is.MethodConnector(
          name: 'recordViews',
          params: {
            'views': _is.ParameterDescription(
              name: 'views',
              type: _is.getType<List<_ik2oo8gm.ViewSignal>>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['feed'] as _i8rwrucy.FeedEndpoint).recordViews(
                    session,
                    params['views'],
                  ),
        ),
        'setLiked': _is.MethodConnector(
          name: 'setLiked',
          params: {
            'postId': _is.ParameterDescription(
              name: 'postId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'liked': _is.ParameterDescription(
              name: 'liked',
              type: _is.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['feed'] as _i8rwrucy.FeedEndpoint).setLiked(
                session,
                params['postId'],
                params['liked'],
              ),
        ),
        'setSaved': _is.MethodConnector(
          name: 'setSaved',
          params: {
            'postId': _is.ParameterDescription(
              name: 'postId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'saved': _is.ParameterDescription(
              name: 'saved',
              type: _is.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['feed'] as _i8rwrucy.FeedEndpoint).setSaved(
                session,
                params['postId'],
                params['saved'],
              ),
        ),
        'answerQuiz': _is.MethodConnector(
          name: 'answerQuiz',
          params: {
            'postId': _is.ParameterDescription(
              name: 'postId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'choiceIndex': _is.ParameterDescription(
              name: 'choiceIndex',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['feed'] as _i8rwrucy.FeedEndpoint).answerQuiz(
                    session,
                    params['postId'],
                    params['choiceIndex'],
                  ),
        ),
        'vote': _is.MethodConnector(
          name: 'vote',
          params: {
            'postId': _is.ParameterDescription(
              name: 'postId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'agree': _is.ParameterDescription(
              name: 'agree',
              type: _is.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['feed'] as _i8rwrucy.FeedEndpoint).vote(
                session,
                params['postId'],
                params['agree'],
              ),
        ),
        'openedBook': _is.MethodConnector(
          name: 'openedBook',
          params: {
            'postId': _is.ParameterDescription(
              name: 'postId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['feed'] as _i8rwrucy.FeedEndpoint).openedBook(
                    session,
                    params['postId'],
                  ),
        ),
      },
    );
    connectors['library'] = _is.EndpointConnector(
      name: 'library',
      endpoint: endpoints['library']!,
      methodConnectors: {
        'status': _is.MethodConnector(
          name: 'status',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['library'] as _iqlmnpik.LibraryEndpoint)
                  .status(session),
        ),
      },
    );
    connectors['moderation'] = _is.EndpointConnector(
      name: 'moderation',
      endpoint: endpoints['moderation']!,
      methodConnectors: {
        'report': _is.MethodConnector(
          name: 'report',
          params: {
            'targetType': _is.ParameterDescription(
              name: 'targetType',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'targetId': _is.ParameterDescription(
              name: 'targetId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'reason': _is.ParameterDescription(
              name: 'reason',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['moderation'] as _inrg2i73.ModerationEndpoint)
                      .report(
                        session,
                        params['targetType'],
                        params['targetId'],
                        params['reason'],
                      ),
        ),
        'setBlocked': _is.MethodConnector(
          name: 'setBlocked',
          params: {
            'profileId': _is.ParameterDescription(
              name: 'profileId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'blocked': _is.ParameterDescription(
              name: 'blocked',
              type: _is.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['moderation'] as _inrg2i73.ModerationEndpoint)
                      .setBlocked(
                        session,
                        params['profileId'],
                        params['blocked'],
                      ),
        ),
        'blocked': _is.MethodConnector(
          name: 'blocked',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['moderation'] as _inrg2i73.ModerationEndpoint)
                      .blocked(session),
        ),
      },
    );
    connectors['notification'] = _is.EndpointConnector(
      name: 'notification',
      endpoint: endpoints['notification']!,
      methodConnectors: {
        'list': _is.MethodConnector(
          name: 'list',
          params: {
            'beforeId': _is.ParameterDescription(
              name: 'beforeId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['notification'] as _ihb11yhk.NotificationEndpoint)
                      .list(
                        session,
                        params['beforeId'],
                      ),
        ),
        'unreadCount': _is.MethodConnector(
          name: 'unreadCount',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['notification'] as _ihb11yhk.NotificationEndpoint)
                      .unreadCount(session),
        ),
        'markAllRead': _is.MethodConnector(
          name: 'markAllRead',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['notification'] as _ihb11yhk.NotificationEndpoint)
                      .markAllRead(session),
        ),
      },
    );
    connectors['profile'] = _is.EndpointConnector(
      name: 'profile',
      endpoint: endpoints['profile']!,
      methodConnectors: {
        'me': _is.MethodConnector(
          name: 'me',
          params: {
            'tzOffsetMinutes': _is.ParameterDescription(
              name: 'tzOffsetMinutes',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['profile'] as _i2cx2pww.ProfileEndpoint).me(
                session,
                params['tzOffsetMinutes'],
              ),
        ),
        'isHandleAvailable': _is.MethodConnector(
          name: 'isHandleAvailable',
          params: {
            'handle': _is.ParameterDescription(
              name: 'handle',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['profile'] as _i2cx2pww.ProfileEndpoint)
                  .isHandleAvailable(
                    session,
                    params['handle'],
                  ),
        ),
        'completeOnboarding': _is.MethodConnector(
          name: 'completeOnboarding',
          params: {
            'input': _is.ParameterDescription(
              name: 'input',
              type: _is.getType<_igeonouv.OnboardingInput>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['profile'] as _i2cx2pww.ProfileEndpoint)
                  .completeOnboarding(
                    session,
                    params['input'],
                  ),
        ),
        'updateProfile': _is.MethodConnector(
          name: 'updateProfile',
          params: {
            'displayName': _is.ParameterDescription(
              name: 'displayName',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'bio': _is.ParameterDescription(
              name: 'bio',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'field': _is.ParameterDescription(
              name: 'field',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'avatarHue': _is.ParameterDescription(
              name: 'avatarHue',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'dailyGoalMinutes': _is.ParameterDescription(
              name: 'dailyGoalMinutes',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['profile'] as _i2cx2pww.ProfileEndpoint)
                  .updateProfile(
                    session,
                    displayName: params['displayName'],
                    bio: params['bio'],
                    field: params['field'],
                    avatarHue: params['avatarHue'],
                    dailyGoalMinutes: params['dailyGoalMinutes'],
                  ),
        ),
        'getProfile': _is.MethodConnector(
          name: 'getProfile',
          params: {
            'handle': _is.ParameterDescription(
              name: 'handle',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['profile'] as _i2cx2pww.ProfileEndpoint)
                  .getProfile(
                    session,
                    params['handle'],
                  ),
        ),
        'stats': _is.MethodConnector(
          name: 'stats',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['profile'] as _i2cx2pww.ProfileEndpoint)
                  .stats(session),
        ),
        'exportData': _is.MethodConnector(
          name: 'exportData',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['profile'] as _i2cx2pww.ProfileEndpoint)
                  .exportData(session),
        ),
        'deleteAccount': _is.MethodConnector(
          name: 'deleteAccount',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['profile'] as _i2cx2pww.ProfileEndpoint)
                  .deleteAccount(session),
        ),
      },
    );
    connectors['room'] = _is.EndpointConnector(
      name: 'room',
      endpoint: endpoints['room']!,
      methodConnectors: {
        'list': _is.MethodConnector(
          name: 'list',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['room'] as _io7erjyw.RoomEndpoint).list(session),
        ),
        'get': _is.MethodConnector(
          name: 'get',
          params: {
            'roomId': _is.ParameterDescription(
              name: 'roomId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['room'] as _io7erjyw.RoomEndpoint).get(
                session,
                params['roomId'],
              ),
        ),
        'forBook': _is.MethodConnector(
          name: 'forBook',
          params: {
            'bookId': _is.ParameterDescription(
              name: 'bookId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['room'] as _io7erjyw.RoomEndpoint).forBook(
                session,
                params['bookId'],
              ),
        ),
        'setJoined': _is.MethodConnector(
          name: 'setJoined',
          params: {
            'roomId': _is.ParameterDescription(
              name: 'roomId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'joined': _is.ParameterDescription(
              name: 'joined',
              type: _is.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['room'] as _io7erjyw.RoomEndpoint).setJoined(
                    session,
                    params['roomId'],
                    params['joined'],
                  ),
        ),
        'messages': _is.MethodConnector(
          name: 'messages',
          params: {
            'roomId': _is.ParameterDescription(
              name: 'roomId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'beforeId': _is.ParameterDescription(
              name: 'beforeId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['room'] as _io7erjyw.RoomEndpoint).messages(
                session,
                params['roomId'],
                params['beforeId'],
              ),
        ),
        'send': _is.MethodConnector(
          name: 'send',
          params: {
            'roomId': _is.ParameterDescription(
              name: 'roomId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'body': _is.ParameterDescription(
              name: 'body',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['room'] as _io7erjyw.RoomEndpoint).send(
                session,
                params['roomId'],
                params['body'],
              ),
        ),
        'delete': _is.MethodConnector(
          name: 'delete',
          params: {
            'messageId': _is.ParameterDescription(
              name: 'messageId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['room'] as _io7erjyw.RoomEndpoint).delete(
                session,
                params['messageId'],
              ),
        ),
        'markRead': _is.MethodConnector(
          name: 'markRead',
          params: {
            'roomId': _is.ParameterDescription(
              name: 'roomId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['room'] as _io7erjyw.RoomEndpoint).markRead(
                session,
                params['roomId'],
              ),
        ),
        'live': _is.MethodStreamConnector(
          name: 'live',
          params: {
            'roomId': _is.ParameterDescription(
              name: 'roomId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          streamParams: {},
          returnType: _is.MethodStreamReturnType.streamType,
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
                Map<String, Stream> streamParams,
              ) => (endpoints['room'] as _io7erjyw.RoomEndpoint).live(
                session,
                params['roomId'],
              ),
        ),
      },
    );
    connectors['studyBreak'] = _is.EndpointConnector(
      name: 'studyBreak',
      endpoint: endpoints['studyBreak']!,
      methodConnectors: {
        'start': _is.MethodConnector(
          name: 'start',
          params: {
            'minutes': _is.ParameterDescription(
              name: 'minutes',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['studyBreak'] as _izclnwua.StudyBreakEndpoint)
                      .start(
                        session,
                        params['minutes'],
                      ),
        ),
        'active': _is.MethodConnector(
          name: 'active',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['studyBreak'] as _izclnwua.StudyBreakEndpoint)
                      .active(session),
        ),
        'end': _is.MethodConnector(
          name: 'end',
          params: {
            'breakId': _is.ParameterDescription(
              name: 'breakId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['studyBreak'] as _izclnwua.StudyBreakEndpoint).end(
                    session,
                    params['breakId'],
                  ),
        ),
      },
    );
    connectors['word'] = _is.EndpointConnector(
      name: 'word',
      endpoint: endpoints['word']!,
      methodConnectors: {
        'saveFromPost': _is.MethodConnector(
          name: 'saveFromPost',
          params: {
            'postId': _is.ParameterDescription(
              name: 'postId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['word'] as _izbf9x2s.WordEndpoint).saveFromPost(
                    session,
                    params['postId'],
                  ),
        ),
        'list': _is.MethodConnector(
          name: 'list',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['word'] as _izbf9x2s.WordEndpoint).list(session),
        ),
        'due': _is.MethodConnector(
          name: 'due',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['word'] as _izbf9x2s.WordEndpoint).due(session),
        ),
        'review': _is.MethodConnector(
          name: 'review',
          params: {
            'wordId': _is.ParameterDescription(
              name: 'wordId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'remembered': _is.ParameterDescription(
              name: 'remembered',
              type: _is.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['word'] as _izbf9x2s.WordEndpoint).review(
                session,
                params['wordId'],
                params['remembered'],
              ),
        ),
        'remove': _is.MethodConnector(
          name: 'remove',
          params: {
            'wordId': _is.ParameterDescription(
              name: 'wordId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['word'] as _izbf9x2s.WordEndpoint).remove(
                session,
                params['wordId'],
              ),
        ),
      },
    );
    modules['serverpod_auth_idp'] = _iais.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth_core'] = _iacs.Endpoints()
      ..initializeEndpoints(server);
  }

  @override
  _is.FutureCallDispatch? get futureCalls {
    return _impq36kq.FutureCalls();
  }
}
