// widget_test.dart — Smoke tests for the Fluent learning app.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluento/main.dart';
import 'package:fluento/screens/home_screen.dart';
import 'package:fluento/screens/login_screen.dart';
import 'package:fluento/screens/profile_screen.dart';
import 'package:fluento/screens/writing/writing_screen.dart';
import 'package:fluento/services/user_progress_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('Fluent app routes unauthenticated users to login',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      FluentApp(authStateChanges: Stream<User?>.value(null)),
    );
    expect(find.text('Fluent'), findsOneWidget);
    await tester.pump(const Duration(seconds: 2));
    expect(find.text('Fluent'), findsOneWidget);
    await tester.pump(const Duration(milliseconds: 600));
    await tester.pumpAndSettle();

    expect(find.text('Welcome Back!'), findsOneWidget);
  });

  testWidgets('Firebase initialization failure falls back to login',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      FluentApp(firebaseInitialization: Future<bool>.value(false)),
    );
    await tester.pump(const Duration(milliseconds: 2600));
    await tester.pumpAndSettle();

    expect(find.text('Welcome Back!'), findsOneWidget);
  });

  testWidgets('Fluent app routes authenticated users to Home',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      FluentApp(authStateChanges: Stream<User?>.value(const _TestUser())),
    );
    await tester.pump(const Duration(milliseconds: 2600));
    await tester.pumpAndSettle();

    expect(find.text('Core Modules'), findsOneWidget);
    expect(find.text('Welcome, Ashrafuzzaman Prince!'), findsOneWidget);
  });

  testWidgets('Home greeting updates when the auth user changes',
      (WidgetTester tester) async {
    final userChanges = StreamController<User?>.broadcast();
    addTearDown(userChanges.close);

    await tester.pumpWidget(FluentApp(authStateChanges: userChanges.stream));
    await tester.pump(const Duration(milliseconds: 2600));
    userChanges.add(const _TestUser());
    await tester.pumpAndSettle();
    expect(find.text('Welcome, Ashrafuzzaman Prince!'), findsOneWidget);

    userChanges.add(const _TestUser(displayName: 'Alex Learner'));
    await tester.pumpAndSettle();
    expect(find.text('Welcome, Alex Learner!'), findsOneWidget);
  });

  testWidgets('Profile displays Firebase identity and logout control',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: ProfileScreen(user: _TestUser())),
    );
    await tester.pumpAndSettle();

    expect(find.text('Ashrafuzzaman Prince'), findsOneWidget);
    expect(find.text('prince@example.com'), findsOneWidget);
    expect(find.widgetWithText(OutlinedButton, 'Log Out'), findsOneWidget);
    expect(find.text('Average Score'), findsOneWidget);
    expect(find.text('Lessons'), findsOneWidget);
    expect(find.text('Intermediate Learner'), findsNothing);
    expect(find.text('Quiz champion'), findsNothing);
  });

  testWidgets('Profile falls back to the email name when display name is empty',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: ProfileScreen(
          user: _TestUser(displayName: null, email: 'alex.learner@example.com'),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('alex.learner'), findsOneWidget);
    expect(find.text('alex.learner@example.com'), findsOneWidget);
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

  testWidgets('Home progress starts at zero and updates after an activity',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));
    await tester.pumpAndSettle();

    expect(find.text('0 today'), findsOneWidget);
    expect(
        find.text('Lessons 0  ·  Quizzes 0  ·  Activities 0'), findsOneWidget);

    await UserProgressService.instance.logDailyActivity(activityType: 'quiz');
    await tester.pumpAndSettle();

    expect(find.text('1 today'), findsOneWidget);
    expect(
        find.text('Lessons 0  ·  Quizzes 1  ·  Activities 0'), findsOneWidget);
  });

  testWidgets('Dashboard opens the daily quiz, profile, and settings',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

    await tester.tap(find.text('Daily Quiz').first);
    await tester.pumpAndSettle();
    expect(find.text("Today's IELTS Challenge"), findsOneWidget);
    expect(find.text('Question 1 of 10'), findsOneWidget);
    await tester.tap(find.byType(OutlinedButton).first);
    await tester.pumpAndSettle();
    expect(
      find.text('Correct').evaluate().isNotEmpty ||
          find.textContaining('Not quite. The answer is').evaluate().isNotEmpty,
      isTrue,
    );
    final nextButton = find.text('Next');
    await tester.ensureVisible(nextButton);
    await tester.tap(nextButton);
    await tester.pumpAndSettle();
    expect(find.text('Question 2 of 10'), findsOneWidget);
    await tester.pageBack();
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();
    expect(find.widgetWithText(AppBar, 'Profile'), findsOneWidget);
    await tester.pageBack();
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Settings'));
    await tester.pumpAndSettle();
    expect(find.widgetWithText(AppBar, 'Settings'), findsOneWidget);
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
    final logIn = find.text('Already have an account? Log In');
    await tester.ensureVisible(logIn);
    await tester.tap(logIn);
    await tester.pumpAndSettle();

    expect(find.text('Welcome Back!'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Login rejects malformed email addresses',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

    await tester.enterText(find.byType(TextFormField).first, 'user@invalid');
    await tester.enterText(find.byType(TextFormField).last, 'password');
    await tester.tap(find.text('Log In'));
    await tester.pumpAndSettle();

    expect(find.text('Enter a valid email address'), findsOneWidget);
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

class _TestUser implements User {
  final String? _displayName;
  final String? _email;

  const _TestUser({
    String? displayName = 'Ashrafuzzaman Prince',
    String? email = 'prince@example.com',
  })  : _displayName = displayName,
        _email = email;

  @override
  String? get displayName => _displayName;

  @override
  String? get email => _email;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
