import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fluento/screens/reading/reading_experience_screen.dart';
import 'package:fluento/screens/reading/reading_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('every Reading skill opens its learning page', (tester) async {
    const skills = {
      'Vocabulary Builder': 'Choose a category and word',
      'Reading Comprehension': 'Choose your level',
      'Skimming Practice': 'How to skim',
      'Scanning Practice': 'How to scan',
      'Grammar in Reading': 'Grammar topic',
      'Daily Reading': 'Today’s reading',
    };

    await tester.pumpWidget(const MaterialApp(home: ReadingScreen()));

    for (final entry in skills.entries) {
      final skillCard = find.text(entry.key).first;
      await tester.ensureVisible(skillCard);
      await tester.pumpAndSettle();
      await tester.tap(skillCard);
      await tester.pumpAndSettle();

      expect(find.text(entry.key), findsWidgets);
      expect(find.text(entry.value), findsOneWidget);
      expect(tester.takeException(), isNull);

      await tester.pageBack();
      await tester.pumpAndSettle();
    }
  });

  testWidgets('every Reading lesson opens a passage and questions',
      (tester) async {
    const lessonTitles = [
      'Daily Life',
      'Travel',
      'Education',
      'Technology',
      'Environment',
      'Communication',
    ];

    await tester.pumpWidget(const MaterialApp(home: ReadingScreen()));

    for (final title in lessonTitles) {
      final lessonCard = find.text(title).last;
      await tester.ensureVisible(lessonCard);
      await tester.pumpAndSettle();
      await tester.tap(lessonCard);
      await tester.pumpAndSettle();

      expect(find.text('Reading Lesson'), findsOneWidget);
      expect(find.text('Reading passage'), findsOneWidget);
      expect(find.text('Comprehension questions'), findsOneWidget);
      expect(find.text('Mark lesson complete'), findsOneWidget);
      expect(tester.takeException(), isNull);

      await tester.pageBack();
      await tester.pumpAndSettle();
    }
  });

  testWidgets('comprehension answers show correctness and explanation',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: ReadingExperienceScreen(skillTitle: 'Reading Comprehension'),
      ),
    );

    final wrongAnswer = find.text('A university exam').last;
    await tester.ensureVisible(wrongAnswer);
    await tester.tap(wrongAnswer);
    await tester.pumpAndSettle();

    final checkButton =
        find.widgetWithText(ElevatedButton, 'Check answer').first;
    await tester.ensureVisible(checkButton);
    await tester.tap(checkButton);
    await tester.pumpAndSettle();

    expect(find.text('✗ Incorrect'), findsOneWidget);
    expect(find.textContaining('The passage describes Mina’s activities'),
        findsOneWidget);

    final correctAnswer = find.text('Mina’s daily routine').last;
    await tester.ensureVisible(correctAnswer);
    await tester.tap(correctAnswer);
    await tester.pumpAndSettle();
    await tester.ensureVisible(checkButton);
    await tester.tap(checkButton);
    await tester.pumpAndSettle();

    expect(find.text('✓ Correct'), findsOneWidget);
  });

  testWidgets('vocabulary practice checks choices, blanks, and word meanings',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: ReadingExperienceScreen(skillTitle: 'Vocabulary Builder'),
      ),
    );

    expect(find.byType(Radio<String>), findsNWidgets(4));
    final correctMeaning =
        find.text('The usual way you do things each day.').last;
    await tester.ensureVisible(correctMeaning);
    await tester.tap(correctMeaning);
    await tester.pumpAndSettle();
    final checkAnswer = find.widgetWithText(ElevatedButton, 'Check answer');
    await tester.ensureVisible(checkAnswer);
    await tester.tap(checkAnswer);
    await tester.pumpAndSettle();
    expect(find.text('✓ Correct'), findsOneWidget);

    final fillField = find.byType(TextField);
    await tester.ensureVisible(fillField);
    await tester.enterText(fillField, 'routine');
    final checkWord = find.widgetWithText(ElevatedButton, 'Check word');
    await tester.ensureVisible(checkWord);
    await tester.tap(checkWord);
    await tester.pumpAndSettle();
    expect(
      find.text('Correct! “routine” completes the sentence.'),
      findsOneWidget,
    );

    final meaningDropdown = find.byType(DropdownButtonFormField<String>).last;
    await tester.ensureVisible(meaningDropdown);
    await tester.tap(meaningDropdown);
    await tester.pumpAndSettle();
    await tester.tap(find.text('The usual way you do things each day.').last);
    await tester.pumpAndSettle();
    final checkMatch = find.widgetWithText(ElevatedButton, 'Check match');
    await tester.ensureVisible(checkMatch);
    await tester.tap(checkMatch);
    await tester.pumpAndSettle();
    expect(find.textContaining('Correct! routine means'), findsOneWidget);
  });

  testWidgets('skimming challenge shows passage before its question',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: ReadingExperienceScreen(skillTitle: 'Skimming Practice'),
      ),
    );

    final startButton = find.widgetWithText(OutlinedButton, 'Start');
    await tester.ensureVisible(startButton);
    await tester.tap(startButton);
    await tester.pumpAndSettle();

    expect(find.text('Time is up. Take your time to answer.'), findsNothing);
    expect(find.text('Answer now'), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Check answer'), findsOneWidget);
    expect(find.text('Passage read. Answer when ready.'), findsNothing);

    await tester.tap(find.widgetWithText(OutlinedButton, 'Answer now'));
    await tester.pumpAndSettle();

    expect(find.text('Passage read. Answer when ready.'), findsOneWidget);
    expect(
        find.widgetWithText(ElevatedButton, 'Check answer'), findsNWidgets(2));
  });

  testWidgets('daily reading saves completion and updates its streak',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
          home: ReadingExperienceScreen(skillTitle: 'Daily Reading')),
    );

    expect(find.text('Complete a reading today to start your streak.'),
        findsOneWidget);

    const answers = [
      'Mina’s daily routine',
      'She prepares breakfast and packs her books.',
      'True',
    ];
    for (var index = 0; index < answers.length; index++) {
      final answer = find.text(answers[index]).last;
      await tester.ensureVisible(answer);
      await tester.tap(answer);
      await tester.pumpAndSettle();

      final checkButton =
          find.widgetWithText(ElevatedButton, 'Check answer').at(index);
      await tester.ensureVisible(checkButton);
      await tester.tap(checkButton);
      await tester.pumpAndSettle();
    }

    final completeButton =
        find.widgetWithText(ElevatedButton, 'Complete today’s reading');
    await tester.ensureVisible(completeButton);
    expect(tester.widget<ElevatedButton>(completeButton).onPressed, isNotNull);
    await tester.tap(completeButton);
    await tester.pumpAndSettle();

    expect(find.text('✓ Reading completed'), findsOneWidget);
    expect(find.text('Daily Reading Streak: 1 day'), findsOneWidget);
  });

  testWidgets(
      'completed lesson remains completed after returning and reopening',
      (tester) async {
    await tester.pumpWidget(const MaterialApp(home: ReadingScreen()));

    final dailyLifeCard = find.text('Daily Life').last;
    await tester.ensureVisible(dailyLifeCard);
    await tester.pumpAndSettle();
    await tester.tap(dailyLifeCard);
    await tester.pumpAndSettle();

    const answers = [
      'Mina’s daily routine',
      'She prepares breakfast and packs her books.',
      'True',
      'In the morning',
    ];
    for (var index = 0; index < answers.length; index++) {
      final answer = find.text(answers[index]).last;
      await tester.ensureVisible(answer);
      await tester.tap(answer);
      await tester.pumpAndSettle();

      final checkButton =
          find.widgetWithText(ElevatedButton, 'Check answer').at(index);
      await tester.ensureVisible(checkButton);
      await tester.tap(checkButton);
      await tester.pumpAndSettle();
    }

    final completeButton =
        find.widgetWithText(ElevatedButton, 'Mark lesson complete');
    await tester.ensureVisible(completeButton);
    await tester.tap(completeButton);
    await tester.pumpAndSettle();
    expect(find.text('✓ Completed'), findsOneWidget);

    await tester.pumpWidget(const MaterialApp(home: ReadingScreen()));
    await tester.pumpAndSettle();
    expect(find.text('✓ Completed'), findsOneWidget);
  });

  testWidgets('Reading skills and lessons fit a mobile viewport',
      (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const MaterialApp(home: ReadingScreen()));
    const readingItems = [
      'Vocabulary Builder',
      'Reading Comprehension',
      'Skimming Practice',
      'Scanning Practice',
      'Grammar in Reading',
      'Daily Reading',
      'Daily Life',
      'Travel',
      'Education',
      'Technology',
      'Environment',
      'Communication',
    ];

    for (final title in readingItems) {
      final item = find.text(title).last;
      await tester.ensureVisible(item);
      await tester.pumpAndSettle();
      await tester.tap(item);
      await tester.pumpAndSettle();

      final pageScroll = find.byType(SingleChildScrollView).last;
      await tester.drag(pageScroll, const Offset(0, -900));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull,
          reason: '$title should fit on mobile');

      await tester.pageBack();
      await tester.pumpAndSettle();
    }
  });

  testWidgets('Vocabulary Builder fits a mobile viewport when opened directly',
      (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      const MaterialApp(
        home: ReadingExperienceScreen(skillTitle: 'Vocabulary Builder'),
      ),
    );
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
  });
}
