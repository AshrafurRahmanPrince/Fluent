import 'package:flutter/material.dart';

import '../../models/reading_models.dart';
import '../../services/user_progress_service.dart';

class IELTSReadingTestScreen extends StatefulWidget {
  const IELTSReadingTestScreen({required this.test, super.key});

  final IELTSReadingTest test;

  @override
  State<IELTSReadingTestScreen> createState() => _IELTSReadingTestScreenState();
}

class _IELTSReadingTestScreenState extends State<IELTSReadingTestScreen> {
  final Map<int, String> _answers = {};
  final Map<int, bool> _checked = {};
  bool _submitted = false;
  bool _isSaving = false;

  List<ReadingQuestion> get _questions => widget.test.questions;
  int get _correctCount => _checked.values.where((correct) => correct).length;
  bool get _allQuestionsChecked => _checked.length == _questions.length;

  String _normalize(String value) => value
      .toLowerCase()
      .replaceAll(RegExp(r'[^a-z0-9\s]'), ' ')
      .replaceAll(RegExp(r'\s+'), ' ')
      .trim();

  void _selectAnswer(int index, String answer) {
    setState(() {
      _answers[index] = answer;
      _checked.remove(index);
    });
  }

  void _checkAnswer(int index) {
    final response = _answers[index];
    if (response == null || response.trim().isEmpty) return;
    final expected = _questions[index].answer;
    setState(() => _checked[index] = _normalize(response) == _normalize(expected));
  }

  Future<void> _submitTest() async {
    if (!_allQuestionsChecked || _submitted || _isSaving) return;
    setState(() {
      _submitted = true;
      _isSaving = true;
    });

    try {
      await UserProgressService.instance.logDailyActivity(
        activityType: 'reading_test',
      );
    } catch (error, stackTrace) {
      debugPrint('Unable to save IELTS Reading progress: $error');
      debugPrintStack(stackTrace: stackTrace);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Your reading progress could not be saved.')),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: colors.onSurface,
        title: Text(widget.test.title),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 12, 18, 28),
          children: [
            Text(
              widget.test.category.label,
              style: TextStyle(
                color: colors.primary,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Full reading passage',
              style: TextStyle(
                color: colors.onSurface,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            _passageCard(context),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Score: $_correctCount / ${_questions.length}  ·  '
                '${_checked.length} / ${_questions.length} checked',
                style: TextStyle(
                  color: colors.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 14),
            for (var sectionIndex = 0;
                sectionIndex < widget.test.sections.length;
                sectionIndex++)
              _questionSection(context, sectionIndex),
            const SizedBox(height: 10),
            if (_submitted)
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () => Navigator.pop(context, true),
                  icon: const Icon(Icons.arrow_back_rounded),
                  label: const Text('Back to reading tests'),
                ),
              )
            else
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed:
                      _allQuestionsChecked && !_isSaving ? _submitTest : null,
                  icon: _isSaving
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.check_circle_outline_rounded),
                  label: const Text('Submit IELTS Reading Test'),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _passageCard(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.test.passage.title,
            style: TextStyle(
              color: colors.onSurface,
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          SelectableText(
            widget.test.passage.text,
            style: TextStyle(
              color: colors.onSurface,
              fontSize: 15,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _questionSection(BuildContext context, int sectionIndex) {
    final section = widget.test.sections[sectionIndex];
    final firstQuestion = widget.test.sections
        .take(sectionIndex)
        .fold<int>(0, (count, item) => count + item.questions.length);
    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: colors.surface,
        borderRadius: BorderRadius.circular(12),
        child: ExpansionTile(
          initiallyExpanded: true,
          title: Text(section.title),
          subtitle: Text('${section.questions.length} questions'),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Column(
                children: [
                  for (var offset = 0;
                      offset < section.questions.length;
                      offset++)
                    _questionCard(
                      context,
                      section.questions[offset],
                      firstQuestion + offset,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _questionCard(
    BuildContext context,
    ReadingQuestion question,
    int index,
  ) {
    final colors = Theme.of(context).colorScheme;
    final checked = _checked[index];
    final isCompletion =
        question.type == IELTSReadingQuestionType.sentenceCompletion ||
            question.type == IELTSReadingQuestionType.summaryCompletion;

    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${index + 1}. ${question.prompt}',
            style: TextStyle(
              color: colors.onSurface,
              fontWeight: FontWeight.w600,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 8),
          if (isCompletion)
            TextField(
              key: ValueKey('reading-answer-$index'),
              enabled: !_submitted,
              onChanged: (value) => setState(() {
                _answers[index] = value;
                _checked.remove(index);
              }),
              decoration: InputDecoration(
                hintText: question.type ==
                        IELTSReadingQuestionType.summaryCompletion
                    ? 'Complete the summary'
                    : 'Complete the sentence',
                filled: true,
                fillColor: colors.surfaceContainer,
              ),
            )
          else
            RadioGroup<String>(
              groupValue: _answers[index],
              onChanged: (value) {
                if (!_submitted && value != null) {
                  _selectAnswer(index, value);
                }
              },
              child: Column(
                children: [
                  for (final option in question.options)
                    RadioListTile<String>(
                      value: option,
                      enabled: !_submitted,
                      activeColor: colors.primary,
                      contentPadding: EdgeInsets.zero,
                      title: Text(option),
                    ),
                ],
              ),
            ),
          if (!_submitted)
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                key: ValueKey('check-reading-answer-$index'),
                onPressed: _answers[index] == null ||
                        _answers[index]!.trim().isEmpty
                    ? null
                    : () => _checkAnswer(index),
                child: const Text('Check answer'),
              ),
            ),
          if (checked != null) ...[
            Text(
              checked ? 'Correct' : 'Incorrect. Answer: ${question.answer}',
              style: TextStyle(
                color: checked ? colors.primary : colors.error,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              question.explanation,
              style: TextStyle(
                color: colors.onSurface.withValues(alpha: 0.75),
                height: 1.4,
              ),
            ),
          ],
        ],
      ),
    );
  }
}