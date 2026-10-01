import 'package:flutter_test/flutter_test.dart';
import 'package:fluento/data/ielts_question_bank.dart';
import 'package:fluento/models/quiz_question.dart';
import 'package:fluento/services/daily_quiz_service.dart';

void main() {
  final service = DailyQuizService();

  test('IELTS bank contains 100 explained questions across all categories', () {
    expect(ieltsQuestionBank.length, greaterThanOrEqualTo(100));
    expect(ieltsQuestionBank.map((question) => question.id).toSet().length,
        ieltsQuestionBank.length);
    expect(
      ieltsQuestionBank.map((question) => question.category).toSet(),
      IELTSQuestionCategory.values.toSet(),
    );
    for (final question in ieltsQuestionBank) {
      expect(question.options.length, 4);
      expect(question.correctAnswerIndex, inInclusiveRange(0, 3));
      expect(question.explanation, isNotEmpty);
    }
  });

  test('the same calendar date always returns the same ten questions', () {
    final date = DateTime(2026, 10, 1, 8);
    final firstSelection = service.questionsForDate(date);
    final secondSelection = service.questionsForDate(DateTime(2026, 10, 1, 22));

    expect(firstSelection, hasLength(DailyQuizService.questionsPerDay));
    expect(
      firstSelection.map((question) => question.id).toList(),
      secondSelection.map((question) => question.id).toList(),
    );
    expect(firstSelection.map((question) => question.id).toSet(),
        hasLength(DailyQuizService.questionsPerDay));
  });

  test('consecutive days have no questions in common', () {
    final today = service.questionsForDate(DateTime(2026, 10, 1));
    final tomorrow = service.questionsForDate(DateTime(2026, 10, 2));
    final todayIds = today.map((question) => question.id).toSet();
    final tomorrowIds = tomorrow.map((question) => question.id).toSet();

    expect(todayIds.intersection(tomorrowIds), isEmpty);
    expect(todayIds, isNot(equals(tomorrowIds)));
  });

  test('rotation handles month and year boundaries', () {
    final december = service.questionsForDate(DateTime(2026, 12, 31));
    final january = service.questionsForDate(DateTime(2027, 1, 1));

    expect(
      december.map((question) => question.id).toSet().intersection(
            january.map((question) => question.id).toSet(),
          ),
      isEmpty,
    );
  });
}
