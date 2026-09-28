import 'package:flutter/material.dart';
import 'package:fluento/models/learning_models.dart';

class LessonCard extends StatelessWidget {
  const LessonCard({
    required this.lesson,
    required this.onTap,
    super.key,
  });

  final Lesson lesson;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFF7F3E9),
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFF2D6A4F).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    lesson.title.substring(0, 2).toUpperCase(),
                    style: const TextStyle(
                      color: Color(0xFF0F3822),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lesson.title,
                      style: const TextStyle(
                        color: Color(0xFF1C2A23),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Text(
                          lesson.level,
                          style: TextStyle(
                            color: const Color(0xFF1C2A23).withValues(alpha: 0.7),
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          '${lesson.duration} min',
                          style: TextStyle(
                            color: const Color(0xFF1C2A23).withValues(alpha: 0.7),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: lesson.completed
                      ? const Color(0xFF3E8E55).withValues(alpha: 0.14)
                      : const Color(0xFF0F3822).withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  lesson.completed ? '✓' : 'Start',
                  style: TextStyle(
                    color: lesson.completed
                        ? const Color(0xFF3E8E55)
                        : const Color(0xFF0F3822),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
