import 'package:flutter/material.dart';

class ProgressCard extends StatelessWidget {
  const ProgressCard({
    required this.title,
    required this.progress,
    required this.completedCount,
    required this.totalCount,
    this.completedLabel = 'lessons',
    super.key,
  });

  final String title;
  final double progress;
  final int completedCount;
  final int totalCount;
  final String completedLabel;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final int percentage = (progress * 100).round();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: colors.onSurface,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          LayoutBuilder(
            builder: (context, constraints) {
              final percentageText = Text(
                '$percentage%',
                style: TextStyle(
                  color: colors.primary,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              );
              final completedText = Text(
                '$completedCount of $totalCount $completedLabel completed',
                style: TextStyle(
                  color: colors.onSurface.withValues(alpha: 0.68),
                  fontSize: 13,
                ),
              );

              if (constraints.maxWidth < 360) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [percentageText, completedText],
                );
              }

              return Row(
                children: [
                  percentageText,
                  const Spacer(),
                  completedText,
                ],
              );
            },
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 10,
              backgroundColor: colors.onSurface.withValues(alpha: 0.12),
              valueColor: AlwaysStoppedAnimation<Color>(colors.primary),
            ),
          ),
        ],
      ),
    );
  }
}
