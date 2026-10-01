import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class AuthWrapper extends StatelessWidget {
  final Stream<User?>? authStateChanges;

  const AuthWrapper({super.key, this.authStateChanges});

  @override
  Widget build(BuildContext context) {
    late final Stream<User?> userChanges;
    try {
      userChanges = authStateChanges ?? FirebaseAuth.instance.userChanges();
    } catch (_) {
      return const LoginScreen();
    }

    return StreamBuilder<User?>(
      stream: userChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          final colors = Theme.of(context).colorScheme;
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: Center(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(colors.primary)),
            ),
          );
        }
        if (snapshot.hasError) return const LoginScreen();
        return snapshot.hasData
            ? HomeScreen(
                user: snapshot.data ?? FirebaseAuth.instance.currentUser,
                userChanges: userChanges,
              )
            : const LoginScreen();
      },
    );
  }
}
