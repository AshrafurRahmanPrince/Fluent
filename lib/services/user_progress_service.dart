import 'dart:async';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DailyActivityProgress {
  const DailyActivityProgress({
    required this.date,
    required this.lessonPoints,
    required this.quizPoints,
    required this.activityPoints,
  });

  final DateTime date;
  final int lessonPoints;
  final int quizPoints;
  final int activityPoints;

  int get totalPoints => lessonPoints + quizPoints + activityPoints;

  String get weekdayLabel => const [
        'Mon',
        'Tue',
        'Wed',
        'Thu',
        'Fri',
        'Sat',
        'Sun',
      ][date.weekday - 1];
}

class UserProfileProgress {
  const UserProfileProgress({
    required this.completedLessons,
    required this.completedQuizzes,
    required this.averageQuizScore,
    required this.activeStreak,
  });

  final int completedLessons;
  final int completedQuizzes;
  final double averageQuizScore;
  final int activeStreak;
}

class UserProgressService {
  static const String _storagePrefix = 'user_progress_events';
  static const Duration _retentionPeriod = Duration(days: 366);

  static final UserProgressService instance = UserProgressService();

  final Future<SharedPreferences> Function() _preferencesProvider;
  final String? Function() _userIdProvider;
  final DateTime Function() _clock;
  final StreamController<int> _changes = StreamController<int>.broadcast();
  int _changeVersion = 0;

  UserProgressService({
    Future<SharedPreferences> Function()? preferencesProvider,
    String? Function()? userIdProvider,
    DateTime Function()? clock,
  })  : _preferencesProvider =
            preferencesProvider ?? SharedPreferences.getInstance,
        _userIdProvider = userIdProvider ?? _currentFirebaseUserId,
        _clock = clock ?? DateTime.now;

  Future<void> logDailyActivity({
    required String activityType,
    int points = 1,
  }) async {
    final normalizedType = activityType.trim().toLowerCase();
    if (normalizedType.isEmpty) {
      throw ArgumentError.value(
          activityType, 'activityType', 'Cannot be empty.');
    }
    if (points <= 0) {
      throw ArgumentError.value(points, 'points', 'Must be greater than zero.');
    }

    final now = _clock();
    final preferences = await _preferencesProvider();
    final events = _readEvents(preferences.getString(_storageKey));
    events.removeWhere((event) {
      final timestamp = DateTime.tryParse(event['timestamp'] as String? ?? '');
      return timestamp == null ||
          timestamp.isBefore(now.subtract(_retentionPeriod));
    });
    events.add({
      'activityType': normalizedType,
      'points': points,
      'timestamp': now.toIso8601String(),
    });

    await preferences.setString(_storageKey, jsonEncode(events));
    _changes.add(++_changeVersion);
  }

  Future<void> logQuizResult({
    required int score,
    required int total,
    String activityType = 'quiz',
  }) async {
    if (total <= 0 || score < 0 || score > total) {
      throw ArgumentError('Quiz score must be between zero and total.');
    }
    final normalizedType = activityType.trim().toLowerCase();
    if (normalizedType.isEmpty || !normalizedType.contains('quiz')) {
      throw ArgumentError.value(
        activityType,
        'activityType',
        'Must identify a quiz activity.',
      );
    }

    final now = _clock();
    final preferences = await _preferencesProvider();
    final events = _readEvents(preferences.getString(_storageKey));
    events.removeWhere((event) {
      final timestamp = DateTime.tryParse(event['timestamp'] as String? ?? '');
      return timestamp == null ||
          timestamp.isBefore(now.subtract(_retentionPeriod));
    });
    events.add({
      'activityType': normalizedType,
      'points': 1,
      'score': score,
      'total': total,
      'timestamp': now.toIso8601String(),
    });

    await preferences.setString(_storageKey, jsonEncode(events));
    _changes.add(++_changeVersion);
  }

  Future<UserProfileProgress> getProfileProgress() async {
    final preferences = await _preferencesProvider();
    final events = _readEvents(preferences.getString(_storageKey));
    final quizzes = events
        .where((event) =>
            (event['activityType'] as String? ?? '').contains('quiz'))
        .toList(growable: false);
    final scoredQuizzes = quizzes.where((event) {
      final score = event['score'];
      final total = event['total'];
      return score is int && total is int && total > 0;
    });
    final earnedPoints = scoredQuizzes.fold<int>(
      0,
      (sum, event) => sum + (event['score'] as int),
    );
    final possiblePoints = scoredQuizzes.fold<int>(
      0,
      (sum, event) => sum + (event['total'] as int),
    );
    final activityDays = <DateTime>{};
    for (final event in events) {
      final timestamp = DateTime.tryParse(event['timestamp'] as String? ?? '');
      if (timestamp != null) {
        activityDays
            .add(DateTime(timestamp.year, timestamp.month, timestamp.day));
      }
    }

    final now = _clock();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    var streakStart = activityDays.contains(today)
        ? today
        : activityDays.contains(yesterday)
            ? yesterday
            : null;
    var activeStreak = 0;
    while (streakStart != null && activityDays.contains(streakStart)) {
      activeStreak++;
      streakStart = streakStart.subtract(const Duration(days: 1));
    }

    final completedLessons = events.where((event) {
      final activityType = event['activityType'] as String? ?? '';
      return activityType.contains('lesson') ||
          activityType.contains('reading');
    }).length;

    return UserProfileProgress(
      completedLessons: completedLessons,
      completedQuizzes: quizzes.length,
      averageQuizScore:
          possiblePoints == 0 ? 0 : earnedPoints / possiblePoints * 100,
      activeStreak: activeStreak,
    );
  }

  Future<List<DailyActivityProgress>> getCurrentWeekProgress({
    DateTime? date,
  }) async {
    final selectedDate = date ?? _clock();
    final emptyWeek = emptyCurrentWeek(selectedDate);
    final weekStart = emptyWeek.first.date;
    final weekEnd = weekStart.add(const Duration(days: 7));
    final preferences = await _preferencesProvider();
    final events = _readEvents(preferences.getString(_storageKey));
    final pointsByDate = <String, _DailyPointTotals>{};

    for (final event in events) {
      final timestamp = DateTime.tryParse(event['timestamp'] as String? ?? '');
      if (timestamp == null ||
          timestamp.isBefore(weekStart) ||
          !timestamp.isBefore(weekEnd)) {
        continue;
      }

      final points = event['points'] as int? ?? 1;
      final activityType = event['activityType'] as String? ?? 'activity';
      final totals = pointsByDate.putIfAbsent(
        _dateKey(timestamp),
        _DailyPointTotals.new,
      );
      totals.add(activityType, points);
    }

    return List.unmodifiable([
      for (final day in emptyWeek)
        DailyActivityProgress(
          date: day.date,
          lessonPoints: pointsByDate[_dateKey(day.date)]?.lessonPoints ?? 0,
          quizPoints: pointsByDate[_dateKey(day.date)]?.quizPoints ?? 0,
          activityPoints: pointsByDate[_dateKey(day.date)]?.activityPoints ?? 0,
        ),
    ]);
  }

  List<DailyActivityProgress> emptyCurrentWeek([DateTime? date]) {
    final selectedDate = date ?? _clock();
    final currentDay =
        DateTime(selectedDate.year, selectedDate.month, selectedDate.day);
    final weekStart = currentDay
        .subtract(Duration(days: currentDay.weekday - DateTime.monday));

    return List.unmodifiable([
      for (var offset = 0; offset < DateTime.daysPerWeek; offset++)
        DailyActivityProgress(
          date: weekStart.add(Duration(days: offset)),
          lessonPoints: 0,
          quizPoints: 0,
          activityPoints: 0,
        ),
    ]);
  }

  Stream<List<DailyActivityProgress>> watchCurrentWeekProgress() {
    late StreamController<List<DailyActivityProgress>> controller;
    StreamSubscription<int>? changeSubscription;
    Timer? midnightTimer;

    Future<void> emitProgress() async {
      try {
        controller.add(await getCurrentWeekProgress());
      } catch (error, stackTrace) {
        controller.addError(error, stackTrace);
      }
    }

    void scheduleMidnightUpdate() {
      final now = _clock();
      final midnight = DateTime(now.year, now.month, now.day + 1);
      midnightTimer = Timer(midnight.difference(now), () {
        emitProgress();
        scheduleMidnightUpdate();
      });
    }

    controller = StreamController<List<DailyActivityProgress>>(
      onListen: () {
        changeSubscription = _changes.stream.listen((_) => emitProgress());
        emitProgress();
        scheduleMidnightUpdate();
      },
      onCancel: () {
        changeSubscription?.cancel();
        midnightTimer?.cancel();
      },
    );
    return controller.stream;
  }

  String get _storageKey {
    String? userId;
    try {
      userId = _userIdProvider();
    } catch (_) {
      userId = null;
    }
    final suffix = userId == null || userId.isEmpty ? 'local' : userId;
    return '${_storagePrefix}_$suffix';
  }

  List<Map<String, dynamic>> _readEvents(String? stored) {
    if (stored == null || stored.isEmpty) return [];

    try {
      final decoded = jsonDecode(stored);
      if (decoded is! List) return [];
      return [
        for (final event in decoded)
          if (event is Map<String, dynamic>) event,
      ];
    } on FormatException {
      return [];
    }
  }

  static String _dateKey(DateTime date) =>
      '${date.year.toString().padLeft(4, '0')}-'
      '${date.month.toString().padLeft(2, '0')}-'
      '${date.day.toString().padLeft(2, '0')}';

  static String? _currentFirebaseUserId() {
    try {
      return FirebaseAuth.instance.currentUser?.uid;
    } catch (_) {
      return null;
    }
  }
}

class _DailyPointTotals {
  int lessonPoints = 0;
  int quizPoints = 0;
  int activityPoints = 0;

  void add(String activityType, int points) {
    if (activityType.contains('quiz')) {
      quizPoints += points;
    } else if (activityType.contains('lesson') ||
        activityType.contains('reading')) {
      lessonPoints += points;
    } else {
      activityPoints += points;
    }
  }
}
