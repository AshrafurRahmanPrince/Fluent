import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluento/screens/settings_screen.dart';
import 'package:fluento/services/theme_provider.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test('theme preference defaults to dark and persists changes', () async {
    final provider = ThemeProvider();
    await provider.loadPreference();

    expect(provider.isDarkMode, isTrue);
    expect(provider.themeMode, ThemeMode.dark);

    await provider.setDarkMode(false);

    final restoredProvider = ThemeProvider();
    await restoredProvider.loadPreference();
    expect(restoredProvider.isDarkMode, isFalse);
    expect(restoredProvider.themeMode, ThemeMode.light);
  });

  testWidgets('Settings switch updates the app theme immediately',
      (WidgetTester tester) async {
    final provider = ThemeProvider();
    await provider.loadPreference();

    await tester.pumpWidget(
      AnimatedBuilder(
        animation: provider,
        builder: (context, _) => MaterialApp(
          theme: ThemeProvider.lightTheme,
          darkTheme: ThemeProvider.darkTheme,
          themeMode: provider.themeMode,
          home: SettingsScreen(themeProvider: provider),
        ),
      ),
    );

    expect(
      Theme.of(tester.element(find.byType(SettingsScreen))).brightness,
      Brightness.dark,
    );

    final darkModeSwitch = find.ancestor(
      of: find.text('Dark Mode'),
      matching: find.byType(SwitchListTile),
    );
    await tester.tap(darkModeSwitch);
    await tester.pumpAndSettle();

    expect(provider.isDarkMode, isFalse);
    expect(
      Theme.of(tester.element(find.byType(SettingsScreen))).brightness,
      Brightness.light,
    );
    expect(
      tester.widget<SwitchListTile>(darkModeSwitch).value,
      isFalse,
    );
  });
}
