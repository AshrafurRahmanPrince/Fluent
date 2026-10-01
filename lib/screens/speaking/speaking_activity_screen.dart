import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:fluento/data/speaking_content.dart';
import 'package:fluento/models/speaking_models.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/user_progress_service.dart';

class SpeakingActivityScreen extends StatefulWidget {
  const SpeakingActivityScreen({required this.featureTitle, super.key});

  final String featureTitle;

  @override
  State<SpeakingActivityScreen> createState() => _SpeakingActivityScreenState();
}

class _SpeakingActivityScreenState extends State<SpeakingActivityScreen> {
  static const _completedKey = 'speaking_completed_activities';
  static const _favoritesKey = 'speaking_favorite_phrases';

  final FlutterTts _tts = FlutterTts();
  final Set<String> _favoritePhrases = {};
  Timer? _timer;
  String _level = 'Beginner';
  String _phraseCategory = 'Greetings';
  String? _feedback;
  String? _selectedResponse;
  int _index = 0;
  int _secondsRemaining = 60;
  bool _recording = false;
  bool _activityComplete = false;
  bool _activityCompleting = false;
  bool _showSampleAnswer = false;

  Color get _green => Theme.of(context).scaffoldBackgroundColor;
  Color get _cream => Theme.of(context).colorScheme.surface;
  Color get _leaf => Theme.of(context).colorScheme.primary;
  Color get _charcoal => Theme.of(context).colorScheme.onSurface;

  List<PronunciationWord> get _words =>
      pronunciationWords.where((item) => item.level == _level).toList();
  List<RepeatSentence> get _sentences =>
      repeatSentences.where((item) => item.level == _level).toList();
  List<SpeakingTopic> get _topics =>
      speakingTopics.where((item) => item.level == _level).toList();
  List<SpeakingQuestion> get _questions =>
      speakingQuestions.where((item) => item.level == _level).toList();
  List<CommonPhrase> get _phrases =>
      commonPhrases.where((item) => item.category == _phraseCategory).toList();

  @override
  void initState() {
    super.initState();
    _loadFavorites();
    _tts.setLanguage('en-US');
    _tts.setSpeechRate(0.46);
    _tts.awaitSpeakCompletion(true);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _tts.stop();
    super.dispose();
  }

  Future<void> _loadFavorites() async {
    final preferences = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      _favoritePhrases.addAll(
        preferences.getStringList(_favoritesKey) ?? const [],
      );
    });
  }

  Future<void> _speak(String text) async {
    try {
      await _tts.stop();
      await _tts.speak(text);
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Audio is not available on this device.')),
      );
    }
  }

  Future<void> _completeActivity() async {
    if (_activityComplete || _activityCompleting) return;
    _activityCompleting = true;
    try {
      final preferences = await SharedPreferences.getInstance();
      final completed = preferences.getStringList(_completedKey)?.toSet() ?? {};
      completed.add(widget.featureTitle);
      await preferences.setStringList(_completedKey, completed.toList());
      await UserProgressService.instance.logDailyActivity(
        activityType: 'speaking_activity',
      );
      if (!mounted) return;
      setState(() => _activityComplete = true);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Speaking activity completed. Well done!')),
      );
    } finally {
      _activityCompleting = false;
    }
  }

  void _startTimer(int seconds, {bool completeWhenFinished = false}) {
    _timer?.cancel();
    setState(() => _secondsRemaining = seconds);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      if (_secondsRemaining <= 1) {
        timer.cancel();
        setState(() => _secondsRemaining = 0);
        if (completeWhenFinished) _completeActivity();
      } else {
        setState(() => _secondsRemaining--);
      }
    });
  }

  void _next(int itemCount) {
    if (_index + 1 >= itemCount) {
      _completeActivity();
      return;
    }
    setState(() {
      _index++;
      _feedback = null;
      _selectedResponse = null;
      _recording = false;
      _showSampleAnswer = false;
    });
  }

  Future<void> _toggleFavorite(CommonPhrase phrase) async {
    setState(() {
      if (!_favoritePhrases.add(phrase.phrase)) {
        _favoritePhrases.remove(phrase.phrase);
      }
    });
    final preferences = await SharedPreferences.getInstance();
    await preferences.setStringList(_favoritesKey, _favoritePhrases.toList());
  }

  void _changeLevel(String? value) {
    if (value == null) return;
    setState(() {
      _level = value;
      _index = 0;
      _feedback = null;
      _selectedResponse = null;
    });
  }

  Widget _panel(String title, List<Widget> children) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _cream,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                  color: _charcoal, fontSize: 17, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }

  Widget _bodyText(String text, {double size = 14, FontWeight? weight}) {
    return Text(text,
        style: TextStyle(
            color: _charcoal,
            fontSize: size,
            fontWeight: weight,
            height: 1.45));
  }

  Widget _levelPicker() {
    return DropdownButtonFormField<String>(
      initialValue: _level,
      isExpanded: true,
      decoration: InputDecoration(
        labelText: 'Difficulty',
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      items: const ['Beginner', 'Intermediate', 'Advanced']
          .map((level) => DropdownMenuItem(value: level, child: Text(level)))
          .toList(),
      onChanged: _changeLevel,
    );
  }

  Widget _action(String label, IconData icon, VoidCallback? onPressed,
      {bool secondary = false}) {
    final child = Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 7,
      children: [
        Icon(icon, size: 18),
        Text(label, softWrap: true, textAlign: TextAlign.center),
      ],
    );
    if (secondary) {
      return OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: Theme.of(context).colorScheme.onSurface,
          side: BorderSide(color: _leaf),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: child,
      );
    }
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: _leaf,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: child,
    );
  }

  Widget _progress(int current, int total) {
    final value = total == 0 ? 0.0 : current / total;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _bodyText('$current of $total', size: 12),
      const SizedBox(height: 6),
      ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: LinearProgressIndicator(
          value: value,
          minHeight: 8,
          backgroundColor: _green.withValues(alpha: 0.12),
          valueColor: AlwaysStoppedAnimation(_leaf),
        ),
      ),
    ]);
  }

  Widget _recordControl() {
    return _action(
      _recording ? 'Finish speaking' : 'Record / Speak',
      _recording ? Icons.stop_circle_rounded : Icons.mic_rounded,
      () => setState(() {
        _recording = !_recording;
        if (!_recording) {
          _feedback =
              'Practice recorded. Review your attempt and try again if needed.';
        }
      }),
      secondary: _recording,
    );
  }

  Widget _buildPronunciation() {
    final words = _words;
    final item = words[_index.clamp(0, words.length - 1)];
    return Column(children: [
      _panel('Practice level', [_levelPicker()]),
      _panel('Word ${_index + 1}', [
        Center(child: _bodyText(item.word, size: 30, weight: FontWeight.bold)),
        const SizedBox(height: 4),
        Center(
            child: _bodyText(item.phonetic, size: 16, weight: FontWeight.w600)),
        const SizedBox(height: 12),
        _bodyText('Meaning: ${item.meaning}'),
        const SizedBox(height: 8),
        _bodyText('Example: “${item.example}”'),
        const SizedBox(height: 12),
        _bodyText('Difficulty: ${item.level}',
            size: 12, weight: FontWeight.w600),
        const SizedBox(height: 12),
        _progress(_index + 1, words.length),
        const SizedBox(height: 12),
        Wrap(spacing: 8, runSpacing: 6, children: [
          _action('Listen', Icons.volume_up_rounded, () => _speak(item.word)),
          _recordControl(),
        ]),
        if (_feedback != null) ...[
          const SizedBox(height: 10),
          _bodyText(_feedback!, weight: FontWeight.w600),
        ],
      ]),
      _panel('Check your attempt', [
        Wrap(spacing: 8, runSpacing: 6, children: [
          _action(
              'Correct pronunciation',
              Icons.check_circle_rounded,
              () => setState(() =>
                  _feedback = 'Great work. Your pronunciation felt clear.'),
              secondary: true),
          _action(
              'Needs practice',
              Icons.replay_rounded,
              () => setState(() => _feedback =
                  'Keep practicing the syllable stress, then try again.'),
              secondary: true),
          _action(
              'Try Again',
              Icons.refresh_rounded,
              () => setState(() {
                    _feedback = null;
                    _recording = false;
                  })),
        ]),
      ]),
      _action(
          'Next word', Icons.arrow_forward_rounded, () => _next(words.length)),
    ]);
  }

  Widget _buildRepeat() {
    final items = _sentences;
    final item = items[_index.clamp(0, items.length - 1)];
    return Column(children: [
      _panel('Practice level', [_levelPicker()]),
      _panel('Repeat after me', [
        _progress(_index + 1, items.length),
        const SizedBox(height: 20),
        Center(
            child: _bodyText('“${item.sentence}”',
                size: 22, weight: FontWeight.bold)),
        const SizedBox(height: 18),
        Wrap(spacing: 8, runSpacing: 6, children: [
          _action('Play audio', Icons.volume_up_rounded,
              () => _speak(item.sentence)),
          _recordControl(),
          _action('Repeat', Icons.replay_rounded, () => _speak(item.sentence),
              secondary: true),
        ]),
        if (_feedback != null) ...[
          const SizedBox(height: 10),
          _bodyText(_feedback!)
        ],
      ]),
      _action('Next sentence', Icons.arrow_forward_rounded,
          () => _next(items.length)),
    ]);
  }

  Future<void> _playConversation(List<DialogueTurn> turns) async {
    for (final turn in turns) {
      if (!mounted) return;
      await _speak('${turn.speaker}: ${turn.line}');
    }
  }

  Widget _buildConversation() {
    final item = conversationScenarios[_index];
    return Column(children: [
      _panel('Situation ${_index + 1} of ${conversationScenarios.length}', [
        _bodyText(item.title, size: 21, weight: FontWeight.bold),
        const SizedBox(height: 12),
        ...item.turns.map((turn) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _bodyText('${turn.speaker}:  “${turn.line}”'),
            )),
        Wrap(spacing: 8, children: [
          _action('Play conversation', Icons.volume_up_rounded,
              () => _playConversation(item.turns)),
          _action('Practice dialogue', Icons.mic_rounded,
              () => setState(() => _recording = !_recording),
              secondary: true),
        ]),
        if (_recording) ...[
          const SizedBox(height: 8),
          _bodyText(
              'Your turn: say your lines aloud, then choose a response below.'),
        ],
      ]),
      _panel('Choose your response', [
        _bodyText(item.prompt, size: 15, weight: FontWeight.w600),
        const SizedBox(height: 8),
        RadioGroup<String>(
          groupValue: _selectedResponse,
          onChanged: (value) => setState(() {
            _selectedResponse = value;
            _feedback = value == item.correctResponse
                ? 'That is a natural response for this situation.'
                : 'Try a response that fits the question more closely.';
          }),
          child: Material(
            color: _cream,
            child: Column(
              children: item.responses
                  .map((response) => RadioListTile<String>(
                        value: response,
                        activeColor: _leaf,
                        contentPadding: EdgeInsets.zero,
                        title: _bodyText(response),
                      ))
                  .toList(),
            ),
          ),
        ),
        if (_feedback != null) _bodyText(_feedback!, weight: FontWeight.w600),
      ]),
      _action(
          'Next situation',
          Icons.arrow_forward_rounded,
          _selectedResponse != item.correctResponse
              ? null
              : () => _next(conversationScenarios.length)),
    ]);
  }

  Widget _buildTopic() {
    final topics = _topics;
    final topic = topics[_index.clamp(0, topics.length - 1)];
    return Column(children: [
      _panel('Choose a difficulty', [_levelPicker()]),
      _panel('Topic ${_index + 1} of ${topics.length}', [
        _bodyText(topic.title, size: 22, weight: FontWeight.bold),
        const SizedBox(height: 6),
        _bodyText('Difficulty: ${topic.level}',
            size: 12, weight: FontWeight.w600),
        const SizedBox(height: 14),
        _bodyText('Useful vocabulary', weight: FontWeight.bold),
        const SizedBox(height: 6),
        Wrap(
            spacing: 8,
            runSpacing: 6,
            children: topic.vocabulary.map(_wordChip).toList()),
        const SizedBox(height: 14),
        _bodyText('Sentence starters', weight: FontWeight.bold),
        ...topic.starters.map((line) => Padding(
            padding: const EdgeInsets.only(top: 5),
            child: _bodyText('“$line”'))),
        const SizedBox(height: 14),
        _bodyText('Guiding questions', weight: FontWeight.bold),
        ...topic.questions.asMap().entries.map((entry) => Padding(
            padding: const EdgeInsets.only(top: 5),
            child: _bodyText('${entry.key + 1}. ${entry.value}'))),
      ]),
      _panel('60-second speaking challenge', [
        Center(
            child: _bodyText(
                '00:${_secondsRemaining.toString().padLeft(2, '0')}',
                size: 30,
                weight: FontWeight.bold)),
        const SizedBox(height: 8),
        Wrap(spacing: 8, children: [
          _action('Start 60 seconds', Icons.timer_rounded,
              () => _startTimer(60, completeWhenFinished: true)),
          _recordControl(),
          _action('Stop', Icons.stop_rounded, () => _timer?.cancel(),
              secondary: true),
        ]),
        if (_feedback != null) ...[
          const SizedBox(height: 8),
          _bodyText(_feedback!)
        ],
      ]),
      _action('Next topic', Icons.arrow_forward_rounded,
          () => _next(topics.length)),
    ]);
  }

  Widget _buildQuestionAnswer() {
    final items = _questions;
    final item = items[_index.clamp(0, items.length - 1)];
    return Column(children: [
      _panel('Question level', [_levelPicker()]),
      _panel('Question ${_index + 1} of ${items.length}', [
        _progress(_index + 1, items.length),
        const SizedBox(height: 16),
        _bodyText(item.question, size: 22, weight: FontWeight.bold),
        const SizedBox(height: 12),
        _bodyText('Think time: ${_secondsRemaining}s', weight: FontWeight.w600),
        Wrap(spacing: 8, children: [
          _action(
              'Start think timer', Icons.timer_rounded, () => _startTimer(15)),
          _recordControl(),
        ]),
        const SizedBox(height: 12),
        _bodyText('Suggested vocabulary', weight: FontWeight.bold),
        const SizedBox(height: 6),
        Wrap(
            spacing: 8,
            runSpacing: 6,
            children: item.vocabulary.map(_wordChip).toList()),
      ]),
      _panel('Sample answer', [
        _bodyText('Try to answer naturally in your own words first.'),
        TextButton.icon(
          onPressed: () =>
              setState(() => _showSampleAnswer = !_showSampleAnswer),
          icon: Icon(_showSampleAnswer
              ? Icons.visibility_off_rounded
              : Icons.visibility_rounded),
          label: Text(
              _showSampleAnswer ? 'Hide sample answer' : 'Show sample answer'),
          style: TextButton.styleFrom(foregroundColor: _leaf),
        ),
        if (_showSampleAnswer) _bodyText(item.sampleAnswer),
      ]),
      _action('Next question', Icons.arrow_forward_rounded,
          () => _next(items.length)),
    ]);
  }

  Widget _buildPhrases() {
    final categories =
        commonPhrases.map((item) => item.category).toSet().toList();
    final items = _phrases;
    final phrase = items[_index.clamp(0, items.length - 1)];
    final isFavorite = _favoritePhrases.contains(phrase.phrase);
    return Column(children: [
      _panel('Phrase category', [
        DropdownButtonFormField<String>(
          initialValue: _phraseCategory,
          isExpanded: true,
          decoration: InputDecoration(
            filled: true,
            fillColor: Theme.of(context).colorScheme.surface,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
          items: categories
              .map((category) =>
                  DropdownMenuItem(value: category, child: Text(category)))
              .toList(),
          onChanged: (value) => setState(() {
            _phraseCategory = value ?? categories.first;
            _index = 0;
          }),
        ),
      ]),
      _panel('Phrase ${_index + 1} of ${items.length}', [
        _bodyText(phrase.phrase, size: 22, weight: FontWeight.bold),
        const SizedBox(height: 10),
        _bodyText('Meaning: ${phrase.meaning}'),
        const SizedBox(height: 8),
        _bodyText('When to use it: ${phrase.whenToUse}'),
        const SizedBox(height: 12),
        _bodyText('Example dialogue', weight: FontWeight.bold),
        ...phrase.example.map((turn) => Padding(
            padding: const EdgeInsets.only(top: 5),
            child: _bodyText('${turn.speaker}: “${turn.line}”'))),
        const SizedBox(height: 12),
        Align(
          alignment: Alignment.centerLeft,
          child: IconButton(
            tooltip: isFavorite ? 'Remove favorite' : 'Add favorite',
            onPressed: () => _toggleFavorite(phrase),
            icon: Icon(
                isFavorite
                    ? Icons.favorite_rounded
                    : Icons.favorite_border_rounded,
                color: _leaf),
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: _action(
              'Listen', Icons.volume_up_rounded, () => _speak(phrase.phrase)),
        ),
        SizedBox(width: double.infinity, child: _recordControl()),
        SizedBox(
          width: double.infinity,
          child: _action(
              'Practice', Icons.replay_rounded, () => _speak(phrase.phrase),
              secondary: true),
        ),
      ]),
      _action('Next phrase', Icons.arrow_forward_rounded, () {
        final currentGlobalIndex = commonPhrases.indexOf(phrase);
        if (currentGlobalIndex + 1 >= commonPhrases.length) {
          _completeActivity();
          setState(() {
            _phraseCategory = commonPhrases.first.category;
            _index = 0;
          });
        } else {
          final nextPhrase = commonPhrases[currentGlobalIndex + 1];
          setState(() {
            _phraseCategory = nextPhrase.category;
            _index = commonPhrases
                .take(currentGlobalIndex + 1)
                .where((item) => item.category == nextPhrase.category)
                .length;
            _recording = false;
          });
        }
      }),
    ]);
  }

  Widget _wordChip(String label) => Chip(
        label: Text(label),
        backgroundColor: _leaf.withValues(alpha: 0.12),
        labelStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        side: BorderSide.none,
      );

  Widget _completionCard() => _panel('Activity complete', [
        _bodyText(
            'You finished this speaking practice. Continue exploring the next activity whenever you are ready.'),
        const SizedBox(height: 10),
        _action('Continue', Icons.check_rounded,
            () => Navigator.pop(context, true)),
      ]);

  Widget _buildActivity() {
    switch (widget.featureTitle) {
      case 'Pronunciation Practice':
        return _buildPronunciation();
      case 'Repeat After Me':
        return _buildRepeat();
      case 'Daily Conversation':
      case 'Role Play':
        return _buildConversation();
      case 'Speaking Topics':
        return _buildTopic();
      case 'Question & Answer':
        return _buildQuestionAnswer();
      default:
        return _buildPhrases();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: _green,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        elevation: 0,
        title: Text(widget.featureTitle),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (_activityComplete) _completionCard(),
              _buildActivity(),
            ],
          ),
        ),
      ),
    );
  }
}
