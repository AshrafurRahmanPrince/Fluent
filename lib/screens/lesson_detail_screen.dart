import 'package:flutter/material.dart';
import 'package:fluento/models/learning_models.dart';

class LessonDetailScreen extends StatefulWidget {
  const LessonDetailScreen({required this.lesson, super.key});

  final Lesson lesson;

  @override
  State<LessonDetailScreen> createState() => _LessonDetailScreenState();
}

class _LessonDetailScreenState extends State<LessonDetailScreen> {
  bool _lessonCompleted = false;
  final TextEditingController _opinionController = TextEditingController();
  final TextEditingController _storyController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _opinionController.dispose();
    _storyController.dispose();
    _emailController.dispose();
    super.dispose();
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

  Widget _buildGoalItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle_rounded, color: Color(0xFF3E8E55)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Color(0xFFFDFBF7),
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildSentenceBasicsLesson() {
    return [
      _buildSectionCard('Learning Objective', [
        const Text('Learn the basic sentence pattern: subject + verb + object.',
            style: TextStyle(color: Color(0xFF1C2A23), height: 1.5)),
      ]),
      _buildSectionCard('Explanation', [
        const Text(
            'A basic sentence has a subject, a verb, and often an object.',
            style: TextStyle(color: Color(0xFF1C2A23), height: 1.5)),
        const Text('Example: I eat rice.',
            style: TextStyle(color: Color(0xFF1C2A23), height: 1.5)),
      ]),
      _buildSectionCard('Practice', [
        const Text('Write three short sentences using this pattern.',
            style: TextStyle(color: Color(0xFF1C2A23), height: 1.5)),
      ]),
    ];
  }

  List<Widget> _buildParagraphLesson() {
    return [
      _buildSectionCard('Learning Objective', [
        const Text('Learn how to write a clear paragraph.',
            style: TextStyle(color: Color(0xFF1C2A23), height: 1.5)),
      ]),
      _buildSectionCard('Explanation', [
        const Text(
            'A paragraph has a topic sentence, details, and a closing sentence.',
            style: TextStyle(color: Color(0xFF1C2A23), height: 1.5)),
      ]),
      _buildSectionCard('Example', [
        const Text(
            'My favorite hobby is reading. I read every evening. It helps me relax and learn new words.',
            style: TextStyle(color: Color(0xFF1C2A23), height: 1.6)),
      ]),
      _buildSectionCard('Practice', [
        const Text('Write 4–5 sentences about your daily routine.',
            style: TextStyle(color: Color(0xFF1C2A23), height: 1.5)),
      ]),
    ];
  }

  List<Widget> _buildDescriptiveLesson() {
    return [
      _buildSectionCard('Learning Objective', [
        const Text('Use adjectives to describe people, places, and things.',
            style: TextStyle(color: Color(0xFF1C2A23), height: 1.5)),
      ]),
      _buildSectionCard('Explanation', [
        const Text(
            'Use words like bright, quiet, modern, friendly, and useful.',
            style: TextStyle(color: Color(0xFF1C2A23), height: 1.5)),
        const Text('Example: The room is bright and comfortable.',
            style: TextStyle(color: Color(0xFF1C2A23), height: 1.5)),
      ]),
      _buildSectionCard('Practice', [
        const Text('Describe your classroom in 3–4 short sentences.',
            style: TextStyle(color: Color(0xFF1C2A23), height: 1.5)),
      ]),
    ];
  }

  List<Widget> _buildEmailLesson() {
    return [
      _buildSectionCard('Learning Objective', [
        const Text('Learn how to write a clear email.',
            style: TextStyle(color: Color(0xFF1C2A23), height: 1.5)),
      ]),
      _buildSectionCard('Explanation', [
        const Text('Include a subject, greeting, reason, and closing.',
            style: TextStyle(color: Color(0xFF1C2A23), height: 1.5)),
        const Text('Formal email: Dear Sir/Madam, ... Yours sincerely.',
            style: TextStyle(color: Color(0xFF1C2A23), height: 1.5)),
      ]),
      _buildSectionCard('Practice', [
        TextField(
          controller: _emailController,
          maxLines: 8,
          decoration: InputDecoration(
            hintText: 'Write a short email about a leave request...',
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

  List<Widget> _buildOpinionLesson() {
    return [
      _buildSectionCard('Learning Objective', [
        const Text('Write a short opinion paragraph.',
            style: TextStyle(color: Color(0xFF1C2A23), height: 1.5)),
      ]),
      _buildSectionCard('Explanation', [
        const Text(
            'Use phrases like: In my opinion, I believe, for example, therefore.',
            style: TextStyle(color: Color(0xFF1C2A23), height: 1.5)),
      ]),
      _buildSectionCard('Practice', [
        TextField(
          controller: _opinionController,
          maxLines: 8,
          decoration: InputDecoration(
            hintText:
                'Write your opinion about online learning or social media...',
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

  List<Widget> _buildStoryLesson() {
    return [
      _buildSectionCard('Learning Objective', [
        const Text('Write a short story with a beginning, problem, and ending.',
            style: TextStyle(color: Color(0xFF1C2A23), height: 1.5)),
      ]),
      _buildSectionCard('Explanation', [
        const Text('Use words like one day, suddenly, finally.',
            style: TextStyle(color: Color(0xFF1C2A23), height: 1.5)),
      ]),
      _buildSectionCard('Practice', [
        TextField(
          controller: _storyController,
          maxLines: 8,
          decoration: InputDecoration(
            hintText:
                'Write a short story beginning with: "One morning, I found a bag..."',
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

  List<Widget> _buildLessonContent() {
    switch (widget.lesson.title) {
      case 'Sentence Basics':
        return _buildSentenceBasicsLesson();
      case 'Paragraph Writing':
        return _buildParagraphLesson();
      case 'Descriptive Writing':
        return _buildDescriptiveLesson();
      case 'Email Writing':
        return _buildEmailLesson();
      case 'Opinion Writing':
        return _buildOpinionLesson();
      case 'Story Writing':
        return _buildStoryLesson();
      default:
        return [
          _buildSectionCard('Lesson overview', [
            Text(
                widget.lesson.summary ??
                    'This lesson builds confidence through guided practice and repetition.',
                style: const TextStyle(color: Color(0xFF1C2A23), height: 1.5)),
          ]),
          _buildSectionCard('Learning goals', [
            const Text(
                'Recognize key vocabulary and phrases relevant to the topic.',
                style: TextStyle(color: Color(0xFF1C2A23), height: 1.5)),
            const Text(
                'Answer short questions and complete simple practice activities.',
                style: TextStyle(color: Color(0xFF1C2A23), height: 1.5)),
          ]),
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final lessonFocus = widget.lesson.summary ??
        'This lesson builds confidence through guided practice and repetition.';

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
        title: Text(widget.lesson.title),
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
                      widget.lesson.title,
                      style: const TextStyle(
                        color: Color(0xFF1C2A23),
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        _InfoChip(label: widget.lesson.level),
                        const SizedBox(width: 8),
                        _InfoChip(label: '${widget.lesson.duration} min'),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Text(
                      lessonFocus,
                      style: TextStyle(
                        color: const Color(0xFF1C2A23).withValues(alpha: 0.75),
                        fontSize: 15,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Lesson goals',
                style: TextStyle(
                  color: Color(0xFFFDFBF7),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              _buildGoalItem(
                  'Recognize key vocabulary and phrases relevant to the topic.'),
              _buildGoalItem(
                  'Practice with clear examples and guided writing tasks.'),
              _buildGoalItem(
                  'Use the target language in simple writing activities.'),
              const SizedBox(height: 16),
              ..._buildLessonContent(),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _lessonCompleted = !_lessonCompleted;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          _lessonCompleted
                              ? 'Lesson marked as complete.'
                              : 'Lesson marked as incomplete.',
                        ),
                        backgroundColor: const Color(0xFF2D6A4F),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3E8E55),
                    foregroundColor: const Color(0xFFFDFBF7),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(_lessonCompleted ? 'Completed' : 'Mark Complete'),
                ),
              ),
              if (_lessonCompleted) ...[
                const SizedBox(height: 18),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2D6A4F),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Progress: Lesson complete. Great work!',
                    style: TextStyle(
                        color: Color(0xFFFDFBF7), fontWeight: FontWeight.bold),
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

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF3E8E55).withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFF0F3822),
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }
}
