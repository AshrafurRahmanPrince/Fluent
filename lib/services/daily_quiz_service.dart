import 'dart:math';

import '../data/ielts_question_bank.dart';
import '../models/quiz_question.dart';

class DailyQuizService {
  static const int questionsPerDay = 10;

  final List<QuizQuestion> _questionBank;

  DailyQuizService({List<QuizQuestion>? questionBank})
      : _questionBank = List.unmodifiable(questionBank ?? ieltsQuestionBank) {
    if (_questionBank.length < questionsPerDay * 2) {
      throw ArgumentError('The question bank must contain at least 20 items.');
    }
    if (_questionBank.map((question) => question.id).toSet().length !=
        _questionBank.length) {
      throw ArgumentError('Question IDs must be unique.');
    }
  }

  List<QuizQuestion> questionsForDate([DateTime? date]) {
    final selectedDate = date ?? DateTime.now();
    final day =
        DateTime(selectedDate.year, selectedDate.month, selectedDate.day);
    final previousDay = day.subtract(const Duration(days: 1));
    final previousBaseIds = _shuffledQuestionsForDay(previousDay)
        .take(questionsPerDay)
        .map((question) => question.id)
        .toSet();

    final selected = _shuffledQuestionsForDay(day)
        .where((question) => !previousBaseIds.contains(question.id))
        .take(questionsPerDay)
        .toList(growable: false);

    return List.unmodifiable(selected);
  }

  List<QuizQuestion> _shuffledQuestionsForDay(DateTime day) {
    final questions = List<QuizQuestion>.of(_questionBank);
    final seed = day.year * 10000 + day.month * 100 + day.day;
    final random = Random(seed);

    for (var index = questions.length - 1; index > 0; index--) {
      final swapIndex = random.nextInt(index + 1);
      final question = questions[index];
      questions[index] = questions[swapIndex];
      questions[swapIndex] = question;
    }

    return questions;
  }
}
