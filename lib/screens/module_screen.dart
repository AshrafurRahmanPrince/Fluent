import 'package:flutter/material.dart';
import 'package:fluento/models/learning_models.dart';
import 'package:fluento/screens/feature_practice_screen.dart';
import 'package:fluento/screens/lesson_detail_screen.dart';
import 'package:fluento/widgets/lesson_card.dart';
import 'package:fluento/widgets/module_feature_card.dart';
import 'package:fluento/widgets/progress_card.dart';

class ModuleScreen extends StatelessWidget {
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
  Widget build(BuildContext context) {
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
              child: Icon(icon, size: 20, color: const Color(0xFF3E8E55)),
            ),
            const SizedBox(width: 10),
            Text(moduleName),
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
                subtitle,
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
                '$moduleName Skills',
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
                itemCount: features.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final feature = features[index];
                  return ModuleFeatureCard(
                    feature: feature,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => FeaturePracticeScreen(feature: feature),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 28),
              Text(
                '$moduleName Lessons',
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
                itemCount: lessons.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final lesson = lessons[index];
                  return LessonCard(
                    lesson: lesson,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => LessonDetailScreen(lesson: lesson),
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
