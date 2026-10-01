import 'dart:async';

import 'package:flutter/material.dart';

import '../models/quiz_question.dart';
import '../services/daily_quiz_service.dart';
import '../services/user_progress_service.dart';

class DailyQuizScreen extends StatefulWidget {
  const DailyQuizScreen({super.key});

  @override
  State<DailyQuizScreen> createState() => _DailyQuizScreenState();
}

class _DailyQuizScreenState extends State<DailyQuizScreen>
    with WidgetsBindingObserver {
  final DailyQuizService _quizService = DailyQuizService();

  late DateTime _quizDate;
  late List<QuizQuestion> _questions;
  Timer? _midnightTimer;
  int _questionIndex = 0;
  int _score = 0;
  int? _selectedIndex;
  bool _isCompletingQuiz = false;

  QuizQuestion get _currentQuestion => _questions[_questionIndex];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadQuestions(DateTime.now());
    _scheduleMidnightRefresh();
  }

  void _loadQuestions(DateTime date) {
    _quizDate = DateTime(date.year, date.month, date.day);
    _questions = _quizService.questionsForDate(date);
    _questionIndex = 0;
    _score = 0;
    _selectedIndex = null;
  }

  void _scheduleMidnightRefresh() {
    _midnightTimer?.cancel();
    final now = DateTime.now();
    final nextMidnight = DateTime(now.year, now.month, now.day + 1);
    _midnightTimer = Timer(nextMidnight.difference(now), _refreshForToday);
  }

  void _refreshForToday() {
    if (!mounted) return;

    final now = DateTime.now();
    if (!_isSameDay(now, _quizDate)) {
      setState(() => _loadQuestions(now));
    }
    _scheduleMidnightRefresh();
  }

  bool _isSameDay(DateTime first, DateTime second) =>
      first.year == second.year &&
      first.month == second.month &&
      first.day == second.day;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) _refreshForToday();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _midnightTimer?.cancel();
    super.dispose();
  }

  void _selectAnswer(int index) {
    if (_selectedIndex != null) return;
    setState(() => _selectedIndex = index);
  }

  Future<void> _nextQuestion() async {
    final isCorrect = _selectedIndex == _currentQuestion.correctAnswerIndex;
    if (_questionIndex == _questions.length - 1) {
      if (_isCompletingQuiz) return;
      setState(() => _isCompletingQuiz = true);
      final finalScore = _score + (isCorrect ? 1 : 0);
      await UserProgressService.instance.logQuizResult(
        score: finalScore,
        total: _questions.length,
      );
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => QuizCompletionScreen(
            score: finalScore,
            total: _questions.length,
          ),
        ),
      );
      return;
    }

    setState(() {
      _score += isCorrect ? 1 : 0;
      _questionIndex++;
      _selectedIndex = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final questionNumber = _questionIndex + 1;
    final answeredCount = _questionIndex + (_selectedIndex == null ? 0 : 1);
    final displayedScore = _score +
        (_selectedIndex == _currentQuestion.correctAnswerIndex ? 1 : 0);
    final progress = answeredCount / _questions.length;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: colors.onSurface,
        elevation: 0,
        title: const Text('IELTS Daily Challenge'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Today's IELTS Challenge",
                style: TextStyle(
                  color: colors.onSurface,
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '$displayedScore correct',
                    style: TextStyle(
                        color: colors.onSurface.withValues(alpha: 0.8)),
                  ),
                  Text(
                    '$answeredCount/${_questions.length} answered',
                    style: TextStyle(
                        color: colors.onSurface.withValues(alpha: 0.8)),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Question $questionNumber of ${_questions.length}',
                    style: TextStyle(
                      color: colors.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${(progress * 100).round()}%',
                    style: TextStyle(
                        color: colors.onSurface.withValues(alpha: 0.75)),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 8,
                  backgroundColor: colors.onSurface.withValues(alpha: 0.18),
                  valueColor: AlwaysStoppedAnimation(colors.primary),
                ),
              ),
              const SizedBox(height: 26),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: colors.surface,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _currentQuestion.category.label.toUpperCase(),
                      style: TextStyle(
                        color: colors.primary,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _currentQuestion.prompt,
                      style: TextStyle(
                        color: colors.onSurface,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              ...List<Widget>.generate(
                _currentQuestion.options.length,
                (index) => _buildOption(index, _currentQuestion.options[index]),
              ),
              if (_selectedIndex != null) ...[
                const SizedBox(height: 2),
                _buildExplanation(),
              ],
              const SizedBox(height: 14),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _selectedIndex == null || _isCompletingQuiz
                      ? null
                      : _nextQuestion,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.primary,
                    foregroundColor: colors.onPrimary,
                    disabledBackgroundColor:
                        colors.onSurface.withValues(alpha: 0.2),
                    disabledForegroundColor:
                        colors.onSurface.withValues(alpha: 0.5),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    questionNumber == _questions.length
                        ? 'Finish Quiz'
                        : 'Next',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOption(int index, String option) {
    final colors = Theme.of(context).colorScheme;
    final isSelected = _selectedIndex == index;
    final isCorrect = index == _currentQuestion.correctAnswerIndex;
    final hasAnswered = _selectedIndex != null;
    final showCorrect = hasAnswered && isCorrect;
    final showIncorrect = hasAnswered && isSelected && !isCorrect;
    final resultColor = showCorrect ? colors.primary : colors.error;
    final backgroundColor = showCorrect || showIncorrect
        ? resultColor.withValues(alpha: 0.2)
        : colors.surfaceContainer;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: OutlinedButton(
        onPressed: hasAnswered ? null : () => _selectAnswer(index),
        style: OutlinedButton.styleFrom(
          alignment: Alignment.centerLeft,
          backgroundColor: backgroundColor,
          foregroundColor: colors.onSurface,
          side: BorderSide(
            color: showCorrect || showIncorrect
                ? resultColor
                : colors.onSurface.withValues(alpha: 0.3),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Row(
          children: [
            Expanded(child: Text(option)),
            if (showCorrect)
              Icon(Icons.check_circle_outline, color: colors.primary),
            if (showIncorrect) Icon(Icons.cancel_outlined, color: colors.error),
          ],
        ),
      ),
    );
  }

  Widget _buildExplanation() {
    final colors = Theme.of(context).colorScheme;
    final isCorrect = _selectedIndex == _currentQuestion.correctAnswerIndex;
    final correctAnswer =
        _currentQuestion.options[_currentQuestion.correctAnswerIndex];

    final resultColor = isCorrect ? colors.primary : colors.error;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: resultColor.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: resultColor.withValues(alpha: 0.65),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isCorrect ? 'Correct' : 'Not quite. The answer is: $correctAnswer',
            style: TextStyle(
              color: resultColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            _currentQuestion.explanation,
            style: TextStyle(color: colors.onSurface, height: 1.4),
          ),
        ],
      ),
    );
  }
}

class QuizCompletionScreen extends StatelessWidget {
  const QuizCompletionScreen({
    required this.score,
    required this.total,
    super.key,
  });

  final int score;
  final int total;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.emoji_events_rounded,
                    color: colors.primary, size: 64),
                const SizedBox(height: 20),
                Text(
                  'Quiz Complete',
                  style: TextStyle(
                      color: colors.onSurface,
                      fontSize: 26,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Text(
                  '$score / $total Correct',
                  style: TextStyle(color: colors.onSurface, fontSize: 22),
                ),
                const SizedBox(height: 10),
                Text('Great job! 🎉',
                    style: TextStyle(color: colors.onSurface, fontSize: 16)),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors.primary,
                      foregroundColor: colors.onPrimary,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                    ),
                    child: const Text('Back to Dashboard'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
