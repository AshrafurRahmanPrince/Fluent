import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluento/data/reading_data.dart';
import 'package:fluento/models/learning_models.dart';
import 'package:fluento/models/reading_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReadingExperienceScreen extends StatefulWidget {
  const ReadingExperienceScreen({this.skillTitle, this.lesson, super.key})
      : assert(skillTitle != null || lesson != null);

  final String? skillTitle;
  final Lesson? lesson;

  @override
  State<ReadingExperienceScreen> createState() =>
      _ReadingExperienceScreenState();
}

class _ReadingExperienceScreenState extends State<ReadingExperienceScreen> {
  static const _forest = Color(0xFF0F3822);
  static const _cream = Color(0xFFF7F3E9);
  static const _leaf = Color(0xFF3E8E55);
  static const _ink = Color(0xFF1C2A23);

  final Map<String, String> _answers = {};
  final Map<String, bool> _checked = {};
  final TextEditingController _fillController = TextEditingController();

  String _difficulty = 'Beginner';
  String _vocabularyCategory = 'Daily Life';
  int _vocabularyWordIndex = 0;
  String _grammarTopic = 'Present Simple';
  String? _matchedMeaning;
  bool _matchChecked = false;
  String _fillFeedback = '';
  String _dailyFeedback = '';
  bool _dailyComplete = false;
  bool _challengeStarted = false;
  bool _skimReadyToAnswer = false;
  int _secondsLeft = 30;
  int _dailyStreak = 0;
  Timer? _challengeTimer;

  bool get _isLesson => widget.lesson != null;
  String get _title => widget.lesson?.title ?? widget.skillTitle!;

  ReadingPassage get _passage {
    if (_isLesson) return readingLessonsByTitle[widget.lesson!.title]!;
    switch (widget.skillTitle) {
      case 'Reading Comprehension':
        return comprehensionPassages[_difficulty]!;
      case 'Skimming Practice':
        return skimmingPassage;
      case 'Scanning Practice':
        return scanningPassage;
      case 'Grammar in Reading':
        return grammarPassage;
      case 'Daily Reading':
        return readingLessonsByTitle['Daily Life']!;
      default:
        return readingLessonsByTitle['Daily Life']!;
    }
  }

  List<ReadingQuestion> get _questions => widget.skillTitle == 'Daily Reading'
      ? _passage.questions.take(3).toList()
      : _passage.questions;

  @override
  void initState() {
    super.initState();
    if (widget.skillTitle == 'Daily Reading') _loadDailyProgress();
  }

  @override
  void dispose() {
    _challengeTimer?.cancel();
    _fillController.dispose();
    super.dispose();
  }

  Future<void> _loadDailyProgress() async {
    final preferences = await SharedPreferences.getInstance();
    final today = _dateKey(DateTime.now());
    if (!mounted) return;
    setState(() {
      _dailyStreak = preferences.getInt('reading_daily_streak') ?? 0;
      _dailyComplete = preferences.getString('reading_daily_date') == today;
    });
  }

  String _dateKey(DateTime date) =>
      '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

  bool get _allQuestionsCorrect =>
      _questions.isNotEmpty &&
      _questions.asMap().entries.every(
            (entry) =>
                _checked[_questionKey(
                  entry.key,
                  widget.skillTitle == 'Daily Reading' ? 'daily' : null,
                )] ==
                true,
          );

  String _questionKey(int index, [String? prefix]) =>
      '${prefix ?? _passage.title}_$index';

  void _selectAnswer(String key, String answer) {
    setState(() {
      _answers[key] = answer;
      _checked.remove(key);
    });
  }

  void _checkQuestion(ReadingQuestion question, String key) {
    if (_answers[key] == null) return;
    setState(() => _checked[key] = _answers[key] == question.answer);
  }

  void _startSkimmingChallenge() {
    _challengeTimer?.cancel();
    setState(() {
      _secondsLeft = 30;
      _challengeStarted = true;
      _skimReadyToAnswer = false;
      _answers.remove('skim_challenge');
      _checked.remove('skim_challenge');
    });
    _challengeTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      if (_secondsLeft <= 1) {
        timer.cancel();
        setState(() {
          _secondsLeft = 0;
          _skimReadyToAnswer = true;
        });
      } else {
        setState(() => _secondsLeft -= 1);
      }
    });
  }

  void _finishSkimmingReading() {
    _challengeTimer?.cancel();
    setState(() => _skimReadyToAnswer = true);
  }

  Future<void> _completeDailyReading() async {
    final preferences = await SharedPreferences.getInstance();
    final now = DateTime.now();
    final today = _dateKey(now);
    final lastDate = preferences.getString('reading_daily_date');
    final yesterday = _dateKey(now.subtract(const Duration(days: 1)));
    var streak = preferences.getInt('reading_daily_streak') ?? 0;

    if (lastDate != today) {
      streak = lastDate == yesterday ? streak + 1 : 1;
      await preferences.setInt('reading_daily_streak', streak);
      await preferences.setString('reading_daily_date', today);
    }

    if (!mounted) return;
    setState(() {
      _dailyComplete = true;
      _dailyStreak = streak;
      _dailyFeedback = 'Reading completed. Well done!';
    });
  }

  void _completeLesson() => Navigator.pop(context, true);

  @override
  Widget build(BuildContext context) {
    final passage = _passage;

    return Scaffold(
      backgroundColor: _forest,
      appBar: AppBar(
        backgroundColor: _forest,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            const Icon(Icons.menu_book_rounded, color: _leaf),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                _isLesson ? 'Reading Lesson' : 'Reading',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(18, 8, 18, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildIntro(passage),
              const SizedBox(height: 18),
              if (_isLesson) ..._buildLesson(passage),
              if (!_isLesson) ..._buildSkill(passage),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIntro(ReadingPassage passage) {
    final subtitle = switch (widget.skillTitle) {
      'Vocabulary Builder' => 'Build your vocabulary through reading.',
      'Reading Comprehension' => 'Read a passage and test your understanding.',
      'Skimming Practice' => 'Learn how to quickly understand the main idea.',
      'Scanning Practice' => 'Find specific information quickly.',
      'Grammar in Reading' => 'Understand grammar through real passages.',
      'Daily Reading' => 'Build a daily English reading habit.',
      _ => passage.title,
    };

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration:
          BoxDecoration(color: _cream, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(_isLesson ? widget.lesson!.title : _title,
              style: const TextStyle(
                  color: _ink, fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text(
              _isLesson
                  ? widget.lesson!.summary ??
                      'Read, learn, and check your understanding.'
                  : subtitle,
              style: TextStyle(
                  color: _ink.withValues(alpha: 0.78),
                  fontSize: 14,
                  height: 1.5)),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _infoChip(passage.level),
              _infoChip('${passage.minutes} min'),
              if (_isLesson) _infoChip('${passage.words.length} new words'),
            ],
          ),
          if (_isLesson) ...[
            const SizedBox(height: 14),
            const Text('Lesson progress',
                style: TextStyle(color: _ink, fontWeight: FontWeight.w600)),
            const SizedBox(height: 7),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: _checked.values.where((correct) => correct).length /
                    passage.questions.length,
                minHeight: 8,
                backgroundColor: _forest.withValues(alpha: 0.12),
                valueColor: const AlwaysStoppedAnimation<Color>(_leaf),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _infoChip(String label) => Chip(
        label: Text(label),
        visualDensity: VisualDensity.compact,
        backgroundColor: _leaf.withValues(alpha: 0.12),
        labelStyle:
            const TextStyle(color: _forest, fontWeight: FontWeight.w600),
        side: BorderSide.none,
      );

  List<Widget> _buildSkill(ReadingPassage passage) {
    switch (widget.skillTitle) {
      case 'Vocabulary Builder':
        return _buildVocabulary();
      case 'Reading Comprehension':
        return _buildComprehension(passage);
      case 'Skimming Practice':
        return _buildSkimming(passage);
      case 'Scanning Practice':
        return _buildScanning(passage);
      case 'Grammar in Reading':
        return _buildGrammar(passage);
      case 'Daily Reading':
        return _buildDailyReading(passage);
      default:
        return [
          _section('Reading', [_passageCard(passage)])
        ];
    }
  }

  List<Widget> _buildLesson(ReadingPassage passage) => [
        _section('Reading passage', [_passageCard(passage)]),
        _section('Vocabulary', [
          for (final word in passage.words) _vocabularyCard(word),
        ]),
        _section('Comprehension questions', _buildQuestions(passage.questions)),
        _buildCompletionButton(),
      ];

  List<Widget> _buildVocabulary() {
    final words = vocabularyCategories[_vocabularyCategory]!;
    final selectedWord =
        words[_vocabularyWordIndex < words.length ? _vocabularyWordIndex : 0];
    final distractors = words.where((word) => word != selectedWord).toList();
    final outsideCategoryWord = vocabularyCategories.entries
        .where((entry) => entry.key != _vocabularyCategory)
        .expand((entry) => entry.value)
        .first;
    final meaningOptions = [
      selectedWord.meaning,
      ...distractors.take(2).map((word) => word.meaning),
      outsideCategoryWord.meaning,
    ];
    final matchOptions = [...meaningOptions];
    final blankSentence = selectedWord.example.replaceFirst(
      RegExp(selectedWord.word, caseSensitive: false),
      '____',
    );
    final mcq = ReadingQuestion(
      prompt: 'The word “${selectedWord.word}” means:',
      options: meaningOptions,
      answer: selectedWord.meaning,
      explanation:
          '${selectedWord.word} means ${selectedWord.meaning.toLowerCase()}',
    );

    return [
      _section('Choose a category and word', [
        DropdownButtonFormField<String>(
          initialValue: _vocabularyCategory,
          isExpanded: true,
          decoration: _inputDecoration('Vocabulary category'),
          items: vocabularyCategories.keys
              .map((category) =>
                  DropdownMenuItem(value: category, child: Text(category)))
              .toList(),
          onChanged: (category) {
            if (category == null) return;
            setState(() {
              _vocabularyCategory = category;
              _vocabularyWordIndex = 0;
              _answers.remove('vocabulary_0');
              _checked.remove('vocabulary_0');
              _matchedMeaning = null;
              _matchChecked = false;
              _fillFeedback = '';
              _fillController.clear();
            });
          },
        ),
        const SizedBox(height: 10),
        DropdownButtonFormField<String>(
          initialValue: selectedWord.word,
          isExpanded: true,
          decoration: _inputDecoration('Choose a word'),
          items: words
              .map((word) =>
                  DropdownMenuItem(value: word.word, child: Text(word.word)))
              .toList(),
          onChanged: (word) {
            if (word == null) return;
            setState(() {
              _vocabularyWordIndex =
                  words.indexWhere((item) => item.word == word);
              _answers.remove('vocabulary_0');
              _checked.remove('vocabulary_0');
              _matchedMeaning = null;
              _matchChecked = false;
              _fillFeedback = '';
              _fillController.clear();
            });
          },
        ),
      ]),
      _section('Read it in context', [
        _highlightedPassage(selectedWord.passage, [selectedWord.word]),
        const SizedBox(height: 12),
        for (final word in words) _vocabularyCard(word),
      ]),
      _section(
          'Multiple choice', _buildQuestions([mcq], keyPrefix: 'vocabulary')),
      _section('Fill in the blank', [
        Text(blankSentence,
            style: const TextStyle(color: _ink, fontSize: 16, height: 1.6)),
        const SizedBox(height: 10),
        TextField(
          controller: _fillController,
          decoration: _inputDecoration('Type the missing word'),
          textCapitalization: TextCapitalization.sentences,
        ),
        const SizedBox(height: 10),
        ElevatedButton(
            onPressed: _checkFillBlank, child: const Text('Check word')),
        if (_fillFeedback.isNotEmpty)
          _feedback(_fillFeedback, _fillFeedback.startsWith('Correct')),
      ]),
      _section('Match word and meaning', [
        Text('Choose the meaning of “${selectedWord.word}”.',
            style: const TextStyle(color: _ink, fontSize: 16)),
        const SizedBox(height: 10),
        DropdownButtonFormField<String>(
          initialValue: _matchedMeaning,
          isExpanded: true,
          decoration: _inputDecoration('Select a meaning'),
          items: matchOptions
              .map((meaning) =>
                  DropdownMenuItem(value: meaning, child: Text(meaning)))
              .toList(),
          onChanged: (meaning) => setState(() {
            _matchedMeaning = meaning;
            _matchChecked = false;
          }),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: _matchedMeaning == null
              ? null
              : () => setState(() => _matchChecked = true),
          child: const Text('Check match'),
        ),
        if (_matchedMeaning != null && _matchChecked)
          _feedback(
            _matchedMeaning == selectedWord.meaning
                ? 'Correct! ${selectedWord.word} means ${selectedWord.meaning.toLowerCase()}'
                : 'Try again. ${selectedWord.word} means ${selectedWord.meaning.toLowerCase()}',
            _matchedMeaning == selectedWord.meaning,
          ),
      ]),
    ];
  }

  void _checkFillBlank() {
    final words = vocabularyCategories[_vocabularyCategory]!;
    final word =
        words[_vocabularyWordIndex < words.length ? _vocabularyWordIndex : 0]
            .word;
    final answer = _fillController.text
        .trim()
        .toLowerCase()
        .replaceAll(RegExp(r'[.!?,]$'), '');
    setState(() {
      _fillFeedback = answer == word.toLowerCase()
          ? 'Correct! “$word” completes the sentence.'
          : 'Try again. Look at the highlighted word in the passage.';
    });
  }

  List<Widget> _buildComprehension(ReadingPassage passage) => [
        _section('Choose your level', [
          DropdownButtonFormField<String>(
            initialValue: _difficulty,
            isExpanded: true,
            decoration: _inputDecoration('Difficulty'),
            items: const ['Beginner', 'Intermediate', 'Advanced']
                .map((level) =>
                    DropdownMenuItem(value: level, child: Text(level)))
                .toList(),
            onChanged: (level) {
              if (level == null) return;
              setState(() {
                _difficulty = level;
                _answers.clear();
                _checked.clear();
              });
            },
          ),
        ]),
        _section('Read the passage', [_passageCard(passage)]),
        _section(
            'Check your understanding', _buildQuestions(passage.questions)),
      ];

  List<Widget> _buildSkimming(ReadingPassage passage) => [
        _section('How to skim', [
          const Text(
              'Skimming means reading quickly for the main idea, not every word.',
              style: TextStyle(color: _ink, height: 1.5)),
          const SizedBox(height: 10),
          _tip('Look at the title and headings.'),
          _tip('Read the first sentence of each paragraph.'),
          _tip('Notice repeated keywords and the conclusion.'),
        ]),
        _section('Example passage', [_passageCard(passage)]),
        _section('Main idea',
            _buildQuestions(passage.questions, keyPrefix: 'skim_example')),
        _section('30-second challenge', [
          const Text(
              'Skim the passage, then choose its main idea. You can answer even if the timer ends.',
              style: TextStyle(color: _ink, height: 1.5)),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Text(
                  !_challengeStarted
                      ? 'Ready when you are'
                      : _skimReadyToAnswer
                          ? 'Passage read. Answer when ready.'
                          : '$_secondsLeft seconds',
                  style: const TextStyle(
                      color: _forest,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
              ),
              OutlinedButton.icon(
                onPressed: !_challengeStarted || _skimReadyToAnswer
                    ? _startSkimmingChallenge
                    : _finishSkimmingReading,
                icon: const Icon(Icons.replay_rounded),
                label: Text(
                  !_challengeStarted
                      ? 'Start'
                      : _skimReadyToAnswer
                          ? 'Restart'
                          : 'Answer now',
                ),
              ),
            ],
          ),
          if (_challengeStarted) ...[
            const SizedBox(height: 8),
            _passageCard(passage),
            if (_skimReadyToAnswer)
              ..._buildQuestions(passage.questions,
                  keyPrefix: 'skim_challenge'),
          ],
        ]),
      ];

  List<Widget> _buildScanning(ReadingPassage passage) => [
        _section('How to scan', [
          const Text(
              'Scanning means moving your eyes quickly to find one exact fact.',
              style: TextStyle(color: _ink, height: 1.5)),
          const SizedBox(height: 10),
          _tip('Search for names, dates, numbers, places, or keywords.'),
          _tip('Do not stop to read every sentence.'),
        ]),
        _section('Find the details', [_passageCard(passage)]),
        _section('Scanning questions', _buildQuestions(passage.questions)),
      ];

  List<Widget> _buildGrammar(ReadingPassage passage) {
    const explanations = <String, String>{
      'Present Simple':
          'Use the present simple for habits. With he, she, or one person, add -s or -es: Rina goes.',
      'Past Simple':
          'Use the past simple for finished actions: visited and found.',
      'Present Continuous':
          'Use am, is, or are + verb-ing for an action happening now: is working.',
      'Articles':
          'Use a before a consonant sound and an before a vowel sound: an article.',
      'Prepositions':
          'Prepositions show relationships in place or time: to university, at home, with friends.',
      'Pronouns':
          'Pronouns replace nouns. She refers to Rina; they can refer to Rina and her classmates.',
      'Subject-Verb Agreement':
          'The verb form matches its subject: Rina studies, but the students study.',
      'Linking Words':
          'Linking words connect ideas. And adds information; but shows a contrast.',
    };
    const highlights = <String, List<String>>{
      'Present Simple': ['goes', 'studies', 'enjoys'],
      'Past Simple': ['visited', 'found'],
      'Present Continuous': ['is working'],
      'Articles': ['an article'],
      'Prepositions': ['to university', 'with her classmates', 'about robots'],
      'Pronouns': ['She', 'they'],
      'Subject-Verb Agreement': ['Rina goes', 'She studies', 'they visited'],
      'Linking Words': ['and'],
    };

    return [
      _section('Grammar topic', [
        DropdownButtonFormField<String>(
          initialValue: _grammarTopic,
          isExpanded: true,
          decoration: _inputDecoration('Choose a topic'),
          items: explanations.keys
              .map(
                  (topic) => DropdownMenuItem(value: topic, child: Text(topic)))
              .toList(),
          onChanged: (topic) =>
              setState(() => _grammarTopic = topic ?? _grammarTopic),
        ),
      ]),
      _section('Read and notice', [
        _highlightedPassage(passage.text, highlights[_grammarTopic]!),
        const SizedBox(height: 12),
        Text(explanations[_grammarTopic]!,
            style: const TextStyle(color: _ink, height: 1.6)),
      ]),
      _section('Practice in context', _buildQuestions(passage.questions)),
    ];
  }

  List<Widget> _buildDailyReading(ReadingPassage passage) => [
        _section('Today’s reading', [
          const Text('Morning at the University',
              style: TextStyle(
                  color: _ink, fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          const Text('Beginner  ·  5 min  ·  5 new words',
              style: TextStyle(color: _ink)),
          const SizedBox(height: 12),
          _passageCard(passage),
        ]),
        _section('New words',
            [for (final word in passage.words) _vocabularyCard(word)]),
        _section(
            'What did you understand?',
            _buildQuestions(passage.questions.take(3).toList(),
                keyPrefix: 'daily')),
        _section('Daily progress', [
          Text(
              _dailyComplete
                  ? '✓ Reading completed'
                  : 'Answer all questions correctly to complete today’s reading.',
              style: const TextStyle(
                  color: _ink, fontWeight: FontWeight.w600, height: 1.5)),
          const SizedBox(height: 8),
          Text(
              _dailyStreak == 0
                  ? 'Complete a reading today to start your streak.'
                  : 'Daily Reading Streak: $_dailyStreak ${_dailyStreak == 1 ? 'day' : 'days'}',
              style: const TextStyle(color: _ink)),
          if (_dailyFeedback.isNotEmpty) _feedback(_dailyFeedback, true),
          if (!_dailyComplete) ...[
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _allQuestionsCorrect ? _completeDailyReading : null,
              child: const Text('Complete today’s reading'),
            ),
          ],
        ]),
      ];

  List<Widget> _buildQuestions(List<ReadingQuestion> questions,
          {String keyPrefix = ''}) =>
      [
        for (var index = 0; index < questions.length; index++)
          _questionCard(questions[index],
              '$keyPrefix${keyPrefix.isEmpty ? _passage.title : ''}_$index'),
      ];

  Widget _questionCard(ReadingQuestion question, String key) {
    final checked = _checked[key];
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(question.prompt,
              style: const TextStyle(
                  color: _ink,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  height: 1.45)),
          const SizedBox(height: 8),
          RadioGroup<String>(
            groupValue: _answers[key],
            onChanged: (value) {
              if (value != null) _selectAnswer(key, value);
            },
            child: Material(
              color: Colors.transparent,
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (final option in question.options)
                      InkWell(
                        onTap: () => _selectAnswer(key, option),
                        child: Row(
                          children: [
                            Radio<String>(value: option, activeColor: _leaf),
                            Expanded(
                              child: Text(
                                option,
                                style:
                                    const TextStyle(color: _ink, height: 1.35),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _answers[key] == null
                ? null
                : () => _checkQuestion(question, key),
            child: const Text('Check answer'),
          ),
          if (checked != null) ...[
            _feedback(checked ? '✓ Correct' : '✗ Incorrect', checked),
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(question.explanation,
                  style: const TextStyle(color: _ink, height: 1.5)),
            ),
          ],
        ],
      ),
    );
  }

  Widget _section(String title, List<Widget> children) => Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: _cream, borderRadius: BorderRadius.circular(14)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(
                    color: _ink, fontSize: 17, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      );

  Widget _passageCard(ReadingPassage passage) => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(passage.title,
                style: const TextStyle(
                    color: _ink, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            _highlightedPassage(
                passage.text, passage.words.map((word) => word.word).toList()),
          ],
        ),
      );

  Widget _highlightedPassage(String text, List<String> words) {
    if (words.isEmpty) {
      return Text(text,
          style: const TextStyle(color: _ink, fontSize: 16, height: 1.65));
    }
    final pattern =
        RegExp('(${words.map(RegExp.escape).join('|')})', caseSensitive: false);
    final spans = <TextSpan>[];
    var lastEnd = 0;
    for (final match in pattern.allMatches(text)) {
      if (match.start > lastEnd) {
        spans.add(TextSpan(text: text.substring(lastEnd, match.start)));
      }
      spans.add(TextSpan(
        text: match.group(0),
        style: TextStyle(
            backgroundColor: _leaf.withValues(alpha: 0.2),
            fontWeight: FontWeight.bold),
      ));
      lastEnd = match.end;
    }
    if (lastEnd < text.length) {
      spans.add(TextSpan(text: text.substring(lastEnd)));
    }
    return Text.rich(TextSpan(children: spans),
        style: const TextStyle(color: _ink, fontSize: 16, height: 1.65));
  }

  Widget _vocabularyCard(ReadingWord word) => Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(word.word,
                style: const TextStyle(
                    color: _forest, fontSize: 17, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(word.meaning,
                style: const TextStyle(color: _ink, height: 1.45)),
            const SizedBox(height: 4),
            Text('Part of speech: ${word.partOfSpeech}',
                style: TextStyle(color: _ink.withValues(alpha: 0.75))),
            Text('Example: ${word.example}',
                style: const TextStyle(color: _ink, height: 1.45)),
            if (word.synonym != null)
              Text('Synonym: ${word.synonym}',
                  style: const TextStyle(color: _ink)),
          ],
        ),
      );

  Widget _tip(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 7),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.check_circle_outline_rounded,
                size: 18, color: _leaf),
            const SizedBox(width: 8),
            Expanded(
                child: Text(text,
                    style: const TextStyle(color: _ink, height: 1.45))),
          ],
        ),
      );

  Widget _feedback(String text, bool correct) => Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 8),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: (correct ? _leaf : Colors.deepOrange).withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(text,
            style: const TextStyle(
                color: _ink, fontWeight: FontWeight.w600, height: 1.4)),
      );

  InputDecoration _inputDecoration(String label) => InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none),
      );

  Widget _buildCompletionButton() => Padding(
        padding: const EdgeInsets.only(top: 2),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: _allQuestionsCorrect ? _completeLesson : null,
            icon: const Icon(Icons.check_circle_outline_rounded),
            label: const Text('Mark lesson complete'),
          ),
        ),
      );
}
