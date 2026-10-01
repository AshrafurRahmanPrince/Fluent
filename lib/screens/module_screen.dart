import 'package:flutter/material.dart';
import 'package:fluento/models/learning_models.dart';
import 'package:fluento/screens/feature_practice_screen.dart';
import 'package:fluento/screens/lesson_detail_screen.dart';
import 'package:fluento/screens/reading/reading_experience_screen.dart';
import 'package:fluento/screens/speaking/speaking_activity_screen.dart';
import 'package:fluento/screens/speaking/speaking_lesson_screen.dart';
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
  static const _speakingCompletedLessonsKey = 'speaking_completed_lessons';
  static const _speakingCompletedActivitiesKey =
      'speaking_completed_activities';

  final Set<String> _completedReadingLessons = {};
  final Set<String> _startedReadingLessons = {};
  final Set<String> _completedSpeakingLessons = {};
  final Set<String> _completedSpeakingActivities = {};

  bool get _isReading => widget.moduleName == 'Reading';
  bool get _isSpeaking => widget.moduleName == 'Speaking';

  @override
  void initState() {
    super.initState();
    if (_isReading) _loadReadingProgress();
    if (_isSpeaking) _loadSpeakingProgress();
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

  Future<void> _loadSpeakingProgress() async {
    final preferences = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      _completedSpeakingLessons.addAll(
        preferences.getStringList(_speakingCompletedLessonsKey) ??
            widget.lessons
                .where((lesson) => lesson.completed)
                .map((lesson) => lesson.title),
      );
      _completedSpeakingActivities.addAll(
        preferences.getStringList(_speakingCompletedActivitiesKey) ?? const [],
      );
    });
  }

  Future<void> _openSpeakingActivity(LearningFeature feature) async {
    final completed = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => SpeakingActivityScreen(featureTitle: feature.title),
      ),
    );
    if (completed != true || !mounted) return;
    setState(() => _completedSpeakingActivities.add(feature.title));
    final preferences = await SharedPreferences.getInstance();
    await preferences.setStringList(
      _speakingCompletedActivitiesKey,
      _completedSpeakingActivities.toList(),
    );
  }

  Future<void> _openSpeakingLesson(Lesson lesson) async {
    final completed = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => SpeakingLessonScreen(lesson: lesson)),
    );
    if (completed != true || !mounted) return;
    setState(() => _completedSpeakingLessons.add(lesson.title));
    final preferences = await SharedPreferences.getInstance();
    await preferences.setStringList(
      _speakingCompletedLessonsKey,
      _completedSpeakingLessons.toList(),
    );
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

  void _openFeature(LearningFeature feature) {
    if (_isSpeaking) {
      _openSpeakingActivity(feature);
      return;
    }

    final screen = _isReading
        ? ReadingExperienceScreen(skillTitle: feature.title)
        : FeaturePracticeScreen(feature: feature);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  Future<void> _openLesson(Lesson lesson) async {
    if (_isReading) {
      await _openReadingLesson(lesson);
    } else if (_isSpeaking) {
      await _openSpeakingLesson(lesson);
    } else {
      await Navigator.push<void>(
        context,
        MaterialPageRoute(builder: (_) => LessonDetailScreen(lesson: lesson)),
      );
    }
  }

  String? _lessonStatus(Lesson lesson) {
    if (_isReading) {
      if (_completedReadingLessons.contains(lesson.title)) return '✓ Completed';
      if (_startedReadingLessons.contains(lesson.title)) return 'Continue';
      return 'Start';
    }
    if (_isSpeaking) {
      return _completedSpeakingLessons.contains(lesson.title)
          ? '✓ Completed'
          : 'Start';
    }
    return null;
  }

  ModuleProgress get _moduleProgress {
    if (_isReading) {
      return ModuleProgress(
        title: widget.progress.title,
        completed: _completedReadingLessons.length,
        total: widget.lessons.length,
      );
    }
    if (_isSpeaking) {
      return ModuleProgress(
        title: widget.progress.title,
        completed: _completedSpeakingLessons.length +
            _completedSpeakingActivities.length,
        total: widget.lessons.length + widget.features.length,
      );
    }
    return widget.progress;
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final progress = _moduleProgress;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: colors.onSurface,
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
                color: colors.primary.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(widget.icon, size: 20, color: colors.primary),
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
                style: TextStyle(
                  color: colors.onSurface,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 20),
              ProgressCard(
                title: progress.title,
                progress: progress.percent,
                completedCount: progress.completed,
                totalCount: progress.total,
                completedLabel: _isSpeaking ? 'learning activities' : 'lessons',
              ),
              const SizedBox(height: 26),
              Text(
                '${widget.moduleName} Skills',
                style: TextStyle(
                  color: colors.onSurface,
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
                    onTap: () => _openFeature(feature),
                  );
                },
              ),
              const SizedBox(height: 28),
              Text(
                '${widget.moduleName} Lessons',
                style: TextStyle(
                  color: colors.onSurface,
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
                    statusLabel: _lessonStatus(lesson),
                    onTap: () => _openLesson(lesson),
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
