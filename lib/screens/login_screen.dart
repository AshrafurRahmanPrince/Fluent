// login_screen.dart — The screen where existing users sign in.

import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'register_screen.dart';
import '../widgets/custom_button.dart';

// StatefulWidget because we need to toggle password visibility
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // TextEditingController lets us read the value typed into a TextField
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Tracks whether the password dots are shown or hidden
  bool _obscurePassword = true;

  // _formKey is used to validate the form before submitting
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // Always dispose controllers to avoid memory leaks
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Called when the user taps "Log In"
  void _handleLogin() {
    // validate() runs every validator in the form
    if (_formKey.currentState!.validate()) {
      // Navigator.pushReplacement navigates to HomeScreen.
      // pushReplacement means the user can't press Back to return here.
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF0F3822),
      // SingleChildScrollView prevents overflow when the keyboard appears
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            // Form widget wraps input fields enabling group validation
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: size.height * 0.10),

                  // ── Logo ────────────────────────────────────────────
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF3E8E55).withValues(alpha: 0.35),
                          blurRadius: 20,
                          spreadRadius: 4,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'assets/images/logo.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),

                  // ── Heading ─────────────────────────────────────────
                  const Text(
                    'Welcome Back!',
                    style: TextStyle(
                      color: Color(0xFFFDFBF7),
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Continue your language journey',
                    style: TextStyle(
                      color: Color(0xFF3E8E55),
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 36),

                  // ── Email Field ──────────────────────────────────────
                  TextFormField(
                    controller: _emailController,
                    // keyboardType hints the OS which keyboard layout to show
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(color: Color(0xFF0F3822)),
                    decoration: const InputDecoration(
                      labelText: 'Email Address',
                      hintText: 'you@example.com',
                      prefixIcon: Icon(Icons.email_outlined,
                          color: Color(0xFF3E8E55)),
                    ),
                    // validator returns an error string, or null if valid
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!value.contains('@')) {
                        return 'Enter a valid email address';
                      }
                      return null; // null means the field is valid
                    },
                  ),

                  const SizedBox(height: 16),

                  // ── Password Field ───────────────────────────────────
                  TextFormField(
                    controller: _passwordController,
                    // obscureText hides the typed characters (password dots)
                    obscureText: _obscurePassword,
                    style: const TextStyle(color: Color(0xFF0F3822)),
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: '••••••••',
                      prefixIcon: const Icon(Icons.lock_outline,
                          color: Color(0xFF3E8E55)),
                      // suffixIcon is the eye toggle button
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: const Color(0xFF3E8E55),
                        ),
                        // setState() tells Flutter to rebuild with new data
                        onPressed: () => setState(
                            () => _obscurePassword = !_obscurePassword),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),

                  // ── Forgot Password ──────────────────────────────────
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {}, // Placeholder for forgot password flow
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: Color(0xFF3E8E55),
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // ── Log In Button ────────────────────────────────────
                  // CustomButton is our reusable button from the widgets folder
                  CustomButton(
                    label: 'Log In',
                    onPressed: _handleLogin,
                  ),

                  const SizedBox(height: 24),

                  // ── Divider ──────────────────────────────────────────
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: const Color(0xFF3E8E55).withValues(alpha: 0.4),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          'or',
                          style: TextStyle(color: Color(0xFF6B8C7A)),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: const Color(0xFF3E8E55).withValues(alpha: 0.4),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // ── Navigate to Register ─────────────────────────────
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account? ",
                        style: TextStyle(color: Color(0xFF6B8C7A)),
                      ),
                      GestureDetector(
                        // Navigator.push adds RegisterScreen on top of LoginScreen
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const RegisterScreen()),
                        ),
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Color(0xFFFDFBF7),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
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
