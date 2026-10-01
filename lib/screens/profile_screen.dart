import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/user_progress_service.dart';

class ProfileScreen extends StatelessWidget {
  final User? user;
  final Stream<User?>? userChanges;

  const ProfileScreen({super.key, this.user, this.userChanges});

  @override
  Widget build(BuildContext context) {
    final initialUser = user ?? _currentAuthUser();

    return StreamBuilder<User?>(
      stream: _userStream(),
      initialData: initialUser,
      builder: (context, authSnapshot) {
        if (authSnapshot.connectionState == ConnectionState.waiting &&
            authSnapshot.data == null) {
          return _loadingScreen(context);
        }

        final currentUser = authSnapshot.data ?? initialUser;
        return FutureBuilder<UserProfileProgress>(
          future: UserProgressService.instance.getProfileProgress(),
          builder: (context, progressSnapshot) {
            if (progressSnapshot.connectionState == ConnectionState.waiting) {
              return _loadingScreen(context);
            }
            return _profileContent(
              context,
              currentUser,
              progressSnapshot.data ??
                  const UserProfileProgress(
                    completedLessons: 0,
                    completedQuizzes: 0,
                    averageQuizScore: 0,
                    activeStreak: 0,
                  ),
            );
          },
        );
      },
    );
  }

  Stream<User?> _userStream() {
    if (userChanges != null) return userChanges!;
    if (user != null) return Stream<User?>.value(user);
    try {
      return FirebaseAuth.instance.userChanges();
    } on FirebaseException {
      return Stream<User?>.value(null);
    }
  }

  User? _currentAuthUser() {
    if (user != null) return user;
    try {
      return FirebaseAuth.instance.currentUser;
    } on FirebaseException {
      return null;
    }
  }

  Widget _loadingScreen(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(title: const Text('Profile')),
      body: Center(
        child: CircularProgressIndicator(color: colors.primary),
      ),
    );
  }

  Widget _profileContent(
    BuildContext context,
    User? currentUser,
    UserProfileProgress progress,
  ) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: colors.surface,
        foregroundColor: colors.onSurface,
        elevation: 0,
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context, currentUser),
            const SizedBox(height: 20),
            _buildStats(context, progress),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => _logOut(context),
                icon: const Icon(Icons.logout_rounded),
                label: const Text('Log Out'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: colors.error,
                  side: BorderSide(color: colors.error),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _logOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      if (context.mounted) {
        Navigator.of(context).popUntil((route) => route.isFirst);
      }
    } on FirebaseAuthException {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Unable to log out. Please try again.')),
        );
      }
    }
  }

  Widget _buildHeader(BuildContext context, User? user) {
    final displayName = user?.displayName?.trim();
    final email = user?.email?.trim();
    final colors = Theme.of(context).colorScheme;
    final emailName = email?.split('@').first.trim();
    final name = displayName != null && displayName.isNotEmpty
        ? displayName
        : emailName == null || emailName.isEmpty
            ? 'User'
            : emailName;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: colors.surface, borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          CircleAvatar(
            radius: 34,
            backgroundColor: colors.primary,
            child:
                Icon(Icons.person_rounded, color: colors.onPrimary, size: 38),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    color: colors.onSurface,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                    email == null || email.isEmpty
                        ? 'No email available'
                        : email,
                    style: TextStyle(color: colors.onSurface, fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStats(BuildContext context, UserProfileProgress progress) {
    final colors = Theme.of(context).colorScheme;
    final stats = [
      ('${progress.activeStreak}', 'Day Streak'),
      ('${progress.completedQuizzes}', 'Quizzes'),
      ('${progress.averageQuizScore.toStringAsFixed(0)}%', 'Average Score'),
      ('${progress.completedLessons}', 'Lessons'),
    ];
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: colors.surface, borderRadius: BorderRadius.circular(16)),
      child: LayoutBuilder(
        builder: (context, constraints) => GridView.count(
          crossAxisCount: constraints.maxWidth < 440 ? 2 : 4,
          crossAxisSpacing: 8,
          mainAxisSpacing: 18,
          childAspectRatio: 1.65,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            for (final stat in stats)
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    stat.$1,
                    style: TextStyle(
                      color: colors.primary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    stat.$2,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: colors.onSurface, fontSize: 11),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
