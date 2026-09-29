import 'package:flutter/material.dart';
import 'package:fluento/data/module_data.dart';
import 'package:fluento/models/learning_models.dart';
import 'package:fluento/screens/module_screen.dart';

class SpeakingScreen extends StatelessWidget {
  const SpeakingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final progress = moduleProgressValues['Speaking'] ??
        const ModuleProgress(
            title: 'Speaking Progress', completed: 0, total: 0);

    return ModuleScreen(
      moduleName: 'Speaking',
      subtitle: 'Practice speaking confidently',
      icon: Icons.mic_rounded,
      features: speakingFeatures,
      lessons: speakingLessons,
      progress: progress,
    );
  }
}
