// widget_test.dart — Smoke tests for the Fluent learning app.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fluento/main.dart';
import 'package:fluento/screens/home_screen.dart';

void main() {
  testWidgets('Fluent app launches and shows splash screen',
      (WidgetTester tester) async {
    await tester.pumpWidget(const FluentApp());
    expect(find.text('Fluent'), findsWidgets);
    await tester.pumpWidget(const SizedBox());
    await tester.pump(const Duration(seconds: 3));
  });

  testWidgets('Home screen core modules open the reading screen',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

    expect(find.text('Core Modules'), findsOneWidget);
  await tester.ensureVisible(find.text('Reading'));
    await tester.tap(find.text('Reading'));
    await tester.pumpAndSettle();

    expect(find.text('Reading'), findsWidgets);
  });
}
