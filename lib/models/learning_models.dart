import 'package:flutter/material.dart';

class LearningFeature {
  const LearningFeature({
    required this.title,
    required this.description,
    required this.icon,
  });

  final String title;
  final String description;
  final IconData icon;
}

class Lesson {
  const Lesson({
    required this.title,
    required this.level,
    required this.duration,
    required this.completed,
    this.summary,
  });

  final String title;
  final String level;
  final int duration;
  final bool completed;
  final String? summary;
}

class ModuleProgress {
  const ModuleProgress({
    required this.title,
    required this.completed,
    required this.total,
  });

  final String title;
  final int completed;
  final int total;

  double get percent => total == 0 ? 0.0 : completed / total;
}
