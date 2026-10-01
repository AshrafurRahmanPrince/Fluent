import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../data/ielts_listening_tests.dart';
import '../../models/listening_models.dart';
import '../../services/user_progress_service.dart';

class ListeningScreen extends StatefulWidget {
  const ListeningScreen({super.key});

  @override
  State<ListeningScreen> createState() => _ListeningScreenState();
}

class _ListeningScreenState extends State<ListeningScreen> {
  final FlutterTts _tts = FlutterTts();
  final Map<int, String> _answers = {};
  final IELTSListeningTest _test = ieltsListeningTests.first;
  int? _playingSection;
  int? _score;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _tts.stop();
    super.dispose();
  }

  Future<void> _playSection(int index, String script) async {
    setState(() => _playingSection = index);
    try {
      await _tts.setLanguage('en-US');
      await _tts.setSpeechRate(0.45);
      await _tts.stop();
      await _tts.speak(script);
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Audio playback is unavailable: $error')),
        );
      }
    } finally {
      if (mounted) setState(() => _playingSection = null);
    }
  }

  String _normalize(String value) => value
      .toLowerCase()
      .replaceAll(RegExp(r"[^a-z0-9\s]"), ' ')
      .replaceAll(RegExp(r'\s+'), ' ')
      .trim();

  Future<void> _submitTest() async {
    if (_score != null || _isSubmitting) return;
    final questions = _test.questions;
    final score = questions.indexed.where((entry) {
      final response = _normalize(_answers[entry.$1] ?? '');
      return entry.$2.allAcceptedAnswers
          .any((answer) => _normalize(answer) == response);
    }).length;
    setState(() {
      _score = score;
      _isSubmitting = true;
    });

    try {
      await UserProgressService.instance.logQuizResult(
        score: score,
        total: questions.length,
        activityType: 'listening_quiz',
      );
    } catch (error, stackTrace) {
      debugPrint('Unable to save IELTS Listening score: $error');
      debugPrintStack(stackTrace: stackTrace);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Your score could not be saved.')),
        );
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
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
        title: const Text('IELTS Listening'),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
          children: [
            Text(_test.title,
                style: TextStyle(
                    color: colors.onSurface,
                    fontSize: 22,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(
              'Complete each section while listening. Answers are checked when you submit.',
              style: TextStyle(color: colors.onSurface.withValues(alpha: 0.72)),
            ),
            if (_score != null) ...[
              const SizedBox(height: 16),
              _scoreBanner(context, _score!),
            ],
            const SizedBox(height: 18),
            for (final entry in _test.sections.indexed) ...[
              _sectionCard(context, entry.$2, entry.$1),
              const SizedBox(height: 14),
            ],
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _score != null || _isSubmitting ? null : _submitTest,
                icon: _isSubmitting
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.check_circle_outline_rounded),
                label: Text(_score == null ? 'Submit listening test' : 'Test submitted'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionCard(
      BuildContext context, IELTSListeningSection section, int sectionIndex) {
    final colors = Theme.of(context).colorScheme;
    final offset = _test.sections
        .take(sectionIndex)
        .fold<int>(0, (count, prior) => count + prior.questions.length);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(section.title,
              style: TextStyle(
                  color: colors.onSurface,
                  fontSize: 17,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          OutlinedButton.icon(
            onPressed: () => _playSection(sectionIndex, section.audioScript),
            icon: Icon(
                _playingSection == sectionIndex ? Icons.stop : Icons.volume_up),
            label: Text(_playingSection == sectionIndex
                ? 'Playing script...'
                : 'Play audio script'),
          ),
          ExpansionTile(
            tilePadding: EdgeInsets.zero,
            title: const Text('Audio script'),
            subtitle: const Text('Expand to review the transcript'),
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(section.audioScript,
                      style: TextStyle(
                          color: colors.onSurface.withValues(alpha: 0.82),
                          height: 1.5)),
                ),
              ),
            ],
          ),
          for (var index = 0; index < section.questions.length; index++)
            _questionField(context, section.questions[index], offset + index),
        ],
      ),
    );
  }

  Widget _questionField(
      BuildContext context, IELTSListeningQuestion question, int index) {
    final colors = Theme.of(context).colorScheme;
    final correct = _score != null &&
        question.allAcceptedAnswers.any(
          (answer) => _normalize(answer) == _normalize(_answers[index] ?? ''),
        );
    return Padding(
      padding: const EdgeInsets.only(top: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${index + 1}. ${question.prompt}',
              style: TextStyle(
                  color: colors.onSurface, fontWeight: FontWeight.w600)),
          const SizedBox(height: 7),
          TextField(
            enabled: _score == null,
            onChanged: (value) => setState(() => _answers[index] = value),
            decoration: InputDecoration(
              hintText: 'Your answer',
              filled: true,
              fillColor: colors.surfaceContainer,
              suffixIcon: _score == null
                  ? null
                  : Icon(correct ? Icons.check_circle : Icons.cancel,
                      color: correct ? colors.primary : colors.error),
            ),
          ),
          if (_score != null) ...[
            const SizedBox(height: 4),
            Text(
              correct
                  ? question.explanation
                  : 'Answer: ${question.answer}. ${question.explanation}',
              style: TextStyle(
                  color: colors.onSurface.withValues(alpha: 0.72), fontSize: 12),
            ),
          ],
        ],
      ),
    );
  }

  Widget _scoreBanner(BuildContext context, int score) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colors.primary.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        'Listening score: $score / ${_test.questions.length}',
        style: TextStyle(color: colors.onSurface, fontWeight: FontWeight.bold),
      ),
    );
  }
}
