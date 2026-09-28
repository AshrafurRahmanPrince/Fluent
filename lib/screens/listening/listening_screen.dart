import 'package:flutter/material.dart';
import 'package:fluento/data/module_data.dart';
import 'package:fluento/models/learning_models.dart';
import 'package:fluento/screens/module_screen.dart';

class ListeningScreen extends StatelessWidget {
  const ListeningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final progress = moduleProgressValues['Listening'] ??
        const ModuleProgress(title: 'Listening Progress', completed: 0, total: 0);

    return ModuleScreen(
      moduleName: 'Listening',
      subtitle: 'Train your ears to understand English',
      icon: Icons.headphones_rounded,
      features: listeningFeatures,
      lessons: listeningLessons,
      progress: progress,
    );
  }
}
