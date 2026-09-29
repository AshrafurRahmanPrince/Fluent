import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const FluentApp());
}

class FluentApp extends StatelessWidget {
  const FluentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fluent',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF3E8E55),
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF0F3822),
        useMaterial3: true,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            color: Color(0xFFFDFBF7),
            fontFamily: 'sans-serif',
          ),
        ),
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
      home: const SplashScreen(),
    );
  }
}
