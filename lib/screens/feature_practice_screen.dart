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

class FeaturePracticeScreen extends StatefulWidget {
  const FeaturePracticeScreen({required this.feature, super.key});

  final LearningFeature feature;

  @override
  State<FeaturePracticeScreen> createState() => _FeaturePracticeScreenState();
}

class _FeaturePracticeScreenState extends State<FeaturePracticeScreen> {
  Map<String, String> selectedAnswers = {};
  String resultText = '';

  List<_PracticeQuestion> getQuestions() {
    switch (widget.feature.title) {
      case 'Vocabulary Builder':
        return const [
          _PracticeQuestion(
            question: 'Which word means “a place to read and borrow books”?',
            options: ['Library', 'Market', 'Hospital', 'Station'],
            answer: 'Library',
          ),
          _PracticeQuestion(
            question: 'Choose the sentence that uses the word “curious” correctly.',
            options: [
              'She felt curious to learn more about the city.',
              'He was curious water.',
              'They curious the door.',
              'This is curious book.'
            ],
            answer: 'She felt curious to learn more about the city.',
          ),
        ];
      case 'Reading Comprehension':
        return const [
          _PracticeQuestion(
            question: 'What is the main idea of the passage?',
            options: [
              'People should avoid using public transport.',
              'City parks help people relax and stay active.',
              'The weather is always sunny in the city.',
              'People prefer to stay at home all day.'
            ],
            answer: 'City parks help people relax and stay active.',
          ),
          _PracticeQuestion(
            question: 'Why do people visit the park in the evening?',
            options: ['To avoid traffic.', 'To walk and spend time with family.', 'To buy groceries.', 'To attend school.'],
            answer: 'To walk and spend time with family.',
          ),
        ];
      case 'Skimming Practice':
        return const [
          _PracticeQuestion(
            question: 'What is the fastest way to understand the main idea of a passage?',
            options: ['Read every sentence slowly.', 'Read the title and first sentence of each paragraph.', 'Check every punctuation mark.', 'Translate every word.'],
            answer: 'Read the title and first sentence of each paragraph.',
          ),
        ];
      case 'Scanning Practice':
        return const [
          _PracticeQuestion(
            question: 'When scanning a text, what are you usually looking for?',
            options: ['The author’s diary.', 'Specific names, dates, or facts.', 'The tone of the writer.', 'The title font.'],
            answer: 'Specific names, dates, or facts.',
          ),
        ];
      case 'Grammar in Reading':
        return const [
          _PracticeQuestion(
            question: 'Choose the correct sentence.',
            options: ['She go to school every day.', 'She goes to school every day.', 'She going to school every day.', 'She gone to school every day.'],
            answer: 'She goes to school every day.',
          ),
        ];
      case 'Daily Reading':
        return const [
          _PracticeQuestion(
            question: 'A daily reading habit helps you to:',
            options: ['Avoid learning completely.', 'Improve fluency and confidence.', 'Write only one sentence a week.', 'Ignore new vocabulary.'],
            answer: 'Improve fluency and confidence.',
          ),
        ];
      case 'Sentence Building':
        return const [
          _PracticeQuestion(
            question: 'Arrange the words to form a correct sentence.',
            options: ['Yesterday / I / to / went / the / park', 'I went to the park yesterday.', 'The park I went yesterday to.', 'Yesterday went I to the park.'],
            answer: 'I went to the park yesterday.',
          ),
        ];
      case 'Grammar Practice':
        return const [
          _PracticeQuestion(
            question: 'Choose the correct article.',
            options: ['a', 'an', 'the', 'no article'],
            answer: 'an',
          ),
        ];
      case 'Paragraph Writing':
        return const [
          _PracticeQuestion(
            question: 'Which is the strongest paragraph structure?',
            options: ['Only a conclusion.', 'Topic sentence, detail, and closing sentence.', 'One random idea.', 'A list of words.'],
            answer: 'Topic sentence, detail, and closing sentence.',
          ),
        ];
      case 'Email Writing':
        return const [
          _PracticeQuestion(
            question: 'Which element is important in a formal email?',
            options: ['Greeting', 'Emoji', 'Text slang', 'No subject line'],
            answer: 'Greeting',
          ),
        ];
      case 'Story Writing':
        return const [
          _PracticeQuestion(
            question: 'A good short story usually includes:',
            options: ['Only one word.', 'A beginning, middle, and ending.', 'Only dialogue.', 'Only a title.'],
            answer: 'A beginning, middle, and ending.',
          ),
        ];
      case 'Writing Correction':
        return const [
          _PracticeQuestion(
            question: 'Choose the corrected sentence.',
            options: ['She do not likes tea.', 'She does not like tea.', 'She not like tea.', 'She liking tea.'],
            answer: 'She does not like tea.',
          ),
        ];
      case 'Pronunciation Practice':
        return const [
          _PracticeQuestion(
            question: 'What is the correct pronunciation focus for “library”?',
            options: ['Stress the first syllable', 'Stress the last syllable', 'No stress', 'Speak very quickly'],
            answer: 'Stress the first syllable',
          ),
        ];
      case 'Repeat After Me':
        return const [
          _PracticeQuestion(
            question: 'Which phrase best matches the sentence “I am looking forward to our meeting”?',
            options: ['I am tired of hearing you.', 'I am excited about our meeting.', 'I do not want to meet.', 'I arrived late.'],
            answer: 'I am excited about our meeting.',
          ),
        ];
      case 'Daily Conversation':
        return const [
          _PracticeQuestion(
            question: 'A good greeting in English often begins with:',
            options: ['Good morning', 'Please leave', 'Tomorrow evening', 'Never'],
            answer: 'Good morning',
          ),
        ];
      case 'Speaking Topics':
        return const [
          _PracticeQuestion(
            question: 'When speaking about a topic, a strong answer includes:',
            options: ['Only a single word.', 'A main idea and a few details.', 'No examples.', 'Only a question.'],
            answer: 'A main idea and a few details.',
          ),
        ];
      case 'Question & Answer':
        return const [
          _PracticeQuestion(
            question: 'Which answer is natural for “How are you today?”',
            options: ['I am a student.', 'I am fine, thank you.', 'I am two o’clock.', 'I like green.'],
            answer: 'I am fine, thank you.',
          ),
        ];
      case 'Role Play':
        return const [
          _PracticeQuestion(
            question: 'In a role play, your goal is to:',
            options: ['Speak only in your native language.', 'Practice realistic conversation in English.', 'Ignore the situation.', 'Read without speaking.'],
            answer: 'Practice realistic conversation in English.',
          ),
        ];
      case 'Common Phrases':
        return const [
          _PracticeQuestion(
            question: 'What does “Can you help me?” mean?',
            options: ['You are leaving.', 'You are asking for assistance.', 'The person is angry.', 'You are giving directions.'],
            answer: 'You are asking for assistance.',
          ),
        ];
      case 'Listening Practice':
        return const [
          _PracticeQuestion(
            question: 'What is the best way to improve listening skills?',
            options: ['Ignore the speaker.', 'Listen carefully and answer questions.', 'Never review audio.', 'Read only the transcript.'],
            answer: 'Listen carefully and answer questions.',
          ),
        ];
      case 'Dictation':
        return const [
          _PracticeQuestion(
            question: 'Dictation usually helps you train:',
            options: ['Only writing speed.', 'Listening and spelling accuracy.', 'Only drawing.', 'Reading without attention.'],
            answer: 'Listening and spelling accuracy.',
          ),
        ];
      case 'Listen & Choose':
        return const [
          _PracticeQuestion(
            question: 'The best listening strategy is to:',
            options: ['Multi-task while hearing the audio.', 'Focus on the main idea and details.', 'Skip difficult words.', 'Only listen once.'],
            answer: 'Focus on the main idea and details.',
          ),
        ];
      case 'Vocabulary Listening':
        return const [
          _PracticeQuestion(
            question: 'Improving vocabulary through listening helps you:',
            options: ['Avoid speaking.', 'Understand meaning in context.', 'Only read one word.', 'Ignore pronunciation.'],
            answer: 'Understand meaning in context.',
          ),
        ];
      case 'Conversation Listening':
        return const [
          _PracticeQuestion(
            question: 'A useful listening habit is to:',
            options: ['Focus on keywords and context.', 'Read the transcript first.', 'Close your eyes and wait.', 'Ignore the speaker.'],
            answer: 'Focus on keywords and context.',
          ),
        ];
      case 'Slow Listening':
        return const [
          _PracticeQuestion(
            question: 'Why use a slower listening speed?',
            options: ['To hear every word more clearly.', 'To make audio louder.', 'To skip the lesson.', 'To remove pronunciation practice.'],
            answer: 'To hear every word more clearly.',
          ),
        ];
      case 'Listening Comprehension':
        return const [
          _PracticeQuestion(
            question: 'Listening comprehension means:',
            options: ['Understanding what you hear.', 'Reading faster.', 'Writing without thinking.', 'Avoiding questions.'],
            answer: 'Understanding what you hear.',
          ),
        ];
      default:
        return const [
          _PracticeQuestion(
            question: 'Choose the best answer to complete the practice session.',
            options: ['Keep learning', 'Stop now', 'Skip exercise', 'Ignore feedback'],
            answer: 'Keep learning',
          ),
        ];
    }
  }

  void _submitPractice() {
    final questions = getQuestions();
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

  @override
  Widget build(BuildContext context) {
    final questions = getQuestions();

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
                        color: const Color(0xFF1C2A23).withValues(alpha: 0.72),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ...questions.asMap().entries.map((entry) {
                final index = entry.key;
                final question = entry.value;
                return Container(
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
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 12,
                            ),
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
              }),
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
