import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'daily_quiz_screen.dart';
import 'listening/listening_screen.dart';
import 'profile_screen.dart';
import 'reading/reading_screen.dart';
import 'settings_screen.dart';
import 'speaking/speaking_screen.dart';
import '../services/user_progress_service.dart';
import 'writing/writing_screen.dart';

class _DrawerItem {
  final String label;
  final IconData icon;

  const _DrawerItem(this.label, this.icon);
}

const List<_DrawerItem> _drawerOptions = [
  _DrawerItem('Reading', Icons.menu_book_rounded),
  _DrawerItem('Writing', Icons.edit_note_rounded),
  _DrawerItem('Speaking', Icons.mic_rounded),
  _DrawerItem('Listening', Icons.headphones_rounded),
  _DrawerItem('Profile', Icons.account_circle_outlined),
  _DrawerItem('Settings', Icons.settings_outlined),
];

class HomeScreen extends StatelessWidget {
  final User? user;
  final Stream<User?>? userChanges;

  const HomeScreen({super.key, this.user, this.userChanges});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final displayName = user?.displayName?.trim();
    final greetingName =
        displayName == null || displayName.isEmpty ? 'User' : displayName;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      drawer: _buildNavigationDrawer(context),
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: colors.onSurface,
        elevation: 0,
        titleSpacing: 16,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(7),
              child: Image.asset(
                'assets/images/logo.png',
                width: 30,
                height: 30,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'Fluent',
              style: TextStyle(
                color: colors.onSurface,
                fontWeight: FontWeight.bold,
                fontSize: 19,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome, $greetingName!',
              style: TextStyle(
                color: colors.onSurface,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Keep up the great work today!',
              style: TextStyle(
                color: colors.onSurface.withValues(alpha: 0.72),
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 22),
            _buildProgressCard(),
            const SizedBox(height: 18),
            _buildQuizBanner(context),
            const SizedBox(height: 26),
            Text(
              'Core Modules',
              style: TextStyle(
                color: colors.onSurface,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 14),
            LayoutBuilder(
              builder: (context, constraints) {
                const crossAxisSpacing = 14.0;
                final crossAxisCount = constraints.maxWidth < 600 ? 1 : 2;
                final cardWidth = (constraints.maxWidth -
                        crossAxisSpacing * (crossAxisCount - 1)) /
                    crossAxisCount;

                return GridView.count(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: crossAxisSpacing,
                  mainAxisSpacing: 14,
                  childAspectRatio: cardWidth / 230,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    ModuleCardImage(
                      imagePath: 'assets/images/reading.jpg',
                      title: 'Reading',
                      lessonCount: '12 Lessons',
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const ReadingScreen()),
                      ),
                    ),
                    ModuleCardImage(
                      imagePath: 'assets/images/writing.jpg',
                      title: 'Writing',
                      lessonCount: '8 Lessons',
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const WritingScreen()),
                      ),
                    ),
                    ModuleCardImage(
                      imagePath: 'assets/images/speaking.jpg',
                      title: 'Speaking',
                      lessonCount: '10 Lessons',
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const SpeakingScreen()),
                      ),
                    ),
                    ModuleCardImage(
                      imagePath: 'assets/images/listening.jpg',
                      title: 'Listening',
                      lessonCount: '9 Lessons',
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const ListeningScreen()),
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 20),
            _buildStreakBanner(context),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationDrawer(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Drawer(
      backgroundColor: colors.surface,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 22),
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 42,
                      height: 42,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Fluent',
                    style: TextStyle(
                      color: colors.onSurface,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            for (final item in _drawerOptions)
              ListTile(
                leading: Icon(item.icon, color: colors.primary),
                title: Text(
                  item.label,
                  style: TextStyle(
                    color: colors.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  final screen = switch (item.label) {
                    'Profile' => ProfileScreen(
                        user: user,
                        userChanges: userChanges,
                      ),
                    'Settings' => const SettingsScreen(),
                    _ => null,
                  };
                  if (screen != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => screen),
                    );
                  } else {
                    _showNotice(context, '${item.label} is ready to explore.');
                  }
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressCard() {
    return const _UserProgressCard();
  }

  Widget _buildQuizBanner(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Material(
      color: colors.surfaceContainer,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const DailyQuizScreen()),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: colors.onSurface.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child:
                    Icon(Icons.bolt_rounded, color: colors.primary, size: 27),
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Daily Quiz',
                      style: TextStyle(
                        color: colors.onSurface,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '10 IELTS questions · 8 mins',
                      style: TextStyle(color: colors.onSurface, fontSize: 12),
                    ),
                  ],
                ),
              ),
              IconButton(
                tooltip: 'Start daily quiz',
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const DailyQuizScreen()),
                ),
                icon: Icon(Icons.arrow_forward_rounded, color: colors.primary),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStreakBanner(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colors.primary.withValues(alpha: 0.45)),
      ),
      child: Row(
        children: [
          const Text('🔥', style: TextStyle(fontSize: 27)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '7 Day Streak!',
                  style: TextStyle(
                    color: colors.onSurface,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  'You\'re on fire — keep it up!',
                  style: TextStyle(color: colors.onSurface, fontSize: 12),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () => _showNotice(
              context,
              'Your streak history is coming soon.',
            ),
            style: TextButton.styleFrom(
              foregroundColor: colors.onPrimary,
              backgroundColor: colors.primary,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text('View'),
          ),
        ],
      ),
    );
  }

  void _showNotice(BuildContext context, String message) {
    final colors = Theme.of(context).colorScheme;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: colors.surfaceContainer,
          behavior: SnackBarBehavior.floating,
        ),
      );
  }
}

class _UserProgressCard extends StatefulWidget {
  const _UserProgressCard();

  @override
  State<_UserProgressCard> createState() => _UserProgressCardState();
}

class _UserProgressCardState extends State<_UserProgressCard> {
  final UserProgressService _progressService = UserProgressService.instance;
  late final Stream<List<DailyActivityProgress>> _progressStream;

  @override
  void initState() {
    super.initState();
    _progressStream = _progressService.watchCurrentWeekProgress();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final zeroWeek = _progressService.emptyCurrentWeek();

    return StreamBuilder<List<DailyActivityProgress>>(
      stream: _progressStream,
      initialData: zeroWeek,
      builder: (context, snapshot) {
        final week = snapshot.data ?? zeroWeek;
        final today = week[DateTime.now().weekday - 1];
        final largestDay = week.fold<int>(
          0,
          (largest, day) =>
              day.totalPoints > largest ? day.totalPoints : largest,
        );

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.calendar_month_rounded,
                      color: colors.primary, size: 21),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Daily Progress',
                      style: TextStyle(
                        color: colors.onSurface,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    '${today.totalPoints} today',
                    style: TextStyle(
                      color: colors.primary,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Lessons ${today.lessonPoints}  ·  '
                'Quizzes ${today.quizPoints}  ·  '
                'Activities ${today.activityPoints}',
                style: TextStyle(
                  color: colors.onSurface.withValues(alpha: 0.72),
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'This Week',
                style: TextStyle(
                  color: colors.onSurface,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 112,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    for (final day in week)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                '${day.totalPoints}',
                                style: TextStyle(
                                  color:
                                      colors.onSurface.withValues(alpha: 0.75),
                                  fontSize: 10,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    width: double.infinity,
                                    height: largestDay == 0
                                        ? 0
                                        : 58 * day.totalPoints / largestDay,
                                    decoration: BoxDecoration(
                                      color: day.date.weekday ==
                                              DateTime.now().weekday
                                          ? colors.primary
                                          : colors.secondary,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 7),
                              Text(
                                day.weekdayLabel,
                                style: TextStyle(
                                  color:
                                      colors.onSurface.withValues(alpha: 0.67),
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ModuleCardImage extends StatelessWidget {
  const ModuleCardImage({
    required this.imagePath,
    required this.title,
    required this.lessonCount,
    required this.onTap,
    super.key,
  });

  final String imagePath;
  final String title;
  final String lessonCount;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.14),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: colors.surface,
        borderRadius: BorderRadius.circular(20),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  height: 128,
                  decoration: BoxDecoration(
                    color: colors.surface,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  title,
                  style: TextStyle(
                    color: colors.onSurface,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  lessonCount,
                  style: TextStyle(
                    color: colors.onSurface.withValues(alpha: 0.65),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
