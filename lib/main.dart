import 'package:flutter/material.dart';
import 'dart:async';

import 'package:fluent/screens/home_screen.dart';

void main() {
  runApp(const FluentApp());
}

class FluentApp extends StatelessWidget {
  const FluentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    });
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: const Color(0xFFFFFDE7),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            'Fluent',
            style: TextStyle(
              color: Colors.black,
              fontSize: 42,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          SizedBox(height: 8), 
          Text(
            'Learn naturally. Speak fluidly.',
            style: TextStyle(
              color: Colors.black54, 
              fontSize: 16,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.8,
            ),
          ),
        ],
      ),
    ),
  );
}
}

enum AuthMode { initial, login, signup }

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthMode _mode = AuthMode.initial;
  bool _obscurePassword = true;
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0B3D2E), Color(0xFF14532D)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                const Text(
                  'Fluent!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Learn naturally. Speak fluidly.',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
                const SizedBox(height: 40),
                _buildToggle(),
                if (_mode != AuthMode.initial) ...[
                  const SizedBox(height: 24),
                  _buildForm(),
                ],
                const Spacer(),
                if (_mode == AuthMode.initial)
                  Column(
                    children: [
                      _outlineButton(
                          'Login', () => setState(() => _mode = AuthMode.login)),
                      const SizedBox(height: 12),
                      _filledButton(
                          'Sign up', () => setState(() => _mode = AuthMode.signup)),
                    ],
                  )
                else
                  _filledButton(
                    _mode == AuthMode.login ? 'Login' : 'Sign up',
                    () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    },
                  ),
                const SizedBox(height: 20),
                _buildGoogleDivider(),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildToggle() {
    return Row(
      children: [
        Expanded(
          child: _outlineButton(
            'Login',
            () => setState(() => _mode = AuthMode.login),
            filled: _mode == AuthMode.login,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _outlineButton(
            'Sign up',
            () => setState(() => _mode = AuthMode.signup),
            filled: _mode == AuthMode.signup,
          ),
        ),
      ],
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Email Address',
            style: TextStyle(color: Colors.white70, fontSize: 12)),
        const SizedBox(height: 6),
        _textField(hint: 'you@example.com', icon: Icons.email_outlined),
        const SizedBox(height: 16),
        const Text('Password',
            style: TextStyle(color: Colors.white70, fontSize: 12)),
        const SizedBox(height: 6),
        _textField(
          hint: '••••••••••',
          icon: Icons.lock_outline,
          obscure: _obscurePassword,
          suffix: IconButton(
            icon: Icon(
              _obscurePassword ? Icons.visibility_off : Icons.visibility,
              color: Colors.white70,
              size: 18,
            ),
            onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
          ),
        ),
        if (_mode == AuthMode.signup) ...[
          const SizedBox(height: 16),
          const Text('Confirm Password',
              style: TextStyle(color: Colors.white70, fontSize: 12)),
          const SizedBox(height: 6),
          _textField(hint: '••••••••••', icon: Icons.lock_outline, obscure: true),
        ],
        if (_mode == AuthMode.login) ...[
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: _rememberMe,
                    onChanged: (v) => setState(() => _rememberMe = v ?? false),
                    fillColor: WidgetStateProperty.all(Colors.white),
                  ),
                  const Text('Remember me',
                      style: TextStyle(color: Colors.white70, fontSize: 12)),
                ],
              ),
              const Text('Forgot Password?',
                  style: TextStyle(color: Colors.white, fontSize: 12)),
            ],
          ),
        ],
      ],
    );
  }

  Widget _textField({
    required String hint,
    required IconData icon,
    bool obscure = false,
    Widget? suffix,
  }) {
    return TextField(
      obscureText: obscure,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white38),
        prefixIcon: Icon(icon, color: Colors.white70, size: 18),
        suffixIcon: suffix,
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.08),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 0),
      ),
    );
  }

  Widget _outlineButton(String text, VoidCallback onTap, {bool filled = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: filled ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.white),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: filled ? const Color(0xFF14532D) : Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _filledButton(String text, VoidCallback onTap) {
    return SizedBox(
      width: double.infinity,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Color(0xFF14532D), fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _buildGoogleDivider() {
    return Column(
      children: [
        Row(
          children: const [
            Expanded(child: Divider(color: Colors.white24)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text('or', style: TextStyle(color: Colors.white54, fontSize: 12)),
            ),
            Expanded(child: Divider(color: Colors.white24)),
          ],
        ),
        const SizedBox(height: 16),
        GestureDetector(
          onTap: () {},
          child: const Text(
            'Sign in with Google',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
          ),
        ),
      ],
    );
  }
}