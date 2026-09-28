import 'package:flutter/material.dart';
import 'package:fluento/data/module_data.dart';
import 'package:fluento/models/learning_models.dart';
import 'package:fluento/screens/module_screen.dart';

class ReadingScreen extends StatelessWidget {
  const ReadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final progress = moduleProgressValues['Reading'] ??
        const ModuleProgress(title: 'Reading Progress', completed: 0, total: 0);

    return ModuleScreen(
      moduleName: 'Reading',
      subtitle: 'Improve your reading skills step by step',
      icon: Icons.menu_book_rounded,
      features: readingFeatures,
      lessons: readingLessons,
      progress: progress,
    );
  }
}
