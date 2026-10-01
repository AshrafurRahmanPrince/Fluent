import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fluento/data/ielts_reading_tests.dart';
import 'package:fluento/screens/reading/reading_experience_screen.dart';
import 'package:fluento/screens/reading/ielts_reading_test_screen.dart';
import 'package:fluento/screens/reading/reading_screen.dart';
import 'package:fluento/services/user_progress_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('Reading module lists only IELTS Academic and General tests',
      (tester) async {
    await tester.pumpWidget(const MaterialApp(home: ReadingScreen()));

    expect(find.text('Academic Reading'), findsOneWidget);
    expect(find.text('General Training Reading'), findsOneWidget);
    expect(find.text('Academic Reading Test 1'), findsOneWidget);
    expect(find.text('General Training Reading Test 1'), findsOneWidget);
    expect(find.text('Vocabulary Builder'), findsNothing);
    expect(find.text('Skimming Practice'), findsNothing);
  });

  testWidgets('every Reading lesson opens a passage and questions',
      (tester) async {
    const lessonTitles = [
      'Academic Reading Test 1',
      'Academic Reading Test 2',
      'Academic Reading Test 3',
      'General Training Reading Test 1',
      'General Training Reading Test 2',
      'General Training Reading Test 3',
    ];

    await tester.pumpWidget(const MaterialApp(home: ReadingScreen()));

    for (final title in lessonTitles) {
      final lessonCard = find.text(title).last;
      await tester.ensureVisible(lessonCard);
      await tester.pumpAndSettle();
      await tester.tap(lessonCard);
      await tester.pumpAndSettle();

      expect(find.text('Full reading passage'), findsOneWidget);
      await tester.drag(find.byType(ListView).last, const Offset(0, -700));
      await tester.pumpAndSettle();
      expect(find.text(title), findsWidgets);
      expect(find.text('Questions 1-3'), findsOneWidget);
      expect(find.text('Questions 4-6'), findsOneWidget);
      expect(find.text('Submit IELTS Reading Test'), findsOneWidget);
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

  testWidgets('IELTS Reading validates all question types and records a score',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: IELTSReadingTestScreen(test: ieltsReadingTests.first),
      ),
    );

    expect(find.text('How University Libraries Are Changing'), findsOneWidget);
    expect(find.text('Full reading passage'), findsOneWidget);
    await tester.drag(find.byType(ListView).last, const Offset(0, -700));
    await tester.pumpAndSettle();
    final firstSection = find.text('Questions 1-3');
    await tester.ensureVisible(firstSection);
    await tester.pumpAndSettle();
    expect(find.byType(TextField), findsOneWidget);

    const answerInteractions = [
      ('They have changed research practices but have not removed other library functions.', false),
      ('FALSE', false),
      ('peer reviewed', true),
      ('perspectives', true),
      ('Licensing agreements may limit use.', false),
      ('NOT GIVEN', false),
    ];
    var completionFieldIndex = 0;
    for (var questionIndex = 0;
        questionIndex < answerInteractions.length;
        questionIndex++) {
      final (answer, isTextEntry) = answerInteractions[questionIndex];
      if (questionIndex == 3) {
        await tester.drag(find.byType(ListView).last, const Offset(0, -700));
        await tester.pumpAndSettle();
      }
      if (isTextEntry) {
        completionFieldIndex++;
        final field = find.byKey(ValueKey('reading-answer-$questionIndex'));
        await tester.ensureVisible(field);
        await tester.enterText(field, answer);
      } else {
        final option = find.text(answer).last;
        await tester.ensureVisible(option);
        await tester.tap(option);
      }
      await tester.pumpAndSettle();

      final checkButton = find.text('Check answer').at(questionIndex);
      await tester.ensureVisible(checkButton);
      await tester.tap(checkButton);
      await tester.pumpAndSettle();
      expect(find.text('Correct').at(questionIndex), findsOneWidget);
    }

    final submitButton = find.text('Submit IELTS Reading Test');
    await tester.ensureVisible(submitButton);
    await tester.tap(submitButton);
    await tester.pumpAndSettle();

    expect(find.text('Score: 6 / 6 correct  ·  6 / 6 checked'), findsOneWidget);
    expect(find.text('Back to reading tests'), findsOneWidget);
    final progress = await UserProgressService.instance.getProfileProgress();
    expect(progress.completedLessons, 1);
  });

  testWidgets('IELTS reading tests fit a mobile viewport',
      (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const MaterialApp(home: ReadingScreen()));
    const readingItems = [
      'Academic Reading Test 1',
      'Academic Reading Test 2',
      'Academic Reading Test 3',
      'General Training Reading Test 1',
      'General Training Reading Test 2',
      'General Training Reading Test 3',
    ];

    for (final title in readingItems) {
      final item = find.text(title).last;
      await tester.ensureVisible(item);
      await tester.pumpAndSettle();
      await tester.tap(item);
      await tester.pumpAndSettle();

      final pageScroll = find.byType(ListView).last;
      await tester.drag(pageScroll, const Offset(0, -900));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull,
          reason: '$title should fit on mobile');

      await tester.pageBack();
      await tester.pumpAndSettle();
    }
  });

  testWidgets('IELTS Reading passage fits a mobile viewport when opened directly',
      (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp(
        home: IELTSReadingTestScreen(test: ieltsReadingTests.first),
      ),
    );
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
  });
}
