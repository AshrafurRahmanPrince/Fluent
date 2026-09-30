import 'package:flutter/material.dart';

const Color _quizGreen = Color(0xFF1C3A27);
const Color _quizCream = Color(0xFFF5F2EB);
const Color _quizAccent = Color(0xFF3E8E55);
const Color _quizError = Color(0xFFB85C5C);

class _QuizQuestion {
  const _QuizQuestion({
    required this.question,
    required this.options,
    required this.correctIndex,
  });

  final String question;
  final List<String> options;
  final int correctIndex;
}

const List<_QuizQuestion> _questions = [
  _QuizQuestion(
    question: 'What does “rapid” mean?',
    options: ['Slow', 'Quick', 'Quiet', 'Careful'],
    correctIndex: 1,
  ),
  _QuizQuestion(
    question: 'Choose the grammatically correct sentence.',
    options: [
      'She go to class.',
      'She going to class.',
      'She goes to class.',
      'She gone to class.',
    ],
    correctIndex: 2,
  ),
  _QuizQuestion(
    question: 'Which word is the opposite of “ancient”?',
    options: ['Modern', 'Historic', 'Old', 'Traditional'],
    correctIndex: 0,
  ),
  _QuizQuestion(
    question: 'Complete the sentence: I have lived here ___ 2022.',
    options: ['for', 'since', 'during', 'at'],
    correctIndex: 1,
  ),
  _QuizQuestion(
    question: 'What is the plural of “child”?',
    options: ['Childs', 'Childes', 'Childrens', 'Children'],
    correctIndex: 3,
  ),
];

class DailyQuizScreen extends StatefulWidget {
  const DailyQuizScreen({super.key});

  @override
  State<DailyQuizScreen> createState() => _DailyQuizScreenState();
}

class _DailyQuizScreenState extends State<DailyQuizScreen> {
  int _questionIndex = 0;
  int _score = 0;
  int? _selectedIndex;

  _QuizQuestion get _currentQuestion => _questions[_questionIndex];

  void _selectAnswer(int index) {
    if (_selectedIndex != null) return;
    setState(() => _selectedIndex = index);
  }

  void _nextQuestion() {
    final isCorrect = _selectedIndex == _currentQuestion.correctIndex;
    if (_questionIndex == _questions.length - 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => QuizCompletionScreen(
            score: _score + (isCorrect ? 1 : 0),
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
    final questionNumber = _questionIndex + 1;
    final progress = questionNumber / _questions.length;

    return Scaffold(
      backgroundColor: _quizGreen,
      appBar: AppBar(
        backgroundColor: _quizGreen,
        foregroundColor: _quizCream,
        elevation: 0,
        title: const Text('Daily Quiz'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Question $questionNumber of ${_questions.length}',
                    style: const TextStyle(
                      color: _quizCream,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${(progress * 100).round()}%',
                    style: TextStyle(color: _quizCream.withValues(alpha: 0.75)),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 8,
                  backgroundColor: _quizCream.withValues(alpha: 0.18),
                  valueColor: const AlwaysStoppedAnimation(_quizAccent),
                ),
              ),
              const SizedBox(height: 26),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: _quizCream,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  _currentQuestion.question,
                  style: const TextStyle(
                    color: _quizGreen,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    height: 1.3,
                  ),
                ),
              ),
              const SizedBox(height: 18),
              ...List<Widget>.generate(
                _currentQuestion.options.length,
                (index) => _buildOption(index, _currentQuestion.options[index]),
              ),
              const SizedBox(height: 14),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _selectedIndex == null ? null : _nextQuestion,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _quizAccent,
                    foregroundColor: _quizCream,
                    disabledBackgroundColor: _quizCream.withValues(alpha: 0.2),
                    disabledForegroundColor: _quizCream.withValues(alpha: 0.5),
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
    final isSelected = _selectedIndex == index;
    final isCorrect = index == _currentQuestion.correctIndex;
    final showResult = _selectedIndex != null && isSelected;
    final color = showResult
        ? (isCorrect ? _quizAccent : _quizError)
        : _quizCream.withValues(alpha: 0.1);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: OutlinedButton(
        onPressed: () => _selectAnswer(index),
        style: OutlinedButton.styleFrom(
          alignment: Alignment.centerLeft,
          backgroundColor: showResult ? color.withValues(alpha: 0.2) : color,
          foregroundColor: _quizCream,
          side: BorderSide(
            color: showResult ? color : _quizCream.withValues(alpha: 0.3),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(option),
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
    return Scaffold(
      backgroundColor: _quizGreen,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.emoji_events_rounded,
                    color: _quizAccent, size: 64),
                const SizedBox(height: 20),
                const Text(
                  'Quiz Complete',
                  style: TextStyle(
                      color: _quizCream,
                      fontSize: 26,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Text(
                  '$score / $total Correct',
                  style: const TextStyle(color: _quizCream, fontSize: 22),
                ),
                const SizedBox(height: 10),
                const Text('Great job! 🎉',
                    style: TextStyle(color: _quizCream, fontSize: 16)),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _quizAccent,
                      foregroundColor: _quizCream,
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
