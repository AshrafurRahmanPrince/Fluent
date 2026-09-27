// splash_screen.dart — The first screen shown when the app launches.
// It displays the logo and then automatically navigates to the Login screen.

import 'dart:async'; // Timer lives in dart:async
import 'package:flutter/material.dart';
import 'login_screen.dart';

// StatefulWidget is used when the screen needs to change over time.
// Here we use it so we can run a Timer after the widget is built.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // createState() connects this widget to its mutable state object
  State<SplashScreen> createState() => _SplashScreenState();
}

// The State class holds data that can change. The underscore (_) means it's
// private — only accessible inside this file.
class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  // Animation controller drives the fade-in effect
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  // initState() is called once when this screen is first created.
  // It's the right place to start timers and animations.
  @override
  void initState() {
    super.initState();

    // Set up a fade-in animation over 1.2 seconds
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    _controller.forward(); // Start the animation

    // Timer.run after 3 seconds then navigate to LoginScreen.
    // Navigator.pushReplacement replaces the current screen (no back button).
    Timer(const Duration(seconds: 3), () {
      // mounted checks the widget is still in the tree before navigating
      if (mounted) {
        Navigator.pushReplacement(
          context,
          // PageRouteBuilder gives us a custom transition (fade in)
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => const LoginScreen(),
            transitionsBuilder: (_, animation, __, child) {
              return FadeTransition(opacity: animation, child: child);
            },
            transitionDuration: const Duration(milliseconds: 600),
          ),
        );
      }
    });
  }

  // dispose() is called when this screen is removed from the tree.
  // Always dispose controllers to free memory.
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold is the base layout structure for a Material screen.
    return Scaffold(
      // backgroundColor overrides the global theme just for this screen
      backgroundColor: const Color(0xFF0F3822), // Deep Forest Green

      body: FadeTransition(
        opacity: _fadeAnimation,
        // Center places its child in the exact middle of the available space
        child: Center(
          // Column stacks widgets vertically
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ── Logo ──────────────────────────────────────────────────
              Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF3E8E55).withValues(alpha: 0.4),
                      blurRadius: 40,
                      spreadRadius: 8,
                    ),
                  ],
                ),
                // Image.asset loads an image from the assets folder
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(32),
                  child: Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              const SizedBox(height: 24), // Vertical spacing

              // ── App Name ───────────────────────────────────────────────
              const Text(
                'Fluent',
                style: TextStyle(
                  color: Color(0xFFFDFBF7),
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Learn. Speak. Thrive.',
                style: TextStyle(
                  color: Color(0xFF3E8E55),
                  fontSize: 14,
                  letterSpacing: 1.2,
                ),
              ),

              const SizedBox(height: 60),

              // ── Loading Indicator ─────────────────────────────────────
              // CircularProgressIndicator shows a spinning ring while loading
              const SizedBox(
                width: 28,
                height: 28,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Color(0xFFFDFBF7), // Cream/golden white color
                  ),
                  strokeWidth: 2.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
