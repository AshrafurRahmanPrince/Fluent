import 'package:flutter/material.dart';
import 'package:fluento/models/learning_models.dart';

class _PracticeQuestion {
  const _PracticeQuestion({
    required this.question,
    required this.options,
    required this.answer,
  });

  final String question;
  final List<String> options;
  final String answer;
}

class _SentenceExercise {
  const _SentenceExercise({required this.words, required this.answer});

  final List<String> words;
  final String answer;
}

class FeaturePracticeScreen extends StatefulWidget {
  const FeaturePracticeScreen({required this.feature, super.key});

  final LearningFeature feature;

  @override
  State<FeaturePracticeScreen> createState() => _FeaturePracticeScreenState();
}

class _FeaturePracticeScreenState extends State<FeaturePracticeScreen> {
  final Map<String, String> selectedAnswers = {};
  final Map<String, String> answerFeedback = {};
  final TextEditingController paragraphController = TextEditingController();
  final TextEditingController correctionController = TextEditingController();
  final TextEditingController emailSubjectController = TextEditingController();
  final TextEditingController emailRecipientController =
      TextEditingController();
  final TextEditingController emailBodyController = TextEditingController();
  final TextEditingController storyController = TextEditingController();

  String resultText = '';
  String sentenceFeedback = '';
  String selectedGrammarTopic = 'Tenses';
  String selectedVocabularyCategory = 'Daily Life';
  String selectedParagraphTopic = 'My Daily Routine';
  String selectedEmailType = 'Formal Email';
  String selectedEmailTopic = 'Leave Application';
  String selectedStoryTopic = 'A Rainy Day';
  int sentenceExerciseIndex = 0;
  final List<String> selectedSentenceWords = <String>[];

  static const _sentenceExercises = <_SentenceExercise>[
    _SentenceExercise(
      words: ['school', 'I', 'every', 'day', 'go', 'to'],
      answer: 'I go to school every day.',
    ),
    _SentenceExercise(
      words: ['reads', 'She', 'books', 'interesting'],
      answer: 'She reads interesting books.',
    ),
    _SentenceExercise(
      words: ['football', 'plays', 'He'],
      answer: 'He plays football.',
    ),
  ];

  @override
  void dispose() {
    paragraphController.dispose();
    correctionController.dispose();
    emailSubjectController.dispose();
    emailRecipientController.dispose();
    emailBodyController.dispose();
    storyController.dispose();
    super.dispose();
  }

  List<_PracticeQuestion> _getQuestionsForFeature() {
    switch (widget.feature.title) {
      case 'Sentence Building':
        return const [
          _PracticeQuestion(
            question: 'Choose the correct sentence.',
            options: [
              'I go to school every day.',
              'I goes to school every day.',
              'I going to school every day.',
              'I gone to school every day.'
            ],
            answer: 'I go to school every day.',
          ),
          _PracticeQuestion(
            question: 'Which sentence is a question?',
            options: [
              'She plays football.',
              'Do you like English?',
              'Open the book.',
              'I do not like tea.'
            ],
            answer: 'Do you like English?',
          ),
        ];
      case 'Grammar Practice':
        return const [
          _PracticeQuestion(
            question: 'Choose the correct article.',
            options: ['a', 'an', 'the', 'no article'],
            answer: 'an',
          ),
          _PracticeQuestion(
            question: 'Choose the correct form: “She ___ to school every day.”',
            options: ['go', 'goes', 'going', 'went'],
            answer: 'goes',
          ),
        ];
      case 'Paragraph Writing':
        return const [
          _PracticeQuestion(
            question: 'Which is the strongest paragraph structure?',
            options: [
              'Only a conclusion.',
              'Topic sentence, detail, and closing sentence.',
              'One random idea.',
              'A list of words.'
            ],
            answer: 'Topic sentence, detail, and closing sentence.',
          ),
          _PracticeQuestion(
            question: 'What is the main purpose of a topic sentence?',
            options: [
              'To end the paragraph.',
              'To introduce the main idea.',
              'To ignore the topic.',
              'To make the paragraph longer.'
            ],
            answer: 'To introduce the main idea.',
          ),
        ];
      case 'Email Writing':
        return const [
          _PracticeQuestion(
            question: 'Which element is important in a formal email?',
            options: ['Greeting', 'Emoji', 'Text slang', 'No subject line'],
            answer: 'Greeting',
          ),
          _PracticeQuestion(
            question: 'What should a clear email subject do?',
            options: [
              'Hide the purpose.',
              'State the topic briefly.',
              'Use a long joke.',
              'Skip punctuation.'
            ],
            answer: 'State the topic briefly.',
          ),
        ];
      case 'Story Writing':
        return const [
          _PracticeQuestion(
            question: 'A good short story usually includes:',
            options: [
              'Only one word.',
              'A beginning, middle, and ending.',
              'Only dialogue.',
              'Only a title.'
            ],
            answer: 'A beginning, middle, and ending.',
          ),
          _PracticeQuestion(
            question: 'Which word best connects events in a story?',
            options: ['Meanwhile', 'Slowly', 'Apple', 'Example'],
            answer: 'Meanwhile',
          ),
        ];
      case 'Writing Correction':
        return const [
          _PracticeQuestion(
            question: 'Choose the corrected sentence.',
            options: [
              'She do not likes tea.',
              'She does not like tea.',
              'She not like tea.',
              'She liking tea.'
            ],
            answer: 'She does not like tea.',
          ),
          _PracticeQuestion(
            question: 'Choose the correct sentence.',
            options: [
              'I am go to school.',
              'I am going to school.',
              'I going to school.',
              'I am go school.'
            ],
            answer: 'I am going to school.',
          ),
        ];
      case 'Pronunciation Practice':
        return const [
          _PracticeQuestion(
            question: 'What is the correct pronunciation focus for “library”?',
            options: [
              'Stress the first syllable',
              'Stress the last syllable',
              'No stress',
              'Speak very quickly'
            ],
            answer: 'Stress the first syllable',
          ),
        ];
      case 'Repeat After Me':
        return const [
          _PracticeQuestion(
            question:
                'Which phrase best matches the sentence “I am looking forward to our meeting”?',
            options: [
              'I am tired of hearing you.',
              'I am excited about our meeting.',
              'I do not want to meet.',
              'I arrived late.'
            ],
            answer: 'I am excited about our meeting.',
          ),
        ];
      case 'Daily Conversation':
        return const [
          _PracticeQuestion(
            question: 'A good greeting in English often begins with:',
            options: [
              'Good morning',
              'Please leave',
              'Tomorrow evening',
              'Never'
            ],
            answer: 'Good morning',
          ),
        ];
      case 'Speaking Topics':
        return const [
          _PracticeQuestion(
            question: 'When speaking about a topic, a strong answer includes:',
            options: [
              'Only a single word.',
              'A main idea and a few details.',
              'No examples.',
              'Only a question.'
            ],
            answer: 'A main idea and a few details.',
          ),
        ];
      case 'Question & Answer':
        return const [
          _PracticeQuestion(
            question: 'Which answer is natural for “How are you today?”',
            options: [
              'I am a student.',
              'I am fine, thank you.',
              'I am two o’clock.',
              'I like green.'
            ],
            answer: 'I am fine, thank you.',
          ),
        ];
      case 'Role Play':
        return const [
          _PracticeQuestion(
            question: 'In a role play, your goal is to:',
            options: [
              'Speak only in your native language.',
              'Practice realistic conversation in English.',
              'Ignore the situation.',
              'Read without speaking.'
            ],
            answer: 'Practice realistic conversation in English.',
          ),
        ];
      case 'Common Phrases':
        return const [
          _PracticeQuestion(
            question: 'What does “Can you help me?” mean?',
            options: [
              'You are leaving.',
              'You are asking for assistance.',
              'The person is angry.',
              'You are giving directions.'
            ],
            answer: 'You are asking for assistance.',
          ),
        ];
      case 'Listening Practice':
        return const [
          _PracticeQuestion(
            question: 'What is the best way to improve listening skills?',
            options: [
              'Ignore the speaker.',
              'Listen carefully and answer questions.',
              'Never review audio.',
              'Read only the transcript.'
            ],
            answer: 'Listen carefully and answer questions.',
          ),
        ];
      case 'Dictation':
        return const [
          _PracticeQuestion(
            question: 'Dictation usually helps you train:',
            options: [
              'Only writing speed.',
              'Listening and spelling accuracy.',
              'Only drawing.',
              'Reading without attention.'
            ],
            answer: 'Listening and spelling accuracy.',
          ),
        ];
      case 'Listen & Choose':
        return const [
          _PracticeQuestion(
            question: 'The best listening strategy is to:',
            options: [
              'Multi-task while hearing the audio.',
              'Focus on the main idea and details.',
              'Skip difficult words.',
              'Only listen once.'
            ],
            answer: 'Focus on the main idea and details.',
          ),
        ];
      case 'Vocabulary Listening':
        return const [
          _PracticeQuestion(
            question: 'Improving vocabulary through listening helps you:',
            options: [
              'Avoid speaking.',
              'Understand meaning in context.',
              'Only read one word.',
              'Ignore pronunciation.'
            ],
            answer: 'Understand meaning in context.',
          ),
        ];
      case 'Conversation Listening':
        return const [
          _PracticeQuestion(
            question: 'A useful listening habit is to:',
            options: [
              'Focus on keywords and context.',
              'Read the transcript first.',
              'Close your eyes and wait.',
              'Ignore the speaker.'
            ],
            answer: 'Focus on keywords and context.',
          ),
        ];
      case 'Slow Listening':
        return const [
          _PracticeQuestion(
            question: 'Why use a slower listening speed?',
            options: [
              'To hear every word more clearly.',
              'To make audio louder.',
              'To skip the lesson.',
              'To remove pronunciation practice.'
            ],
            answer: 'To hear every word more clearly.',
          ),
        ];
      case 'Listening Comprehension':
        return const [
          _PracticeQuestion(
            question: 'Listening comprehension means:',
            options: [
              'Understanding what you hear.',
              'Reading faster.',
              'Writing without thinking.',
              'Avoiding questions.'
            ],
            answer: 'Understanding what you hear.',
          ),
        ];
      default:
        return const [
          _PracticeQuestion(
            question:
                'Choose the best answer to complete the practice session.',
            options: [
              'Keep learning',
              'Stop now',
              'Skip exercise',
              'Ignore feedback'
            ],
            answer: 'Keep learning',
          ),
        ];
    }
  }

  void _submitPractice() {
    final questions = _getQuestionsForFeature();
    int correctCount = 0;

    for (final question in questions) {
      final answer = selectedAnswers[question.question];
      if (answer == question.answer) {
        correctCount += 1;
      }
    }

    final scoreText = '$correctCount / ${questions.length} correct';
    setState(() {
      resultText = 'Practice complete! $scoreText';
    });
  }

  Scaffold _buildSkillScaffold({
    required String title,
    required String subtitle,
    required List<Widget> sections,
  }) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F3822),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F3822),
        foregroundColor: const Color(0xFFFDFBF7),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(title),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F3E9),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Color(0xFF1C2A23),
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: const Color(0xFF1C2A23).withValues(alpha: 0.7),
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ...sections,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionCard(String title, List<Widget> children) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F3E9),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF1C2A23),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }

  Widget _buildBulletRow(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle_rounded,
              color: Color(0xFF3E8E55), size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Color(0xFF1C2A23),
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExample(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF3E8E55).withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xFF1C2A23),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildQuestionCard(_PracticeQuestion question, int index) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F3E9),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Question ${index + 1}',
            style: const TextStyle(
              color: Color(0xFF3E8E55),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            question.question,
            style: const TextStyle(
              color: Color(0xFF1C2A23),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          ...question.options.map((option) {
            final isSelected = selectedAnswers[question.question] == option;
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedAnswers[question.question] = option;
                });
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF3E8E55).withValues(alpha: 0.12)
                      : const Color(0xFF0F3822).withValues(alpha: 0.04),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF3E8E55)
                        : const Color(0xFF0F3822).withValues(alpha: 0.08),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFF3E8E55)
                              : const Color(0xFF0F3822).withValues(alpha: 0.45),
                          width: 2,
                        ),
                      ),
                      child: isSelected
                          ? Center(
                              child: Container(
                                width: 10,
                                height: 10,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF3E8E55),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            )
                          : null,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        option,
                        style: const TextStyle(
                          color: Color(0xFF1C2A23),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  List<Widget> _buildSentenceBuildingContent() {
    final currentExercise = _sentenceExercises[sentenceExerciseIndex];
    final availableWords = currentExercise.words;
    final correctAnswer = currentExercise.answer;

    return [
      _buildSectionCard('Learn', [
        const Text(
          'Subject + Verb + Object',
          style: TextStyle(
            color: Color(0xFF1C2A23),
            fontWeight: FontWeight.bold,
            fontSize: 16,
            height: 1.6,
          ),
        ),
        const Text(
          'Basic pattern: Subject + Verb + Object.',
          style: TextStyle(color: Color(0xFF1C2A23), height: 1.6),
        ),
        const SizedBox(height: 8),
        _buildExample('I read books.'),
        _buildExample('She plays football.'),
        _buildBulletRow('Subject = who does it'),
        _buildBulletRow('Verb = the action'),
        _buildBulletRow('Object = what is affected'),
      ]),
      _buildSectionCard('Sentence Types', [
        const Text('Positive: I like English.',
            style: TextStyle(color: Color(0xFF1C2A23), height: 1.5)),
        const Text('Negative: I do not like English.',
            style: TextStyle(color: Color(0xFF1C2A23), height: 1.5)),
        const Text('Question: Do you like English?',
            style: TextStyle(color: Color(0xFF1C2A23), height: 1.5)),
        const Text('Command: Open the book.',
            style: TextStyle(color: Color(0xFF1C2A23), height: 1.5)),
      ]),
      _buildSectionCard('Word Order Practice', [
        Text(
          'Put the words in the correct order.',
          style: TextStyle(
            color: const Color(0xFF1C2A23).withValues(alpha: 0.8),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: availableWords.map((word) {
            final alreadySelected = selectedSentenceWords.contains(word);
            return ChoiceChip(
              label: Text(word),
              selected: alreadySelected,
              selectedColor: const Color(0xFF3E8E55),
              backgroundColor: const Color(0xFFe9f0ea),
              labelStyle: TextStyle(
                color: alreadySelected ? Colors.white : const Color(0xFF1C2A23),
                fontWeight: FontWeight.w600,
              ),
              onSelected: (_) {
                if (alreadySelected) {
                  setState(() {
                    selectedSentenceWords.remove(word);
                    sentenceFeedback = '';
                  });
                  return;
                }
                if (selectedSentenceWords.length < availableWords.length) {
                  setState(() {
                    selectedSentenceWords.add(word);
                    sentenceFeedback = '';
                  });
                }
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 14),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF0F3822).withValues(alpha: 0.04),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            selectedSentenceWords.isEmpty
                ? 'Your sentence: '
                : 'Your sentence: ${selectedSentenceWords.join(' ')}',
            style: const TextStyle(
                color: Color(0xFF1C2A23), fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  final answerText = selectedSentenceWords.join(' ');
                  final isCorrect = answerText == correctAnswer;
                  setState(() {
                    sentenceFeedback = isCorrect
                        ? 'Great! Your sentence is correct.'
                        : 'Try again. Correct answer: $correctAnswer';
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3E8E55),
                  foregroundColor: Colors.white,
                ),
                child: const Text('Check Answer'),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  setState(() {
                    selectedSentenceWords.clear();
                    sentenceFeedback = '';
                  });
                },
                child: const Text('Reset'),
              ),
            ),
          ],
        ),
        if (sentenceFeedback.isNotEmpty) ...[
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: sentenceFeedback.startsWith('Great')
                  ? const Color(0xFF3E8E55).withValues(alpha: 0.12)
                  : const Color(0xFFB86A3C).withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              sentenceFeedback,
              style: const TextStyle(
                  color: Color(0xFF1C2A23), fontWeight: FontWeight.w600),
            ),
          ),
        ],
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: () {
            setState(() {
              selectedSentenceWords.clear();
              sentenceFeedback = '';
              sentenceExerciseIndex =
                  (sentenceExerciseIndex + 1) % _sentenceExercises.length;
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0F3822),
            foregroundColor: Colors.white,
          ),
          child: const Text('Next Example'),
        ),
      ]),
      _buildSectionCard('Subject-Verb Agreement', [
        _buildBulletRow('I play. We play. They play.'),
        _buildBulletRow('He plays. She plays. It plays.'),
        _buildExample('He eats breakfast.'),
      ]),
      ..._getQuestionsForFeature()
          .asMap()
          .entries
          .map((entry) => _buildQuestionCard(entry.value, entry.key)),
      SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: _submitPractice,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF3E8E55),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          ),
          child: const Text('Check Answer'),
        ),
      ),
      if (resultText.isNotEmpty) ...[
        const SizedBox(height: 14),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFF2D6A4F),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            resultText,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ];
  }

  List<Widget> _buildGrammarPracticeContent() {
    final grammarTopics = <String>[
      'Tenses',
      'Articles',
      'Prepositions',
      'Subject-Verb Agreement',
      'Pronouns',
      'Adjectives',
      'Adverbs'
    ];
    final selected = selectedGrammarTopic;
    final grammarContent = <String, List<Widget>>{
      'Tenses': [
        const Text('Use the simple tense for habits and routines.',
            style: TextStyle(color: Color(0xFF1C2A23), height: 1.6)),
        _buildExample('I play football. She goes to school.'),
      ],
      'Articles': [
        const Text('Use a/an for general nouns; use the for specific ones.',
            style: TextStyle(color: Color(0xFF1C2A23), height: 1.6)),
        _buildExample('a book, an apple, the sun'),
      ],
      'Prepositions': [
        const Text('Prepositions show place or time.',
            style: TextStyle(color: Color(0xFF1C2A23), height: 1.6)),
        _buildExample('in class, on the table, at 9 o’clock'),
      ],
      'Subject-Verb Agreement': [
        const Text('He plays. She plays. They play.',
            style: TextStyle(color: Color(0xFF1C2A23), height: 1.6)),
        _buildExample('She writes homework every day.'),
      ],
      'Pronouns': [
        const Text('Use pronouns to replace nouns: I, you, he, she, we, they.',
            style: TextStyle(color: Color(0xFF1C2A23), height: 1.6)),
        _buildExample('Ali is tired. He wants to rest.'),
      ],
      'Adjectives': [
        const Text('Adjectives describe nouns.',
            style: TextStyle(color: Color(0xFF1C2A23), height: 1.6)),
        _buildExample('a happy student, a red bag'),
      ],
      'Adverbs': [
        const Text('Adverbs tell how something is done.',
            style: TextStyle(color: Color(0xFF1C2A23), height: 1.6)),
        _buildExample('She sings beautifully.'),
      ],
    };

    return [
      _buildSectionCard('Grammar Topics', [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: grammarTopics.map((topic) {
            final isSelected = selected == topic;
            return ChoiceChip(
              label: Text(topic),
              selected: isSelected,
              selectedColor: const Color(0xFF3E8E55),
              backgroundColor: const Color(0xFFe9f0ea),
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : const Color(0xFF1C2A23),
                fontWeight: FontWeight.w600,
              ),
              onSelected: (_) {
                setState(() {
                  selectedGrammarTopic = topic;
                });
              },
            );
          }).toList(),
        ),
      ]),
      _buildSectionCard(selected, grammarContent[selected] ?? const [Text('')]),
      ..._getQuestionsForFeature()
          .asMap()
          .entries
          .map((entry) => _buildQuestionCard(entry.value, entry.key)),
      SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: _submitPractice,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF3E8E55),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          ),
          child: const Text('Check Answer'),
        ),
      ),
      if (resultText.isNotEmpty) ...[
        const SizedBox(height: 14),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFF2D6A4F),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            resultText,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ];
  }

  List<Widget> _buildVocabularyContent() {
    final categories = <String>[
      'Daily Life',
      'Education',
      'Technology',
      'Environment',
      'Travel',
      'Feelings & Emotions',
      'Academic Words',
      'Linking Words'
    ];
    final vocabulary = <String, List<Widget>>{
      'Daily Life': [
        _buildExample('Morning: time before midday'),
        _buildExample('Routine: daily habit'),
      ],
      'Education': [
        _buildExample('Study: learn carefully'),
        _buildExample('Improve: make better'),
      ],
      'Technology': [
        _buildExample('Device: tool or machine'),
        _buildExample('Internet: global network'),
      ],
      'Environment': [
        _buildExample('Pollution: dirty air or water'),
        _buildExample('Recycle: use again'),
      ],
      'Travel': [
        _buildExample('Journey: trip'),
        _buildExample('Destination: place you go'),
      ],
      'Feelings & Emotions': [
        _buildExample('Excited: very happy'),
        _buildExample('Confident: sure of yourself'),
      ],
      'Academic Words': [
        _buildExample('Analysis: careful study'),
        _buildExample('Evidence: proof'),
      ],
      'Linking Words': [
        const Text('However, therefore, because, although, for example.',
            style: TextStyle(color: Color(0xFF1C2A23), height: 1.6)),
        _buildExample('I was tired. However, I finished my work.'),
      ],
    };

    final categoryContent =
        vocabulary[selectedVocabularyCategory] ?? const [Text('')];

    return [
      _buildSectionCard('Vocabulary Categories', [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: categories.map((category) {
            final isSelected = selectedVocabularyCategory == category;
            return ChoiceChip(
              label: Text(category),
              selected: isSelected,
              selectedColor: const Color(0xFF3E8E55),
              backgroundColor: const Color(0xFFe9f0ea),
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : const Color(0xFF1C2A23),
                fontWeight: FontWeight.w600,
              ),
              onSelected: (_) {
                setState(() {
                  selectedVocabularyCategory = category;
                });
              },
            );
          }).toList(),
        ),
      ]),
      _buildSectionCard(selectedVocabularyCategory, [
        const Text('Word: improve',
            style: TextStyle(color: Color(0xFF1C2A23), height: 1.5)),
        const Text('Meaning: make better',
            style: TextStyle(color: Color(0xFF1C2A23), height: 1.5)),
        const Text('Example: I want to improve my English.',
            style: TextStyle(color: Color(0xFF1C2A23), height: 1.5)),
        ...categoryContent,
      ]),
      _buildSectionCard('Practice', [
        const Text(
            'Fill in the blank: "I studied hard; ___, I passed the exam."',
            style: TextStyle(color: Color(0xFF1C2A23), height: 1.5)),
        const SizedBox(height: 8),
        ...['therefore', 'however', 'although', 'because'].map((option) {
          final isSelected = selectedAnswers['vocabulary_blank'] == option;
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedAnswers['vocabulary_blank'] = option;
              });
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF3E8E55).withValues(alpha: 0.12)
                    : const Color(0xFF0F3822).withValues(alpha: 0.04),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(option,
                  style: const TextStyle(color: Color(0xFF1C2A23))),
            ),
          );
        }),
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: () {
            final selected = selectedAnswers['vocabulary_blank'];
            setState(() {
              answerFeedback['vocabulary_blank'] = selected == 'therefore'
                  ? 'Correct! "Therefore" shows a result.'
                  : 'Not quite. The correct answer is therefore.';
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF3E8E55),
            foregroundColor: Colors.white,
          ),
          child: const Text('Check Answer'),
        ),
        if (answerFeedback['vocabulary_blank'] != null) ...[
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF2D6A4F).withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              answerFeedback['vocabulary_blank']!,
              style: const TextStyle(
                  color: Color(0xFF1C2A23), fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ]),
    ];
  }

  List<Widget> _buildParagraphWritingContent() {
    final topics = <String>[
      'My Daily Routine',
      'My Favorite Hobby',
      'My University',
      'Importance of Education',
      'Benefits of Reading',
      'Social Media',
      'Technology in Our Life',
      'Environmental Pollution'
    ];
    final selectedTopic = selectedParagraphTopic;

    return [
      _buildSectionCard('Paragraph Structure', [
        _buildBulletRow('Topic sentence: main idea.'),
        _buildBulletRow('Details: explain the idea.'),
        _buildBulletRow('Ending: close the paragraph.'),
        _buildExample(
            'My hobby is reading. I read every evening. It helps me relax.'),
      ]),
      _buildSectionCard('Format', [
        const Text('Topic sentence → details → closing sentence',
            style: TextStyle(color: Color(0xFF1C2A23), height: 1.6)),
      ]),
      _buildSectionCard('Topics', [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: topics.map((topic) {
            final isSelected = selectedTopic == topic;
            return ChoiceChip(
              label: Text(topic),
              selected: isSelected,
              selectedColor: const Color(0xFF3E8E55),
              backgroundColor: const Color(0xFFe9f0ea),
              onSelected: (_) {
                setState(() {
                  selectedParagraphTopic = topic;
                });
              },
            );
          }).toList(),
        ),
      ]),
      _buildSectionCard('Write a paragraph', [
        Text('Topic: $selectedParagraphTopic',
            style: const TextStyle(
                color: Color(0xFF1C2A23), fontWeight: FontWeight.w700)),
        const SizedBox(height: 10),
        TextField(
          controller: paragraphController,
          maxLines: 8,
          decoration: InputDecoration(
            hintText: 'Write a paragraph about this topic...',
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 12),
        const Text(
            'Useful words: important, daily, helpful, because, therefore, for example.'),
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: () {
            final text = paragraphController.text.trim();
            final checklist = [
              if (text.isNotEmpty) 'Topic sentence',
              if (text.toLowerCase().contains('because') ||
                  text.toLowerCase().contains('for example'))
                'Details',
              if (text.toLowerCase().contains('therefore') ||
                  text.toLowerCase().contains('in conclusion'))
                'Closing',
            ];

            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text('Paragraph checklist'),
                content: Text(checklist.isEmpty
                    ? 'Write a paragraph to see feedback.'
                    : checklist.join('\n')),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Close'),
                  ),
                ],
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF3E8E55),
            foregroundColor: Colors.white,
          ),
          child: const Text('Check My Paragraph'),
        ),
      ]),
    ];
  }

  List<Widget> _buildEmailWritingContent() {
    final emailTypes = ['Formal Email', 'Informal Email'];
    final emailTopics = [
      'Leave Application',
      'Request for Information',
      'Complaint Email',
      'Invitation Email',
      'Thank You Email',
      'Job/Internship Inquiry',
      'Email to a Teacher',
      'Email to a Friend'
    ];

    return [
      _buildSectionCard('Email Types', [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: emailTypes.map((type) {
            final isSelected = selectedEmailType == type;
            return ChoiceChip(
              label: Text(type),
              selected: isSelected,
              selectedColor: const Color(0xFF3E8E55),
              backgroundColor: const Color(0xFFe9f0ea),
              onSelected: (_) {
                setState(() {
                  selectedEmailType = type;
                });
              },
            );
          }).toList(),
        ),
      ]),
      _buildSectionCard(selectedEmailType, [
        if (selectedEmailType == 'Formal Email') ...[
          const Text('Subject: Request for Leave',
              style: TextStyle(color: Color(0xFF1C2A23), height: 1.5)),
          const Text('Dear Sir/Madam,',
              style: TextStyle(color: Color(0xFF1C2A23), height: 1.5)),
          const Text('I am writing to request leave for two days.',
              style: TextStyle(color: Color(0xFF1C2A23), height: 1.5)),
          const Text('Yours sincerely,',
              style: TextStyle(color: Color(0xFF1C2A23), height: 1.5)),
        ] else ...[
          const Text('Subject: My Weekend',
              style: TextStyle(color: Color(0xFF1C2A23), height: 1.5)),
          const Text('Hi [Friend\'s Name],',
              style: TextStyle(color: Color(0xFF1C2A23), height: 1.5)),
          const Text('How are you? I had a nice weekend.',
              style: TextStyle(color: Color(0xFF1C2A23), height: 1.5)),
          const Text('Best wishes,',
              style: TextStyle(color: Color(0xFF1C2A23), height: 1.5)),
        ],
      ]),
      _buildSectionCard('Quick Rules', [
        _buildBulletRow('Use a clear subject line'),
        _buildBulletRow('Start with a greeting'),
        _buildBulletRow('Write short paragraphs'),
        _buildBulletRow('End with a polite closing'),
      ]),
      _buildSectionCard('Practice Topics', [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: emailTopics.map((topic) {
            final isSelected = selectedEmailTopic == topic;
            return ChoiceChip(
              label: Text(topic),
              selected: isSelected,
              selectedColor: const Color(0xFF3E8E55),
              backgroundColor: const Color(0xFFe9f0ea),
              onSelected: (_) {
                setState(() {
                  selectedEmailTopic = topic;
                });
              },
            );
          }).toList(),
        ),
      ]),
      _buildSectionCard('Write an email', [
        Text('Email type: $selectedEmailType',
            style: const TextStyle(
                color: Color(0xFF1C2A23), fontWeight: FontWeight.bold)),
        Text('Topic: $selectedEmailTopic',
            style: const TextStyle(color: Color(0xFF1C2A23))),
        const SizedBox(height: 10),
        TextField(
          controller: emailSubjectController,
          decoration: InputDecoration(
            labelText: 'Subject',
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: emailRecipientController,
          decoration: InputDecoration(
            labelText: 'Recipient',
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: emailBodyController,
          maxLines: 8,
          decoration: InputDecoration(
            hintText: 'Write an email about $selectedEmailTopic...',
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none),
          ),
        ),
      ]),
    ];
  }

  List<Widget> _buildStoryWritingContent() {
    final storyTopics = [
      'A Rainy Day',
      'A Lost Wallet',
      'The Honest Student',
      'A Journey',
      'The Unexpected Gift',
      'A Helpful Stranger'
    ];
    final availableWords = [
      'One day',
      'Suddenly',
      'After that',
      'Meanwhile',
      'Fortunately',
      'Finally'
    ];

    return [
      _buildSectionCard('Story Structure', [
        _buildBulletRow('Beginning: who and where'),
        _buildBulletRow('Problem: what happens'),
        _buildBulletRow('Events: what changes'),
        _buildBulletRow('Ending: how it ends'),
      ]),
      _buildSectionCard('Useful Words', [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children:
              availableWords.map((word) => Chip(label: Text(word))).toList(),
        ),
      ]),
      _buildSectionCard('Story Topics', [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: storyTopics.map((topic) {
            final isSelected = selectedStoryTopic == topic;
            return ChoiceChip(
              label: Text(topic),
              selected: isSelected,
              selectedColor: const Color(0xFF3E8E55),
              backgroundColor: const Color(0xFFe9f0ea),
              onSelected: (_) {
                setState(() {
                  selectedStoryTopic = topic;
                });
              },
            );
          }).toList(),
        ),
      ]),
      _buildSectionCard('Story Practice', [
        Text('Topic: $selectedStoryTopic',
            style: const TextStyle(
                color: Color(0xFF1C2A23), fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        const Text('Start: "One morning, I found a small bag..."',
            style: TextStyle(color: Color(0xFF1C2A23), height: 1.5)),
        const SizedBox(height: 10),
        TextField(
          controller: storyController,
          maxLines: 8,
          decoration: InputDecoration(
            hintText: 'Continue the story here...',
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none),
          ),
        ),
      ]),
    ];
  }

  List<Widget> _buildWritingCorrectionContent() {
    final correctionExamples = <Map<String, String>>[
      {
        'incorrect': 'She go to school every day.',
        'correct': 'She goes to school every day.',
        'explanation': 'Use goes with she.'
      },
      {
        'incorrect': 'I am go to school.',
        'correct': 'I am going to school.',
        'explanation': 'Use am + going.'
      },
      {
        'incorrect': 'He dont like coffee.',
        'correct': 'He doesn’t like coffee.',
        'explanation': 'Use doesn’t with he.'
      },
    ];

    return [
      _buildSectionCard('Common Mistakes', [
        _buildBulletRow('Grammar'),
        _buildBulletRow('Tense'),
        _buildBulletRow('Spelling'),
        _buildBulletRow('Punctuation'),
      ]),
      _buildSectionCard('Examples', [
        ...correctionExamples.map((example) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Text('Wrong: ${example['incorrect']}',
                    style:
                        const TextStyle(color: Color(0xFF1C2A23), height: 1.5)),
                Text('Right: ${example['correct']}',
                    style: const TextStyle(
                        color: Color(0xFF3E8E55),
                        fontWeight: FontWeight.bold,
                        height: 1.5)),
                Text('Why: ${example['explanation']}',
                    style:
                        const TextStyle(color: Color(0xFF1C2A23), height: 1.5)),
              ],
            )),
      ]),
      _buildSectionCard('Practice', [
        const Text('Correct this sentence: "He dont like coffee."',
            style: TextStyle(
                color: Color(0xFF1C2A23), fontWeight: FontWeight.w600)),
        const SizedBox(height: 12),
        TextField(
          controller: correctionController,
          decoration: InputDecoration(
            hintText: 'Type your corrected sentence...',
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none),
          ),
        ),
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: () {
            final answer = correctionController.text.trim();
            final isCorrect =
                answer.toLowerCase() == 'he doesn’t like coffee.' ||
                    answer.toLowerCase() == 'he does not like coffee.' ||
                    answer.toLowerCase() == 'he doesn\'t like coffee.';
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: Text(isCorrect ? '✓ Correct!' : 'Try again'),
                content: Text(
                  isCorrect
                      ? 'Use doesn\'t with he/she/it.'
                      : 'Correct answer: He doesn\'t like coffee.',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Close'),
                  ),
                ],
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF3E8E55),
            foregroundColor: Colors.white,
          ),
          child: const Text('Check Answer'),
        ),
      ]),
    ];
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.feature.title) {
      case 'Sentence Building':
        return _buildSkillScaffold(
          title: 'Sentence Building',
          subtitle: 'Learn how to build correct English sentences.',
          sections: _buildSentenceBuildingContent(),
        );
      case 'Grammar Practice':
        return _buildSkillScaffold(
          title: 'Grammar Practice',
          subtitle: 'Improve your grammar through practice.',
          sections: _buildGrammarPracticeContent(),
        );
      case 'Vocabulary for Writing':
        return _buildSkillScaffold(
          title: 'Vocabulary for Writing',
          subtitle: 'Learn useful words and phrases for better writing.',
          sections: _buildVocabularyContent(),
        );
      case 'Paragraph Writing':
        return _buildSkillScaffold(
          title: 'Paragraph Writing',
          subtitle: 'Learn how to write clear and organized paragraphs.',
          sections: _buildParagraphWritingContent(),
        );
      case 'Email Writing':
        return _buildSkillScaffold(
          title: 'Email Writing',
          subtitle: 'Learn how to write clear and effective emails.',
          sections: _buildEmailWritingContent(),
        );
      case 'Story Writing':
        return _buildSkillScaffold(
          title: 'Story Writing',
          subtitle: 'Learn how to create interesting short stories.',
          sections: _buildStoryWritingContent(),
        );
      case 'Writing Correction':
        return _buildSkillScaffold(
          title: 'Writing Correction',
          subtitle: 'Find and fix common English mistakes.',
          sections: _buildWritingCorrectionContent(),
        );
      default:
        final questions = _getQuestionsForFeature();
        return Scaffold(
          backgroundColor: const Color(0xFF0F3822),
          appBar: AppBar(
            backgroundColor: const Color(0xFF0F3822),
            foregroundColor: const Color(0xFFFDFBF7),
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_rounded),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(widget.feature.title),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF7F3E9),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.feature.title,
                          style: const TextStyle(
                            color: Color(0xFF1C2A23),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.feature.description,
                          style: TextStyle(
                            color:
                                const Color(0xFF1C2A23).withValues(alpha: 0.72),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  ...questions.asMap().entries.map(
                      (entry) => _buildQuestionCard(entry.value, entry.key)),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _submitPractice,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3E8E55),
                        foregroundColor: const Color(0xFFFDFBF7),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Text('Submit Practice'),
                    ),
                  ),
                  if (resultText.isNotEmpty) ...[
                    const SizedBox(height: 18),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2D6A4F),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Text(
                        resultText,
                        style: const TextStyle(
                          color: Color(0xFFFDFBF7),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
    }
  }
}
