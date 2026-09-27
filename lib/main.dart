// main.dart — The entry point of every Flutter application.
// Flutter calls runApp() to inflate the root widget tree.

import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  // runApp() takes a Widget and makes it the root of the widget tree.
  runApp(const FluentApp());
}

// A StatelessWidget is a widget that never changes after it is built.
// MaterialApp provides navigation, theming, and many Material Design widgets.
class FluentApp extends StatelessWidget {
  const FluentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // The title shown in the system app switcher
      title: 'Fluent',

      // Hide the debug banner in the top-right corner
      debugShowCheckedModeBanner: false,

      // ThemeData lets you define app-wide visual properties
      theme: ThemeData(
        // The primary seed color drives Material 3 color generation
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF3E8E55), // Leaf Green
          brightness: Brightness.dark,
        ),
        // Set the global scaffold (screen) background to Deep Forest Green
        scaffoldBackgroundColor: const Color(0xFF0F3822),

        // Use Material 3 design spec
        useMaterial3: true,

        // Apply a rounded, modern font feel globally
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            color: Color(0xFFFDFBF7), // Soft Warm Cream for all body text
            fontFamily: 'sans-serif',
          ),
        ),

        // Style all ElevatedButtons app-wide
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF3E8E55),
            foregroundColor: const Color(0xFFFDFBF7),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        // Style all InputFields app-wide
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFFFDFBF7),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          labelStyle: const TextStyle(color: Color(0xFF0F3822)),
          hintStyle: const TextStyle(color: Color(0xFF6B8C7A)),
        ),
      ),

      // SplashScreen is the very first screen the user sees
      home: const SplashScreen(),
    );
  }
}
