import 'package:flutter/material.dart';
import 'package:fluento/data/speaking_content.dart';
import 'package:fluento/models/learning_models.dart';
import 'package:fluento/models/speaking_models.dart';

const _lessonGreen = Color(0xFF0F3822);
const _lessonCream = Color(0xFFF7F3E9);
const _lessonLeaf = Color(0xFF3E8E55);
const _lessonCharcoal = Color(0xFF1C2A23);

class SpeakingLessonScreen extends StatefulWidget {
  const SpeakingLessonScreen({required this.lesson, super.key});

  final Lesson lesson;

  @override
  State<SpeakingLessonScreen> createState() => _SpeakingLessonScreenState();
}

class _SpeakingLessonScreenState extends State<SpeakingLessonScreen> {
  final TextEditingController _practiceController = TextEditingController();
  final TextEditingController _challengeController = TextEditingController();
  String? _selectedOption;
  String? _exerciseFeedback;
  bool _exerciseChecked = false;
  bool _practiceRecorded = false;
  bool _challengeRecorded = false;
  bool _practiceRecording = false;
  bool _challengeRecording = false;
  bool _lessonCompleted = false;

  SpeakingLessonContent get _content =>
      speakingLessonContent[widget.lesson.title]!;

  int get _completedSteps =>
      (_practiceRecorded ? 1 : 0) +
      (_exerciseChecked && _selectedOption == _content.correctOption ? 1 : 0) +
      (_challengeRecorded ? 1 : 0);

  @override
  void dispose() {
    _practiceController.dispose();
    _challengeController.dispose();
    super.dispose();
  }

  Widget _panel(String title, List<Widget> children) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _lessonCream,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  color: _lessonCharcoal,
                  fontSize: 17,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }

  Widget _text(String value, {double size = 14, FontWeight? weight}) => Text(
        value,
        style: TextStyle(
            color: _lessonCharcoal,
            fontSize: size,
            fontWeight: weight,
            height: 1.45),
      );

  Widget _textField(TextEditingController controller, String hint) => TextField(
        controller: controller,
        maxLines: 4,
        onChanged: (_) => setState(() {}),
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      );

  Widget _primaryButton(String title, IconData icon, VoidCallback? onPressed) =>
      ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 18),
        label: Text(title),
        style: ElevatedButton.styleFrom(
          backgroundColor: _lessonLeaf,
          foregroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );

  void _checkExercise() {
    final correct = _selectedOption == _content.correctOption;
    setState(() {
      _exerciseChecked = true;
      _exerciseFeedback = correct
          ? 'Correct. That is a clear and natural choice.'
          : 'Not quite. Consider which sentence sounds clear and polite.';
    });
  }

  void _finishLesson() {
    setState(() => _lessonCompleted = true);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Speaking lesson completed. Well done!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final content = _content;
    final progress = _completedSteps / 3;
    final canComplete = _completedSteps == 3;

    return Scaffold(
      backgroundColor: _lessonGreen,
      appBar: AppBar(
        backgroundColor: _lessonGreen,
        foregroundColor: const Color(0xFFFDFBF7),
        elevation: 0,
        title: Text(widget.lesson.title),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _panel(widget.lesson.title, [
                Wrap(spacing: 8, runSpacing: 6, children: [
                  _infoChip(widget.lesson.level),
                  _infoChip('${widget.lesson.duration} min'),
                ]),
                const SizedBox(height: 14),
                _text(widget.lesson.summary ?? '', size: 15),
                const SizedBox(height: 14),
                _text('Lesson progress: $_completedSteps of 3 steps',
                    weight: FontWeight.w600),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 9,
                    backgroundColor: _lessonGreen.withValues(alpha: 0.12),
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(_lessonLeaf),
                  ),
                ),
              ]),
              _panel('Learning objectives', [
                ...content.objectives.map((objective) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.check_circle_rounded,
                              color: _lessonLeaf, size: 19),
                          const SizedBox(width: 8),
                          Expanded(child: _text(objective)),
                        ],
                      ),
                    )),
              ]),
              _panel('Vocabulary', [
                Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  children: content.vocabulary
                      .map((word) => Chip(
                            label: Text(word),
                            backgroundColor:
                                _lessonLeaf.withValues(alpha: 0.12),
                            labelStyle: const TextStyle(color: _lessonGreen),
                            side: BorderSide.none,
                          ))
                      .toList(),
                ),
              ]),
              _panel('Useful phrases', [
                ...content.usefulPhrases.map((phrase) => Padding(
                      padding: const EdgeInsets.only(bottom: 7),
                      child: _text('“$phrase”'),
                    )),
              ]),
              _panel('Example conversation', [
                ...content.conversation.map((turn) => Padding(
                      padding: const EdgeInsets.only(bottom: 9),
                      child: _text('${turn.speaker}:  “${turn.line}”'),
                    )),
              ]),
              _panel('Speaking practice', [
                _text(content.practicePrompt),
                const SizedBox(height: 10),
                _text(
                    'Say your response aloud, then finish the simulated recording.',
                    size: 12),
                _textField(_practiceController, 'Prepare your own response...'),
                const SizedBox(height: 8),
                _primaryButton(
                  _practiceRecorded
                      ? 'Practice recorded'
                      : _practiceRecording
                          ? 'Finish practice'
                          : 'Start speaking practice',
                  _practiceRecorded ? Icons.check_rounded : Icons.mic_rounded,
                  _practiceRecorded
                      ? null
                      : () => setState(() {
                            if (_practiceRecording) {
                              _practiceRecording = false;
                              _practiceRecorded = true;
                            } else {
                              _practiceRecording = true;
                            }
                          }),
                ),
                if (_practiceRecorded)
                  _text('Good work. Your speaking practice is complete.'),
              ]),
              _panel('Interactive exercise', [
                _text(content.exerciseQuestion, weight: FontWeight.w600),
                RadioGroup<String>(
                  groupValue: _selectedOption,
                  onChanged: (value) => setState(() {
                    _selectedOption = value;
                    _exerciseChecked = false;
                    _exerciseFeedback = null;
                  }),
                  child: Material(
                    color: _lessonCream,
                    child: Column(
                      children: content.exerciseOptions
                          .map((option) => RadioListTile<String>(
                                value: option,
                                activeColor: _lessonLeaf,
                                contentPadding: EdgeInsets.zero,
                                title: _text(option),
                              ))
                          .toList(),
                    ),
                  ),
                ),
                _primaryButton('Check answer', Icons.fact_check_rounded,
                    _selectedOption == null ? null : _checkExercise),
                if (_exerciseFeedback != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: _text(_exerciseFeedback!, weight: FontWeight.w600),
                  ),
              ]),
              _panel('Final challenge', [
                _text(content.finalChallenge),
                const SizedBox(height: 10),
                _text(
                    'Speak your answer aloud, then finish the simulated recording.',
                    size: 12),
                _textField(_challengeController, 'Plan your final response...'),
                const SizedBox(height: 8),
                _primaryButton(
                  _challengeRecorded
                      ? 'Challenge complete'
                      : _challengeRecording
                          ? 'Finish challenge'
                          : 'Start final challenge',
                  _challengeRecorded ? Icons.check_rounded : Icons.mic_rounded,
                  _challengeRecorded
                      ? null
                      : () => setState(() {
                            if (_challengeRecording) {
                              _challengeRecording = false;
                              _challengeRecorded = true;
                            } else {
                              _challengeRecording = true;
                            }
                          }),
                ),
              ]),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _lessonCompleted
                      ? () => Navigator.pop(context, true)
                      : canComplete
                          ? _finishLesson
                          : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _lessonLeaf,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                  ),
                  child: Text(_lessonCompleted
                      ? 'Continue'
                      : canComplete
                          ? 'Complete lesson'
                          : 'Complete the practice steps to finish'),
                ),
              ),
              if (_lessonCompleted) ...[
                const SizedBox(height: 12),
                _panel('Lesson complete', [
                  _text('Excellent work. Your progress has been updated.',
                      weight: FontWeight.w600),
                ]),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoChip(String label) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: _lessonLeaf.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(label,
            style: const TextStyle(
                color: _lessonGreen,
                fontSize: 12,
                fontWeight: FontWeight.w600)),
      );
}
