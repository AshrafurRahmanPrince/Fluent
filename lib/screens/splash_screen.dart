import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'auth_wrapper.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  final Stream<User?>? authStateChanges;
  final Future<bool>? firebaseInitialization;
  final Duration minimumDuration;

  const SplashScreen({
    super.key,
    this.authStateChanges,
    this.firebaseInitialization,
    this.minimumDuration = const Duration(milliseconds: 2500),
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _showContent = false;
  Timer? _fadeTimer;
  late final Future<Stream<User?>?> _authStreamFuture;
  Timer? _redirectTimer;

  @override
  void initState() {
    super.initState();

    _authStreamFuture = _initializeAuth();
    _fadeTimer = Timer(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          _showContent = true;
        });
      }
    });
    _redirectTimer = Timer(widget.minimumDuration, _navigateToAuth);
  }

  Future<Stream<User?>?> _initializeAuth() async {
    if (widget.authStateChanges != null) return widget.authStateChanges;

    final firebaseInitialized = await (widget.firebaseInitialization ??
        _initializeFirebaseForStandaloneUse());
    if (!firebaseInitialized) return null;

    try {
      return FirebaseAuth.instance.userChanges();
    } on Object catch (error, stackTrace) {
      debugPrint('Firebase Auth is unavailable: $error');
      debugPrintStack(stackTrace: stackTrace);
      return null;
    }
  }

  Future<bool> _initializeFirebaseForStandaloneUse() async {
    try {
      if (Firebase.apps.isEmpty) {
        await Firebase.initializeApp().timeout(const Duration(seconds: 8));
      }
      return true;
    } on Object catch (error, stackTrace) {
      debugPrint('Firebase initialization failed: $error');
      debugPrintStack(stackTrace: stackTrace);
      return false;
    }
  }

  Future<void> _navigateToAuth() async {
    final authStateChanges = await _authStreamFuture;
    if (!mounted) return;

    Navigator.of(context).pushReplacement(
      PageRouteBuilder<void>(
        pageBuilder: (_, animation, secondaryAnimation) =>
            authStateChanges == null
                ? const LoginScreen()
                : AuthWrapper(authStateChanges: authStateChanges),
        transitionsBuilder: (_, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  @override
  void dispose() {
    _fadeTimer?.cancel();
    _redirectTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: AnimatedOpacity(
              opacity: _showContent ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 1200),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      boxShadow: [
                        BoxShadow(
                          color: colors.primary.withValues(alpha: 0.4),
                          blurRadius: 40,
                          spreadRadius: 8,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(32),
                      child: Image.asset(
                        'assets/images/logo.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Fluent',
                    style: TextStyle(
                      color: colors.onSurface,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Learn. Speak. Thrive.',
                    style: TextStyle(
                      color: colors.primary,
                      fontSize: 14,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: 28,
                    height: 28,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(colors.primary),
                      strokeWidth: 2.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
