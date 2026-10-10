import 'dart:async';

import 'package:flutter/material.dart';
import 'package:limick_client/limick_client.dart';

import '../client.dart';

/// App-wide state: the signed-in reader, the running study break and the
/// theme. Screens listen to it with [ListenableBuilder].
class AppState extends ChangeNotifier {
  AppState._();
  static final instance = AppState._();

  Me? me;
  bool loading = false;
  Object? error;
  ThemeMode themeMode = ThemeMode.dark;

  StudyBreak? activeBreak;
  Timer? _breakTimer;

  /// Lets any screen ask the home shell to switch tabs (0 home, 1 discover,
  /// 2 rooms, 3 words, 4 profile).
  final tabRequest = ValueNotifier<int?>(null);

  /// Called by the break timer when the planned time is up.
  final breakFinished = StreamController<StudyBreak>.broadcast();

  Reader? get reader => me?.profile;
  bool get onboarded => reader?.onboarded ?? false;

  int get tzOffsetMinutes => DateTime.now().timeZoneOffset.inMinutes;

  Future<void> refresh() async {
    loading = true;
    error = null;
    notifyListeners();
    try {
      me = await client.profile.me(tzOffsetMinutes);
      _setBreak(me!.activeBreak);
    } catch (e) {
      error = e;
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  void setMe(Me value) {
    me = value;
    _setBreak(value.activeBreak);
    notifyListeners();
  }

  void updateReader(Reader reader) {
    if (me == null) return;
    me = me!.copyWith(profile: reader);
    notifyListeners();
  }

  void clear() {
    me = null;
    _setBreak(null);
    notifyListeners();
  }

  void toggleTheme() {
    themeMode = themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }

  // Study break -------------------------------------------------------------

  Duration get breakRemaining {
    final b = activeBreak;
    if (b == null) return Duration.zero;
    final end = b.startedAt.toLocal().add(Duration(minutes: b.plannedMinutes));
    final left = end.difference(DateTime.now());
    return left.isNegative ? Duration.zero : left;
  }

  Future<void> startBreak(int minutes) async {
    _setBreak(await client.studyBreak.start(minutes));
    notifyListeners();
  }

  Future<BreakSummary?> endBreak() async {
    final b = activeBreak;
    if (b == null) return null;
    final summary = await client.studyBreak.end(b.id!);
    _setBreak(null);
    notifyListeners();
    return summary;
  }

  void _setBreak(StudyBreak? value) {
    _breakTimer?.cancel();
    activeBreak = value;
    if (value == null) return;
    _breakTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (breakRemaining == Duration.zero) {
        _breakTimer?.cancel();
        breakFinished.add(value);
      }
      notifyListeners();
    });
  }
}

final app = AppState.instance;
