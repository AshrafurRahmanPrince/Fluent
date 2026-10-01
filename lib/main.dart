import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'services/theme_provider.dart';
import 'screens/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  unawaited(ThemeProvider.instance.loadPreference());

  final firebaseInitialization = Completer<bool>();
  runApp(FluentApp(firebaseInitialization: firebaseInitialization.future));

  try {
    await Firebase.initializeApp().timeout(const Duration(seconds: 8));
    debugPrint('Firebase initialized successfully on Android');
    firebaseInitialization.complete(true);
  } on Object catch (error, stackTrace) {
    debugPrint('Firebase initialization failed: $error');
    debugPrintStack(stackTrace: stackTrace);
    firebaseInitialization.complete(false);
  }
}

class FluentApp extends StatelessWidget {
  final Stream<User?>? authStateChanges;
  final Future<bool>? firebaseInitialization;
  final ThemeProvider? themeProvider;

  const FluentApp({
    super.key,
    this.authStateChanges,
    this.firebaseInitialization,
    this.themeProvider,
  });

  @override
  Widget build(BuildContext context) {
    final activeThemeProvider = themeProvider ?? ThemeProvider.instance;

    return AnimatedBuilder(
      animation: activeThemeProvider,
      builder: (context, _) => MaterialApp(
        title: 'Fluent',
        debugShowCheckedModeBanner: false,
        theme: ThemeProvider.lightTheme,
        darkTheme: ThemeProvider.darkTheme,
        themeMode: activeThemeProvider.themeMode,
        home: SplashScreen(
          authStateChanges: authStateChanges,
          firebaseInitialization: firebaseInitialization,
        ),
      ),
    );
  }
}
