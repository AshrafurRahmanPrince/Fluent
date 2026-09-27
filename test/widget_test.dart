// widget_test.dart — A basic smoke test that checks the app launches.
// Run with: flutter test

import 'package:flutter_test/flutter_test.dart';
import 'package:fluento/main.dart';

void main() {
  testWidgets('Fluent app launches and shows splash screen',
      (WidgetTester tester) async {
    // Build the app widget tree
    await tester.pumpWidget(const FluentApp());

    // Verify the app name is present on the splash screen
    expect(find.text('Fluent'), findsWidgets);
  });
}
