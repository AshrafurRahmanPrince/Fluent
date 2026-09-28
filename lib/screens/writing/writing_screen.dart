import 'package:flutter/material.dart';
import 'package:fluento/data/module_data.dart';
import 'package:fluento/models/learning_models.dart';
import 'package:fluento/screens/module_screen.dart';

class WritingScreen extends StatelessWidget {
  const WritingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final progress = moduleProgressValues['Writing'] ??
        const ModuleProgress(title: 'Writing Progress', completed: 0, total: 0);

    return ModuleScreen(
      moduleName: 'Writing',
      subtitle: 'Build your writing skills with practice',
      icon: Icons.edit_note_rounded,
      features: writingFeatures,
      lessons: writingLessons,
      progress: progress,
    );
  }
}
