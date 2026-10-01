import 'package:flutter/material.dart';
import '../../data/ielts_reading_tests.dart';
import '../../models/reading_models.dart';
import 'ielts_reading_test_screen.dart';

class ReadingScreen extends StatelessWidget {
  const ReadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: colors.onSurface,
        title: const Text('IELTS Reading'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
        children: [
          Text(
            'Reading Practice Tests',
            style: TextStyle(
              color: colors.onSurface,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Choose an Academic or General Training test.',
            style: TextStyle(color: colors.onSurface.withValues(alpha: 0.72)),
          ),
          const SizedBox(height: 22),
          for (final category in IELTSReadingCategory.values) ...[
            Text(
              category.label,
              style: TextStyle(
                color: colors.primary,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            for (final test in ieltsReadingTests.where(
              (test) => test.category == category,
            )) ...[
              _ReadingTestTile(test: test),
              const SizedBox(height: 10),
            ],
            const SizedBox(height: 14),
          ],
        ],
      ),
    );
  }
}

class _ReadingTestTile extends StatelessWidget {
  const _ReadingTestTile({required this.test});

  final IELTSReadingTest test;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Material(
      color: colors.surface,
      borderRadius: BorderRadius.circular(14),
      child: ListTile(
        leading: Icon(Icons.menu_book_rounded, color: colors.primary),
        title: Text(test.title),
        subtitle: Text(
          '${test.passage.title} · ${test.questions.length} questions',
        ),
        trailing: Icon(Icons.chevron_right_rounded, color: colors.onSurface),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => IELTSReadingTestScreen(test: test),
          ),
        ),
      ),
    );
  }
}
