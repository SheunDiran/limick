/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_type_check

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:limick_client/src/protocol/book.dart' as _i5tn6nrb;
import 'package:limick_client/src/protocol/dto_author.dart' as _igl91g7y;
import 'package:limick_client/src/protocol/dto_comment_view.dart' as _ileb9px8;
import 'package:limick_client/src/protocol/dto_continue.dart' as _i50xy7df;
import 'package:limick_client/src/protocol/dto_room_message_view.dart'
    as _ijflktyh;
import 'package:limick_client/src/protocol/dto_room_view.dart' as _i17464ln;
import 'package:limick_client/src/protocol/dto_view_signal.dart' as _ikggovgk;
import 'package:limick_client/src/protocol/notification.dart' as _itxpegl2;
import 'package:limick_client/src/protocol/saved_word.dart' as _imgi0cxh;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _iaic;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'app_exception.dart' as _it4z223c;
import 'book.dart' as _ik00prxe;
import 'book_affinity.dart' as _iheyn0nw;
import 'book_follow.dart' as _ifw2abs1;
import 'book_status.dart' as _i7d3z7gh;
import 'chapter.dart' as _ijtgvs8z;
import 'comment.dart' as _i4ch5xwb;
import 'comment_like.dart' as _iv1pbuct;
import 'debate_vote.dart' as _i1ao0q81;
import 'dto_author.dart' as _irki9rqm;
import 'dto_book_detail.dart' as _ie9ufgod;
import 'dto_break_summary.dart' as _ipgomwcm;
import 'dto_chapter_content.dart' as _iamdz0mk;
import 'dto_chapter_summary.dart' as _ipu481lu;
import 'dto_comment_event.dart' as _isyalc54;
import 'dto_comment_view.dart' as _i4xf9a43;
import 'dto_continue.dart' as _i0x7j7yy;
import 'dto_feed.dart' as _i8qjxz8q;
import 'dto_feed_page.dart' as _iy4dx9rm;
import 'dto_library_status.dart' as _i38i2afe;
import 'dto_me.dart' as _iiwag67q;
import 'dto_onboarding.dart' as _it2c99n5;
import 'dto_profile_stats.dart' as _iea09c12;
import 'dto_public_profile.dart' as _igjwg1gl;
import 'dto_quiz_result.dart' as _i9qwqfkp;
import 'dto_room_event.dart' as _i1sm8sgq;
import 'dto_room_message_view.dart' as _idb2b7gg;
import 'dto_room_view.dart' as _i1rlo7qg;
import 'dto_view_signal.dart' as _iamhpvfi;
import 'feed_item_kind.dart' as _i5lurufd;
import 'live_event_type.dart' as _ijk6vck4;
import 'notification.dart' as _irt10kca;
import 'notification_kind.dart' as _ipnxo26v;
import 'official_post.dart' as _i2bhchuw;
import 'official_post_kind.dart' as _iwjxx537;
import 'official_seen.dart' as _ibehfvf0;
import 'post.dart' as _iwx4avst;
import 'post_kind.dart' as _i8wd172o;
import 'post_like.dart' as _i2v49lle;
import 'post_save.dart' as _i8z4gmw9;
import 'post_view.dart' as _i0k2rpbv;
import 'quiz_answer.dart' as _iqnkhz1e;
import 'reader.dart' as _in4ni7b0;
import 'reading_progress.dart' as _i2h1sfz6;
import 'report.dart' as _i2t8i3ij;
import 'room.dart' as _ieflxecy;
import 'room_member.dart' as _ii94tgib;
import 'room_message.dart' as _i2z40emo;
import 'saved_word.dart' as _itxlv1gb;
import 'study_break.dart' as _i199zodz;
import 'topic.dart' as _iro94j51;
import 'topic_affinity.dart' as _irpydd89;
import 'user_block.dart' as _il7h76lp;
export 'app_exception.dart';
export 'book.dart';
export 'book_affinity.dart';
export 'book_follow.dart';
export 'book_status.dart';
export 'chapter.dart';
export 'comment.dart';
export 'comment_like.dart';
export 'debate_vote.dart';
export 'dto_author.dart';
export 'dto_book_detail.dart';
export 'dto_break_summary.dart';
export 'dto_chapter_content.dart';
export 'dto_chapter_summary.dart';
export 'dto_comment_event.dart';
export 'dto_comment_view.dart';
export 'dto_continue.dart';
export 'dto_feed.dart';
export 'dto_feed_page.dart';
export 'dto_library_status.dart';
export 'dto_me.dart';
export 'dto_onboarding.dart';
export 'dto_profile_stats.dart';
export 'dto_public_profile.dart';
export 'dto_quiz_result.dart';
export 'dto_room_event.dart';
export 'dto_room_message_view.dart';
export 'dto_room_view.dart';
export 'dto_view_signal.dart';
export 'feed_item_kind.dart';
export 'live_event_type.dart';
export 'notification.dart';
export 'notification_kind.dart';
export 'official_post.dart';
export 'official_post_kind.dart';
export 'official_seen.dart';
export 'post.dart';
export 'post_kind.dart';
export 'post_like.dart';
export 'post_save.dart';
export 'post_view.dart';
export 'quiz_answer.dart';
export 'reader.dart';
export 'reading_progress.dart';
export 'report.dart';
export 'room.dart';
export 'room_member.dart';
export 'room_message.dart';
export 'saved_word.dart';
export 'study_break.dart';
export 'topic.dart';
export 'topic_affinity.dart';
export 'user_block.dart';
export 'client.dart';

class Protocol extends _isc.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._().._registerHostProtocols();

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on _isc.DeserializationClassNameNotFoundException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _it4z223c.AppException) {
      return _it4z223c.AppException.fromJson(data) as T;
    }
    if (t == _ik00prxe.Book) {
      return _ik00prxe.Book.fromJson(data) as T;
    }
    if (t == _iheyn0nw.BookAffinity) {
      return _iheyn0nw.BookAffinity.fromJson(data) as T;
    }
    if (t == _ifw2abs1.BookFollow) {
      return _ifw2abs1.BookFollow.fromJson(data) as T;
    }
    if (t == _i7d3z7gh.BookStatus) {
      return _i7d3z7gh.BookStatus.fromJson(data) as T;
    }
    if (t == _ijtgvs8z.Chapter) {
      return _ijtgvs8z.Chapter.fromJson(data) as T;
    }
    if (t == _i4ch5xwb.Comment) {
      return _i4ch5xwb.Comment.fromJson(data) as T;
    }
    if (t == _iv1pbuct.CommentLike) {
      return _iv1pbuct.CommentLike.fromJson(data) as T;
    }
    if (t == _i1ao0q81.DebateVote) {
      return _i1ao0q81.DebateVote.fromJson(data) as T;
    }
    if (t == _irki9rqm.Author) {
      return _irki9rqm.Author.fromJson(data) as T;
    }
    if (t == _ie9ufgod.BookDetail) {
      return _ie9ufgod.BookDetail.fromJson(data) as T;
    }
    if (t == _ipgomwcm.BreakSummary) {
      return _ipgomwcm.BreakSummary.fromJson(data) as T;
    }
    if (t == _iamdz0mk.ChapterContent) {
      return _iamdz0mk.ChapterContent.fromJson(data) as T;
    }
    if (t == _ipu481lu.ChapterSummary) {
      return _ipu481lu.ChapterSummary.fromJson(data) as T;
    }
    if (t == _isyalc54.CommentEvent) {
      return _isyalc54.CommentEvent.fromJson(data) as T;
    }
    if (t == _i4xf9a43.CommentView) {
      return _i4xf9a43.CommentView.fromJson(data) as T;
    }
    if (t == _i0x7j7yy.ContinueReading) {
      return _i0x7j7yy.ContinueReading.fromJson(data) as T;
    }
    if (t == _i8qjxz8q.FeedItem) {
      return _i8qjxz8q.FeedItem.fromJson(data) as T;
    }
    if (t == _iy4dx9rm.FeedPage) {
      return _iy4dx9rm.FeedPage.fromJson(data) as T;
    }
    if (t == _i38i2afe.LibraryStatus) {
      return _i38i2afe.LibraryStatus.fromJson(data) as T;
    }
    if (t == _iiwag67q.Me) {
      return _iiwag67q.Me.fromJson(data) as T;
    }
    if (t == _it2c99n5.OnboardingInput) {
      return _it2c99n5.OnboardingInput.fromJson(data) as T;
    }
    if (t == _iea09c12.ProfileStats) {
      return _iea09c12.ProfileStats.fromJson(data) as T;
    }
    if (t == _igjwg1gl.PublicProfile) {
      return _igjwg1gl.PublicProfile.fromJson(data) as T;
    }
    if (t == _i9qwqfkp.QuizResult) {
      return _i9qwqfkp.QuizResult.fromJson(data) as T;
    }
    if (t == _i1sm8sgq.RoomEvent) {
      return _i1sm8sgq.RoomEvent.fromJson(data) as T;
    }
    if (t == _idb2b7gg.RoomMessageView) {
      return _idb2b7gg.RoomMessageView.fromJson(data) as T;
    }
    if (t == _i1rlo7qg.RoomView) {
      return _i1rlo7qg.RoomView.fromJson(data) as T;
    }
    if (t == _iamhpvfi.ViewSignal) {
      return _iamhpvfi.ViewSignal.fromJson(data) as T;
    }
    if (t == _i5lurufd.FeedItemKind) {
      return _i5lurufd.FeedItemKind.fromJson(data) as T;
    }
    if (t == _ijk6vck4.LiveEventType) {
      return _ijk6vck4.LiveEventType.fromJson(data) as T;
    }
    if (t == _irt10kca.ReaderNotification) {
      return _irt10kca.ReaderNotification.fromJson(data) as T;
    }
    if (t == _ipnxo26v.NotificationKind) {
      return _ipnxo26v.NotificationKind.fromJson(data) as T;
    }
    if (t == _i2bhchuw.OfficialPost) {
      return _i2bhchuw.OfficialPost.fromJson(data) as T;
    }
    if (t == _iwjxx537.OfficialPostKind) {
      return _iwjxx537.OfficialPostKind.fromJson(data) as T;
    }
    if (t == _ibehfvf0.OfficialSeen) {
      return _ibehfvf0.OfficialSeen.fromJson(data) as T;
    }
    if (t == _iwx4avst.Post) {
      return _iwx4avst.Post.fromJson(data) as T;
    }
    if (t == _i8wd172o.PostKind) {
      return _i8wd172o.PostKind.fromJson(data) as T;
    }
    if (t == _i2v49lle.PostLike) {
      return _i2v49lle.PostLike.fromJson(data) as T;
    }
    if (t == _i8z4gmw9.PostSave) {
      return _i8z4gmw9.PostSave.fromJson(data) as T;
    }
    if (t == _i0k2rpbv.PostView) {
      return _i0k2rpbv.PostView.fromJson(data) as T;
    }
    if (t == _iqnkhz1e.QuizAnswer) {
      return _iqnkhz1e.QuizAnswer.fromJson(data) as T;
    }
    if (t == _in4ni7b0.Reader) {
      return _in4ni7b0.Reader.fromJson(data) as T;
    }
    if (t == _i2h1sfz6.ReadingProgress) {
      return _i2h1sfz6.ReadingProgress.fromJson(data) as T;
    }
    if (t == _i2t8i3ij.Report) {
      return _i2t8i3ij.Report.fromJson(data) as T;
    }
    if (t == _ieflxecy.Room) {
      return _ieflxecy.Room.fromJson(data) as T;
    }
    if (t == _ii94tgib.RoomMember) {
      return _ii94tgib.RoomMember.fromJson(data) as T;
    }
    if (t == _i2z40emo.RoomMessage) {
      return _i2z40emo.RoomMessage.fromJson(data) as T;
    }
    if (t == _itxlv1gb.SavedWord) {
      return _itxlv1gb.SavedWord.fromJson(data) as T;
    }
    if (t == _i199zodz.StudyBreak) {
      return _i199zodz.StudyBreak.fromJson(data) as T;
    }
    if (t == _iro94j51.Topic) {
      return _iro94j51.Topic.fromJson(data) as T;
    }
    if (t == _irpydd89.TopicAffinity) {
      return _irpydd89.TopicAffinity.fromJson(data) as T;
    }
    if (t == _il7h76lp.UserBlock) {
      return _il7h76lp.UserBlock.fromJson(data) as T;
    }
    if (t == _isc.getType<_it4z223c.AppException?>()) {
      return (data != null ? _it4z223c.AppException.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ik00prxe.Book?>()) {
      return (data != null ? _ik00prxe.Book.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iheyn0nw.BookAffinity?>()) {
      return (data != null ? _iheyn0nw.BookAffinity.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ifw2abs1.BookFollow?>()) {
      return (data != null ? _ifw2abs1.BookFollow.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i7d3z7gh.BookStatus?>()) {
      return (data != null ? _i7d3z7gh.BookStatus.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ijtgvs8z.Chapter?>()) {
      return (data != null ? _ijtgvs8z.Chapter.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i4ch5xwb.Comment?>()) {
      return (data != null ? _i4ch5xwb.Comment.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iv1pbuct.CommentLike?>()) {
      return (data != null ? _iv1pbuct.CommentLike.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i1ao0q81.DebateVote?>()) {
      return (data != null ? _i1ao0q81.DebateVote.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_irki9rqm.Author?>()) {
      return (data != null ? _irki9rqm.Author.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ie9ufgod.BookDetail?>()) {
      return (data != null ? _ie9ufgod.BookDetail.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ipgomwcm.BreakSummary?>()) {
      return (data != null ? _ipgomwcm.BreakSummary.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iamdz0mk.ChapterContent?>()) {
      return (data != null ? _iamdz0mk.ChapterContent.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ipu481lu.ChapterSummary?>()) {
      return (data != null ? _ipu481lu.ChapterSummary.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_isyalc54.CommentEvent?>()) {
      return (data != null ? _isyalc54.CommentEvent.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i4xf9a43.CommentView?>()) {
      return (data != null ? _i4xf9a43.CommentView.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i0x7j7yy.ContinueReading?>()) {
      return (data != null ? _i0x7j7yy.ContinueReading.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i8qjxz8q.FeedItem?>()) {
      return (data != null ? _i8qjxz8q.FeedItem.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iy4dx9rm.FeedPage?>()) {
      return (data != null ? _iy4dx9rm.FeedPage.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i38i2afe.LibraryStatus?>()) {
      return (data != null ? _i38i2afe.LibraryStatus.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iiwag67q.Me?>()) {
      return (data != null ? _iiwag67q.Me.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_it2c99n5.OnboardingInput?>()) {
      return (data != null ? _it2c99n5.OnboardingInput.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iea09c12.ProfileStats?>()) {
      return (data != null ? _iea09c12.ProfileStats.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_igjwg1gl.PublicProfile?>()) {
      return (data != null ? _igjwg1gl.PublicProfile.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i9qwqfkp.QuizResult?>()) {
      return (data != null ? _i9qwqfkp.QuizResult.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i1sm8sgq.RoomEvent?>()) {
      return (data != null ? _i1sm8sgq.RoomEvent.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_idb2b7gg.RoomMessageView?>()) {
      return (data != null ? _idb2b7gg.RoomMessageView.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i1rlo7qg.RoomView?>()) {
      return (data != null ? _i1rlo7qg.RoomView.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iamhpvfi.ViewSignal?>()) {
      return (data != null ? _iamhpvfi.ViewSignal.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i5lurufd.FeedItemKind?>()) {
      return (data != null ? _i5lurufd.FeedItemKind.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ijk6vck4.LiveEventType?>()) {
      return (data != null ? _ijk6vck4.LiveEventType.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_irt10kca.ReaderNotification?>()) {
      return (data != null ? _irt10kca.ReaderNotification.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ipnxo26v.NotificationKind?>()) {
      return (data != null ? _ipnxo26v.NotificationKind.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i2bhchuw.OfficialPost?>()) {
      return (data != null ? _i2bhchuw.OfficialPost.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iwjxx537.OfficialPostKind?>()) {
      return (data != null ? _iwjxx537.OfficialPostKind.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ibehfvf0.OfficialSeen?>()) {
      return (data != null ? _ibehfvf0.OfficialSeen.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iwx4avst.Post?>()) {
      return (data != null ? _iwx4avst.Post.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i8wd172o.PostKind?>()) {
      return (data != null ? _i8wd172o.PostKind.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i2v49lle.PostLike?>()) {
      return (data != null ? _i2v49lle.PostLike.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i8z4gmw9.PostSave?>()) {
      return (data != null ? _i8z4gmw9.PostSave.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i0k2rpbv.PostView?>()) {
      return (data != null ? _i0k2rpbv.PostView.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iqnkhz1e.QuizAnswer?>()) {
      return (data != null ? _iqnkhz1e.QuizAnswer.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_in4ni7b0.Reader?>()) {
      return (data != null ? _in4ni7b0.Reader.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i2h1sfz6.ReadingProgress?>()) {
      return (data != null ? _i2h1sfz6.ReadingProgress.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i2t8i3ij.Report?>()) {
      return (data != null ? _i2t8i3ij.Report.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ieflxecy.Room?>()) {
      return (data != null ? _ieflxecy.Room.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ii94tgib.RoomMember?>()) {
      return (data != null ? _ii94tgib.RoomMember.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i2z40emo.RoomMessage?>()) {
      return (data != null ? _i2z40emo.RoomMessage.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_itxlv1gb.SavedWord?>()) {
      return (data != null ? _itxlv1gb.SavedWord.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i199zodz.StudyBreak?>()) {
      return (data != null ? _i199zodz.StudyBreak.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iro94j51.Topic?>()) {
      return (data != null ? _iro94j51.Topic.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_irpydd89.TopicAffinity?>()) {
      return (data != null ? _irpydd89.TopicAffinity.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_il7h76lp.UserBlock?>()) {
      return (data != null ? _il7h76lp.UserBlock.fromJson(data) : null) as T;
    }
    if (t == List<_iro94j51.Topic>) {
      return (data as List).map((e) => deserialize<_iro94j51.Topic>(e)).toList()
          as T;
    }
    if (t == List<_ipu481lu.ChapterSummary>) {
      return (data as List)
              .map((e) => deserialize<_ipu481lu.ChapterSummary>(e))
              .toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == _isc.getType<List<int>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<int>(e)).toList()
              : null)
          as T;
    }
    if (t == List<_i8qjxz8q.FeedItem>) {
      return (data as List)
              .map((e) => deserialize<_i8qjxz8q.FeedItem>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<String>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<String>(e)).toList()
              : null)
          as T;
    }
    if (t == List<_i5tn6nrb.Book>) {
      return (data as List).map((e) => deserialize<_i5tn6nrb.Book>(e)).toList()
          as T;
    }
    if (t == List<_i50xy7df.ContinueReading>) {
      return (data as List)
              .map((e) => deserialize<_i50xy7df.ContinueReading>(e))
              .toList()
          as T;
    }
    if (t == List<_ileb9px8.CommentView>) {
      return (data as List)
              .map((e) => deserialize<_ileb9px8.CommentView>(e))
              .toList()
          as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == List<_ikggovgk.ViewSignal>) {
      return (data as List)
              .map((e) => deserialize<_ikggovgk.ViewSignal>(e))
              .toList()
          as T;
    }
    if (t == List<_igl91g7y.Author>) {
      return (data as List)
              .map((e) => deserialize<_igl91g7y.Author>(e))
              .toList()
          as T;
    }
    if (t == List<_itxpegl2.ReaderNotification>) {
      return (data as List)
              .map((e) => deserialize<_itxpegl2.ReaderNotification>(e))
              .toList()
          as T;
    }
    if (t == List<_i17464ln.RoomView>) {
      return (data as List)
              .map((e) => deserialize<_i17464ln.RoomView>(e))
              .toList()
          as T;
    }
    if (t == List<_ijflktyh.RoomMessageView>) {
      return (data as List)
              .map((e) => deserialize<_ijflktyh.RoomMessageView>(e))
              .toList()
          as T;
    }
    if (t == List<_imgi0cxh.SavedWord>) {
      return (data as List)
              .map((e) => deserialize<_imgi0cxh.SavedWord>(e))
              .toList()
          as T;
    }
    try {
      return _iaic.Protocol().deserialize<T>(data, t);
    } on _isc.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _iacc.Protocol().deserialize<T>(data, t);
    } on _isc.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _it4z223c.AppException => 'AppException',
      _ik00prxe.Book => 'Book',
      _iheyn0nw.BookAffinity => 'BookAffinity',
      _ifw2abs1.BookFollow => 'BookFollow',
      _i7d3z7gh.BookStatus => 'BookStatus',
      _ijtgvs8z.Chapter => 'Chapter',
      _i4ch5xwb.Comment => 'Comment',
      _iv1pbuct.CommentLike => 'CommentLike',
      _i1ao0q81.DebateVote => 'DebateVote',
      _irki9rqm.Author => 'Author',
      _ie9ufgod.BookDetail => 'BookDetail',
      _ipgomwcm.BreakSummary => 'BreakSummary',
      _iamdz0mk.ChapterContent => 'ChapterContent',
      _ipu481lu.ChapterSummary => 'ChapterSummary',
      _isyalc54.CommentEvent => 'CommentEvent',
      _i4xf9a43.CommentView => 'CommentView',
      _i0x7j7yy.ContinueReading => 'ContinueReading',
      _i8qjxz8q.FeedItem => 'FeedItem',
      _iy4dx9rm.FeedPage => 'FeedPage',
      _i38i2afe.LibraryStatus => 'LibraryStatus',
      _iiwag67q.Me => 'Me',
      _it2c99n5.OnboardingInput => 'OnboardingInput',
      _iea09c12.ProfileStats => 'ProfileStats',
      _igjwg1gl.PublicProfile => 'PublicProfile',
      _i9qwqfkp.QuizResult => 'QuizResult',
      _i1sm8sgq.RoomEvent => 'RoomEvent',
      _idb2b7gg.RoomMessageView => 'RoomMessageView',
      _i1rlo7qg.RoomView => 'RoomView',
      _iamhpvfi.ViewSignal => 'ViewSignal',
      _i5lurufd.FeedItemKind => 'FeedItemKind',
      _ijk6vck4.LiveEventType => 'LiveEventType',
      _irt10kca.ReaderNotification => 'ReaderNotification',
      _ipnxo26v.NotificationKind => 'NotificationKind',
      _i2bhchuw.OfficialPost => 'OfficialPost',
      _iwjxx537.OfficialPostKind => 'OfficialPostKind',
      _ibehfvf0.OfficialSeen => 'OfficialSeen',
      _iwx4avst.Post => 'Post',
      _i8wd172o.PostKind => 'PostKind',
      _i2v49lle.PostLike => 'PostLike',
      _i8z4gmw9.PostSave => 'PostSave',
      _i0k2rpbv.PostView => 'PostView',
      _iqnkhz1e.QuizAnswer => 'QuizAnswer',
      _in4ni7b0.Reader => 'Reader',
      _i2h1sfz6.ReadingProgress => 'ReadingProgress',
      _i2t8i3ij.Report => 'Report',
      _ieflxecy.Room => 'Room',
      _ii94tgib.RoomMember => 'RoomMember',
      _i2z40emo.RoomMessage => 'RoomMessage',
      _itxlv1gb.SavedWord => 'SavedWord',
      _i199zodz.StudyBreak => 'StudyBreak',
      _iro94j51.Topic => 'Topic',
      _irpydd89.TopicAffinity => 'TopicAffinity',
      _il7h76lp.UserBlock => 'UserBlock',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('limick.', '');
    }

    switch (data) {
      case _it4z223c.AppException():
        return 'AppException';
      case _ik00prxe.Book():
        return 'Book';
      case _iheyn0nw.BookAffinity():
        return 'BookAffinity';
      case _ifw2abs1.BookFollow():
        return 'BookFollow';
      case _i7d3z7gh.BookStatus():
        return 'BookStatus';
      case _ijtgvs8z.Chapter():
        return 'Chapter';
      case _i4ch5xwb.Comment():
        return 'Comment';
      case _iv1pbuct.CommentLike():
        return 'CommentLike';
      case _i1ao0q81.DebateVote():
        return 'DebateVote';
      case _irki9rqm.Author():
        return 'Author';
      case _ie9ufgod.BookDetail():
        return 'BookDetail';
      case _ipgomwcm.BreakSummary():
        return 'BreakSummary';
      case _iamdz0mk.ChapterContent():
        return 'ChapterContent';
      case _ipu481lu.ChapterSummary():
        return 'ChapterSummary';
      case _isyalc54.CommentEvent():
        return 'CommentEvent';
      case _i4xf9a43.CommentView():
        return 'CommentView';
      case _i0x7j7yy.ContinueReading():
        return 'ContinueReading';
      case _i8qjxz8q.FeedItem():
        return 'FeedItem';
      case _iy4dx9rm.FeedPage():
        return 'FeedPage';
      case _i38i2afe.LibraryStatus():
        return 'LibraryStatus';
      case _iiwag67q.Me():
        return 'Me';
      case _it2c99n5.OnboardingInput():
        return 'OnboardingInput';
      case _iea09c12.ProfileStats():
        return 'ProfileStats';
      case _igjwg1gl.PublicProfile():
        return 'PublicProfile';
      case _i9qwqfkp.QuizResult():
        return 'QuizResult';
      case _i1sm8sgq.RoomEvent():
        return 'RoomEvent';
      case _idb2b7gg.RoomMessageView():
        return 'RoomMessageView';
      case _i1rlo7qg.RoomView():
        return 'RoomView';
      case _iamhpvfi.ViewSignal():
        return 'ViewSignal';
      case _i5lurufd.FeedItemKind():
        return 'FeedItemKind';
      case _ijk6vck4.LiveEventType():
        return 'LiveEventType';
      case _irt10kca.ReaderNotification():
        return 'ReaderNotification';
      case _ipnxo26v.NotificationKind():
        return 'NotificationKind';
      case _i2bhchuw.OfficialPost():
        return 'OfficialPost';
      case _iwjxx537.OfficialPostKind():
        return 'OfficialPostKind';
      case _ibehfvf0.OfficialSeen():
        return 'OfficialSeen';
      case _iwx4avst.Post():
        return 'Post';
      case _i8wd172o.PostKind():
        return 'PostKind';
      case _i2v49lle.PostLike():
        return 'PostLike';
      case _i8z4gmw9.PostSave():
        return 'PostSave';
      case _i0k2rpbv.PostView():
        return 'PostView';
      case _iqnkhz1e.QuizAnswer():
        return 'QuizAnswer';
      case _in4ni7b0.Reader():
        return 'Reader';
      case _i2h1sfz6.ReadingProgress():
        return 'ReadingProgress';
      case _i2t8i3ij.Report():
        return 'Report';
      case _ieflxecy.Room():
        return 'Room';
      case _ii94tgib.RoomMember():
        return 'RoomMember';
      case _i2z40emo.RoomMessage():
        return 'RoomMessage';
      case _itxlv1gb.SavedWord():
        return 'SavedWord';
      case _i199zodz.StudyBreak():
        return 'StudyBreak';
      case _iro94j51.Topic():
        return 'Topic';
      case _irpydd89.TopicAffinity():
        return 'TopicAffinity';
      case _il7h76lp.UserBlock():
        return 'UserBlock';
    }
    className = _iaic.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_idp.$className';
    }
    className = _iacc.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_core.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'AppException') {
      return deserialize<_it4z223c.AppException>(data['data']);
    }
    if (dataClassName == 'Book') {
      return deserialize<_ik00prxe.Book>(data['data']);
    }
    if (dataClassName == 'BookAffinity') {
      return deserialize<_iheyn0nw.BookAffinity>(data['data']);
    }
    if (dataClassName == 'BookFollow') {
      return deserialize<_ifw2abs1.BookFollow>(data['data']);
    }
    if (dataClassName == 'BookStatus') {
      return deserialize<_i7d3z7gh.BookStatus>(data['data']);
    }
    if (dataClassName == 'Chapter') {
      return deserialize<_ijtgvs8z.Chapter>(data['data']);
    }
    if (dataClassName == 'Comment') {
      return deserialize<_i4ch5xwb.Comment>(data['data']);
    }
    if (dataClassName == 'CommentLike') {
      return deserialize<_iv1pbuct.CommentLike>(data['data']);
    }
    if (dataClassName == 'DebateVote') {
      return deserialize<_i1ao0q81.DebateVote>(data['data']);
    }
    if (dataClassName == 'Author') {
      return deserialize<_irki9rqm.Author>(data['data']);
    }
    if (dataClassName == 'BookDetail') {
      return deserialize<_ie9ufgod.BookDetail>(data['data']);
    }
    if (dataClassName == 'BreakSummary') {
      return deserialize<_ipgomwcm.BreakSummary>(data['data']);
    }
    if (dataClassName == 'ChapterContent') {
      return deserialize<_iamdz0mk.ChapterContent>(data['data']);
    }
    if (dataClassName == 'ChapterSummary') {
      return deserialize<_ipu481lu.ChapterSummary>(data['data']);
    }
    if (dataClassName == 'CommentEvent') {
      return deserialize<_isyalc54.CommentEvent>(data['data']);
    }
    if (dataClassName == 'CommentView') {
      return deserialize<_i4xf9a43.CommentView>(data['data']);
    }
    if (dataClassName == 'ContinueReading') {
      return deserialize<_i0x7j7yy.ContinueReading>(data['data']);
    }
    if (dataClassName == 'FeedItem') {
      return deserialize<_i8qjxz8q.FeedItem>(data['data']);
    }
    if (dataClassName == 'FeedPage') {
      return deserialize<_iy4dx9rm.FeedPage>(data['data']);
    }
    if (dataClassName == 'LibraryStatus') {
      return deserialize<_i38i2afe.LibraryStatus>(data['data']);
    }
    if (dataClassName == 'Me') {
      return deserialize<_iiwag67q.Me>(data['data']);
    }
    if (dataClassName == 'OnboardingInput') {
      return deserialize<_it2c99n5.OnboardingInput>(data['data']);
    }
    if (dataClassName == 'ProfileStats') {
      return deserialize<_iea09c12.ProfileStats>(data['data']);
    }
    if (dataClassName == 'PublicProfile') {
      return deserialize<_igjwg1gl.PublicProfile>(data['data']);
    }
    if (dataClassName == 'QuizResult') {
      return deserialize<_i9qwqfkp.QuizResult>(data['data']);
    }
    if (dataClassName == 'RoomEvent') {
      return deserialize<_i1sm8sgq.RoomEvent>(data['data']);
    }
    if (dataClassName == 'RoomMessageView') {
      return deserialize<_idb2b7gg.RoomMessageView>(data['data']);
    }
    if (dataClassName == 'RoomView') {
      return deserialize<_i1rlo7qg.RoomView>(data['data']);
    }
    if (dataClassName == 'ViewSignal') {
      return deserialize<_iamhpvfi.ViewSignal>(data['data']);
    }
    if (dataClassName == 'FeedItemKind') {
      return deserialize<_i5lurufd.FeedItemKind>(data['data']);
    }
    if (dataClassName == 'LiveEventType') {
      return deserialize<_ijk6vck4.LiveEventType>(data['data']);
    }
    if (dataClassName == 'ReaderNotification') {
      return deserialize<_irt10kca.ReaderNotification>(data['data']);
    }
    if (dataClassName == 'NotificationKind') {
      return deserialize<_ipnxo26v.NotificationKind>(data['data']);
    }
    if (dataClassName == 'OfficialPost') {
      return deserialize<_i2bhchuw.OfficialPost>(data['data']);
    }
    if (dataClassName == 'OfficialPostKind') {
      return deserialize<_iwjxx537.OfficialPostKind>(data['data']);
    }
    if (dataClassName == 'OfficialSeen') {
      return deserialize<_ibehfvf0.OfficialSeen>(data['data']);
    }
    if (dataClassName == 'Post') {
      return deserialize<_iwx4avst.Post>(data['data']);
    }
    if (dataClassName == 'PostKind') {
      return deserialize<_i8wd172o.PostKind>(data['data']);
    }
    if (dataClassName == 'PostLike') {
      return deserialize<_i2v49lle.PostLike>(data['data']);
    }
    if (dataClassName == 'PostSave') {
      return deserialize<_i8z4gmw9.PostSave>(data['data']);
    }
    if (dataClassName == 'PostView') {
      return deserialize<_i0k2rpbv.PostView>(data['data']);
    }
    if (dataClassName == 'QuizAnswer') {
      return deserialize<_iqnkhz1e.QuizAnswer>(data['data']);
    }
    if (dataClassName == 'Reader') {
      return deserialize<_in4ni7b0.Reader>(data['data']);
    }
    if (dataClassName == 'ReadingProgress') {
      return deserialize<_i2h1sfz6.ReadingProgress>(data['data']);
    }
    if (dataClassName == 'Report') {
      return deserialize<_i2t8i3ij.Report>(data['data']);
    }
    if (dataClassName == 'Room') {
      return deserialize<_ieflxecy.Room>(data['data']);
    }
    if (dataClassName == 'RoomMember') {
      return deserialize<_ii94tgib.RoomMember>(data['data']);
    }
    if (dataClassName == 'RoomMessage') {
      return deserialize<_i2z40emo.RoomMessage>(data['data']);
    }
    if (dataClassName == 'SavedWord') {
      return deserialize<_itxlv1gb.SavedWord>(data['data']);
    }
    if (dataClassName == 'StudyBreak') {
      return deserialize<_i199zodz.StudyBreak>(data['data']);
    }
    if (dataClassName == 'Topic') {
      return deserialize<_iro94j51.Topic>(data['data']);
    }
    if (dataClassName == 'TopicAffinity') {
      return deserialize<_irpydd89.TopicAffinity>(data['data']);
    }
    if (dataClassName == 'UserBlock') {
      return deserialize<_il7h76lp.UserBlock>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _iaic.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _iacc.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  void _registerHostProtocols() {
    _iaic.Protocol().registerHostProtocol('limick', this);
    _iacc.Protocol().registerHostProtocol('limick', this);
  }

  @override
  String getModuleName() => 'limick';

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _iaic.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _iacc.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
