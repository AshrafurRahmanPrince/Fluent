import 'package:fluento/data/speaking_content.dart';
import 'package:fluento/data/module_data.dart';
import 'package:fluento/models/learning_models.dart';
import 'package:fluento/screens/module_screen.dart';
import 'package:fluento/screens/speaking/speaking_activity_screen.dart';
import 'package:fluento/screens/speaking/speaking_lesson_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  const ttsChannel = MethodChannel('flutter_tts');

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(ttsChannel, (_) async => null);
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(ttsChannel, null);
  });

  test('speaking catalog covers each requested content set', () {
    expect(pronunciationWords, hasLength(15));
    expect(repeatSentences, hasLength(15));
    expect(conversationScenarios, hasLength(10));
    expect(speakingTopics, hasLength(20));
    expect(speakingQuestions, hasLength(30));
    expect(commonPhrases, hasLength(55));
    expect(speakingLessonContent, hasLength(6));
  });

  testWidgets('all Speaking skill screens render on a phone viewport',
      (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    const features = [
      'Pronunciation Practice',
      'Repeat After Me',
      'Daily Conversation',
      'Speaking Topics',
      'Question & Answer',
      'Role Play',
      'Common Phrases',
    ];

    for (final feature in features) {
      await tester.pumpWidget(MaterialApp(
        home: SpeakingActivityScreen(featureTitle: feature),
      ));
      await tester.pumpAndSettle();
      expect(find.text(feature), findsOneWidget);
      expect(tester.takeException(), isNull, reason: feature);
    }
  });

  testWidgets('all Speaking lessons render with their own lesson content',
      (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    for (final lesson in speakingLessons) {
      await tester.pumpWidget(MaterialApp(
        home: SpeakingLessonScreen(lesson: lesson),
      ));
      await tester.pumpAndSettle();
      expect(find.text(lesson.title), findsWidgets);
      expect(find.text('Learning objectives'), findsOneWidget);
      expect(find.text('Final challenge'), findsOneWidget);
      expect(tester.takeException(), isNull, reason: lesson.title);
    }
  });

  testWidgets('Speaking feature and lesson cards open dedicated screens',
      (tester) async {
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(const MaterialApp(
      home: ModuleScreen(
        moduleName: 'Speaking',
        subtitle: 'Practice speaking confidently',
        icon: Icons.mic_rounded,
        features: speakingFeatures,
        lessons: speakingLessons,
        progress:
            ModuleProgress(title: 'Speaking Progress', completed: 0, total: 13),
      ),
    ));

    final skill = find.text('Pronunciation Practice');
    await tester.ensureVisible(skill);
    await tester.tap(skill);
    await tester.pumpAndSettle();
    expect(find.text('Word 1'), findsOneWidget);

    await tester.pageBack();
    await tester.pumpAndSettle();
    final lesson = find.text('Introducing Yourself');
    await tester.ensureVisible(lesson);
    await tester.tap(lesson);
    await tester.pumpAndSettle();
    expect(find.text('Learning objectives'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
