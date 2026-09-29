import 'package:flutter/material.dart';
import 'package:fluento/models/learning_models.dart';
import 'package:fluento/screens/feature_practice_screen.dart';
import 'package:fluento/screens/lesson_detail_screen.dart';
import 'package:fluento/screens/reading/reading_experience_screen.dart';
import 'package:fluento/widgets/lesson_card.dart';
import 'package:fluento/widgets/module_feature_card.dart';
import 'package:fluento/widgets/progress_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ModuleScreen extends StatefulWidget {
  const ModuleScreen({
    required this.moduleName,
    required this.subtitle,
    required this.icon,
    required this.features,
    required this.lessons,
    required this.progress,
    super.key,
  });

  final String moduleName;
  final String subtitle;
  final IconData icon;
  final List<LearningFeature> features;
  final List<Lesson> lessons;
  final ModuleProgress progress;

  @override
  State<ModuleScreen> createState() => _ModuleScreenState();
}

class _ModuleScreenState extends State<ModuleScreen> {
  static const _completedKey = 'reading_completed_lessons';
  static const _startedKey = 'reading_started_lessons';

  final Set<String> _completedReadingLessons = {};
  final Set<String> _startedReadingLessons = {};

  bool get _isReading => widget.moduleName == 'Reading';

  @override
  void initState() {
    super.initState();
    if (_isReading) _loadReadingProgress();
  }

  Future<void> _loadReadingProgress() async {
    final preferences = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      _completedReadingLessons.addAll(
        preferences.getStringList(_completedKey) ?? const [],
      );
      _startedReadingLessons.addAll(
        preferences.getStringList(_startedKey) ?? const [],
      );
    });
  }

  Future<void> _openReadingLesson(Lesson lesson) async {
    setState(() => _startedReadingLessons.add(lesson.title));
    final preferences = await SharedPreferences.getInstance();
    await preferences.setStringList(
        _startedKey, _startedReadingLessons.toList());
    if (!mounted) return;

    final completed = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => ReadingExperienceScreen(lesson: lesson),
      ),
    );
    if (completed != true || !mounted) return;

    setState(() {
      _completedReadingLessons.add(lesson.title);
      _startedReadingLessons.remove(lesson.title);
    });
    await preferences.setStringList(
      _completedKey,
      _completedReadingLessons.toList(),
    );
    await preferences.setStringList(
      _startedKey,
      _startedReadingLessons.toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final progress = _isReading
        ? ModuleProgress(
            title: widget.progress.title,
            completed: _completedReadingLessons.length,
            total: widget.lessons.length,
          )
        : widget.progress;

    return Scaffold(
      backgroundColor: const Color(0xFF0F3822),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F3822),
        foregroundColor: const Color(0xFFFDFBF7),
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: const Color(0xFF3E8E55).withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(10),
              ),
              child:
                  Icon(widget.icon, size: 20, color: const Color(0xFF3E8E55)),
            ),
            const SizedBox(width: 10),
            Text(widget.moduleName),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.subtitle,
                style: const TextStyle(
                  color: Color(0xFFFDFBF7),
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 20),
              ProgressCard(
                title: progress.title,
                progress: progress.percent,
                completedCount: progress.completed,
                totalCount: progress.total,
              ),
              const SizedBox(height: 26),
              Text(
                '${widget.moduleName} Skills',
                style: const TextStyle(
                  color: Color(0xFFFDFBF7),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              ListView.separated(
                shrinkWrap: true,
                primary: false,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.features.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final feature = widget.features[index];
                  return ModuleFeatureCard(
                    feature: feature,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => _isReading
                            ? ReadingExperienceScreen(skillTitle: feature.title)
                            : FeaturePracticeScreen(feature: feature),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 28),
              Text(
                '${widget.moduleName} Lessons',
                style: const TextStyle(
                  color: Color(0xFFFDFBF7),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              ListView.separated(
                shrinkWrap: true,
                primary: false,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.lessons.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final lesson = widget.lessons[index];
                  return LessonCard(
                    lesson: lesson,
                    statusLabel: _isReading
                        ? _completedReadingLessons.contains(lesson.title)
                            ? '✓ Completed'
                            : _startedReadingLessons.contains(lesson.title)
                                ? 'Continue'
                                : 'Start'
                        : null,
                    onTap: () => _isReading
                        ? _openReadingLesson(lesson)
                        : Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  LessonDetailScreen(lesson: lesson),
                            ),
                          ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
