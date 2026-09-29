// widget_test.dart — Smoke tests for the Fluent learning app.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fluento/main.dart';
import 'package:fluento/screens/home_screen.dart';
import 'package:fluento/screens/login_screen.dart';
import 'package:fluento/screens/writing/writing_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('Fluent app launches and shows splash screen',
      (WidgetTester tester) async {
    await tester.pumpWidget(const FluentApp());
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('Fluent'), findsWidgets);
  });

  testWidgets('Home screen core modules open the reading screen',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

    expect(find.text('Core Modules'), findsOneWidget);
    final readingCard = find.widgetWithText(ModuleCardImage, 'Reading');
    await tester.ensureVisible(readingCard);
    await tester.pumpAndSettle();
    await tester.tap(readingCard);
    await tester.pumpAndSettle();

    expect(find.text('Reading'), findsWidgets);
  });

  testWidgets('Login screen scrolls on a short screen and opens registration',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(390, 400);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const MaterialApp(home: LoginScreen()));
    expect(tester.takeException(), isNull);

    final signUp = find.text('Sign Up');
    await tester.ensureVisible(signUp);
    await tester.tap(signUp);
    await tester.pumpAndSettle();

    expect(find.widgetWithText(AppBar, 'Create Account'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Writing skill page shows educational sentence-building content',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: WritingScreen()));

    await tester.tap(find.text('Sentence Building'));
    await tester.pumpAndSettle();

    expect(find.text('Sentence Building'), findsWidgets);
    expect(find.text('Learn how to build correct English sentences.'),
        findsOneWidget);
    expect(find.text('Subject + Verb + Object'), findsOneWidget);
  });
}
