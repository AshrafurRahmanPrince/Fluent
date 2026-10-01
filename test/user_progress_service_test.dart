import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluento/services/user_progress_service.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test('unrecorded days in a new week start at zero', () async {
    final service = UserProgressService(
      userIdProvider: () => 'new-learner',
      clock: () => DateTime(2026, 10, 1),
    );

    final week = await service.getCurrentWeekProgress();

    expect(week, hasLength(7));
    expect(week.map((day) => day.date.weekday), [1, 2, 3, 4, 5, 6, 7]);
    expect(week.every((day) => day.totalPoints == 0), isTrue);
  });

  test('activity events are timestamped into the correct weekday groups',
      () async {
    var now = DateTime(2026, 10, 1, 14);
    final service = UserProgressService(
      userIdProvider: () => 'learner',
      clock: () => now,
    );

    await service.logDailyActivity(activityType: 'quiz', points: 2);
    await service.logDailyActivity(activityType: 'reading_passage');
    now = DateTime(2026, 10, 2, 9);
    await service.logDailyActivity(
        activityType: 'speaking_activity', points: 3);

    final week = await service.getCurrentWeekProgress(date: now);
    final thursday = week[3];
    final friday = week[4];

    expect(thursday.quizPoints, 2);
    expect(thursday.lessonPoints, 1);
    expect(thursday.activityPoints, 0);
    expect(friday.activityPoints, 3);
    expect(week[2].totalPoints, 0);
  });

  test('progress is isolated between user preference keys', () async {
    final firstUser = UserProgressService(
      userIdProvider: () => 'first',
      clock: () => DateTime(2026, 10, 1),
    );
    final secondUser = UserProgressService(
      userIdProvider: () => 'second',
      clock: () => DateTime(2026, 10, 1),
    );

    await firstUser.logDailyActivity(activityType: 'quiz');
    final secondUserWeek = await secondUser.getCurrentWeekProgress();

    expect(secondUserWeek.every((day) => day.totalPoints == 0), isTrue);
  });

  test('profile summary starts at zero when a user has no activity', () async {
    final service = UserProgressService(
      userIdProvider: () => 'empty-profile',
      clock: () => DateTime(2026, 10, 1),
    );

    final profile = await service.getProfileProgress();

    expect(profile.completedLessons, 0);
    expect(profile.completedQuizzes, 0);
    expect(profile.averageQuizScore, 0);
    expect(profile.activeStreak, 0);
  });

  test('profile summary aggregates quiz scores, lessons, and active streak',
      () async {
    var now = DateTime(2026, 9, 30, 10);
    final service = UserProgressService(
      userIdProvider: () => 'active-profile',
      clock: () => now,
    );

    await service.logDailyActivity(activityType: 'speaking_lesson');
    now = DateTime(2026, 10, 1, 9);
    await service.logDailyActivity(activityType: 'reading_passage');
    await service.logQuizResult(score: 8, total: 10);
    await service.logQuizResult(score: 6, total: 10);

    final profile = await service.getProfileProgress();

    expect(profile.completedLessons, 2);
    expect(profile.completedQuizzes, 2);
    expect(profile.averageQuizScore, 70);
    expect(profile.activeStreak, 2);
  });

  test('watch stream emits a new week summary after an activity is logged',
      () async {
    final service = UserProgressService(
      userIdProvider: () => 'stream-learner',
      clock: () => DateTime(2026, 10, 1),
    );
    final progress = StreamIterator(service.watchCurrentWeekProgress());

    expect(await progress.moveNext(), isTrue);
    expect(progress.current.every((day) => day.totalPoints == 0), isTrue);

    await service.logDailyActivity(activityType: 'writing_lesson');
    expect(await progress.moveNext(), isTrue);
    expect(progress.current[3].lessonPoints, 1);

    await progress.cancel();
  });
}
