import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  static const _preferenceKey = 'fluent_dark_mode';
  static final ThemeProvider instance = ThemeProvider();

  final Future<SharedPreferences> Function() _preferencesProvider;
  bool _isDarkMode = true;
  bool _hasLoadedPreference = false;

  ThemeProvider({
    Future<SharedPreferences> Function()? preferencesProvider,
  }) : _preferencesProvider =
            preferencesProvider ?? SharedPreferences.getInstance;

  bool get isDarkMode => _isDarkMode;
  bool get hasLoadedPreference => _hasLoadedPreference;
  ThemeMode get themeMode => _isDarkMode ? ThemeMode.dark : ThemeMode.light;

  Future<void> loadPreference() async {
    if (_hasLoadedPreference) return;
    try {
      final preferences = await _preferencesProvider();
      _isDarkMode = preferences.getBool(_preferenceKey) ?? true;
    } catch (error, stackTrace) {
      debugPrint('Unable to load saved theme preference: $error');
      debugPrintStack(stackTrace: stackTrace);
    }
    _hasLoadedPreference = true;
    notifyListeners();
  }

  Future<void> setDarkMode(bool enabled) async {
    if (_isDarkMode != enabled) {
      _isDarkMode = enabled;
      notifyListeners();
    }

    try {
      final preferences = await _preferencesProvider();
      await preferences.setBool(_preferenceKey, enabled);
    } catch (error, stackTrace) {
      debugPrint('Unable to save theme preference: $error');
      debugPrintStack(stackTrace: stackTrace);
    }
  }

  static ThemeData get lightTheme {
    const background = Color(0xFFF7F9F6);
    const surface = Color(0xFFFFFFFF);
    const surfaceContainer = Color(0xFFE9F0EA);
    const text = Color(0xFF1C2A23);
    const accent = Color(0xFF287A49);
    final colors = ColorScheme.fromSeed(
      seedColor: accent,
      brightness: Brightness.light,
    ).copyWith(
      primary: accent,
      onPrimary: Colors.white,
      secondary: const Color(0xFF2D6A4F),
      surface: surface,
      onSurface: text,
      surfaceContainer: surfaceContainer,
    );

    return ThemeData(
      colorScheme: colors,
      scaffoldBackgroundColor: background,
      useMaterial3: true,
      appBarTheme: const AppBarTheme(
        backgroundColor: background,
        foregroundColor: text,
        elevation: 0,
      ),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: text, fontFamily: 'sans-serif'),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        labelStyle: const TextStyle(color: text),
        hintStyle: const TextStyle(color: Color(0xFF68776D)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: accent,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    const background = Color(0xFF121212);
    const surface = Color(0xFF1E293B);
    const accentSurface = Color(0xFF064E3B);
    const text = Color(0xFFF8FAFC);
    const accent = Color(0xFF34D399);
    final colors = ColorScheme.fromSeed(
      seedColor: accent,
      brightness: Brightness.dark,
    ).copyWith(
      primary: accent,
      onPrimary: const Color(0xFF052E24),
      secondary: const Color(0xFF4ADE80),
      surface: surface,
      onSurface: text,
      surfaceContainer: accentSurface,
    );

    return ThemeData(
      colorScheme: colors,
      scaffoldBackgroundColor: background,
      useMaterial3: true,
      appBarTheme: const AppBarTheme(
        backgroundColor: background,
        foregroundColor: text,
        elevation: 0,
      ),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: text, fontFamily: 'sans-serif'),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        labelStyle: const TextStyle(color: text),
        hintStyle: const TextStyle(color: Color(0xFFCBD5E1)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: accentSurface,
          foregroundColor: text,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}

extension FluentThemeColors on BuildContext {
  Color get pageBackground => Theme.of(this).scaffoldBackgroundColor;
  Color get cardSurface => Theme.of(this).colorScheme.surface;
  Color get accentSurface => Theme.of(this).colorScheme.surfaceContainer;
  Color get primaryText => Theme.of(this).colorScheme.onSurface;
  Color get mutedText =>
      Theme.of(this).colorScheme.onSurface.withValues(alpha: 0.72);
  Color get accentColor => Theme.of(this).colorScheme.primary;
  Color get onAccentColor => Theme.of(this).colorScheme.onPrimary;
}
