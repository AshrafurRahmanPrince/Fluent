import 'package:flutter/material.dart';
import 'listening/listening_screen.dart';
import 'reading/reading_screen.dart';
import 'speaking/speaking_screen.dart';
import 'writing/writing_screen.dart';

const Color _forestGreen = Color(0xFF0F3822);
const Color _warmCream = Color(0xFFF7F3E9);
const Color _leafGreen = Color(0xFF3E8E55);
const Color _bannerGreen = Color(0xFF2D6A4F);
const Color _charcoal = Color(0xFF1C2A23);
const Color _softWhite = Color(0xFFFDFBF7);
const double _dailyProgress = 0.65;
const List<double> _weeklyActivity = [0.48, 0.72, 0.58, 0.9, 0.65, 0.82, 0.35];
const List<String> _weekdays = [
  'Mon',
  'Tue',
  'Wed',
  'Thu',
  'Fri',
  'Sat',
  'Sun'
];

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
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _forestGreen,
      drawer: _buildNavigationDrawer(context),
      appBar: AppBar(
        backgroundColor: _forestGreen,
        foregroundColor: _softWhite,
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
            const Text(
              'Fluent',
              style: TextStyle(
                color: _softWhite,
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
            const Text(
              'Good Morning! 👋',
              style: TextStyle(
                color: _softWhite,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Keep up the great work today!',
              style: TextStyle(
                color: _softWhite.withValues(alpha: 0.72),
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 22),
            _buildProgressCard(),
            const SizedBox(height: 18),
            _buildQuizBanner(context),
            const SizedBox(height: 26),
            const Text(
              'Core Modules',
              style: TextStyle(
                color: _softWhite,
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
    return Drawer(
      backgroundColor: _warmCream,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 22),
              color: _forestGreen,
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
                  const Text(
                    'Fluent',
                    style: TextStyle(
                      color: _softWhite,
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
                leading: Icon(item.icon, color: _leafGreen),
                title: Text(
                  item.label,
                  style: const TextStyle(
                    color: _charcoal,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _showNotice(context, '${item.label} is ready to explore.');
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressCard() {
    final int percent = (_dailyProgress * 100).round();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _warmCream,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.calendar_month_rounded,
                  color: _leafGreen, size: 21),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Daily Progress',
                  style: TextStyle(
                    color: _charcoal,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: _leafGreen.withValues(alpha: 0.13),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '$percent%',
                  style: const TextStyle(
                    color: _leafGreen,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 13),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: _dailyProgress,
              minHeight: 9,
              backgroundColor: _forestGreen.withValues(alpha: 0.12),
              valueColor: const AlwaysStoppedAnimation<Color>(_leafGreen),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '$percent% of today\'s goal completed',
            style: TextStyle(
              color: _charcoal.withValues(alpha: 0.7),
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'Weekly Activity',
            style: TextStyle(
              color: _charcoal,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 13),
          SizedBox(
            height: 112,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List<Widget>.generate(_weeklyActivity.length, (index) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              width: double.infinity,
                              height: 72 * _weeklyActivity[index],
                              decoration: BoxDecoration(
                                color: index == 3 ? _leafGreen : _bannerGreen,
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 7),
                        Text(
                          _weekdays[index],
                          style: TextStyle(
                            color: _charcoal.withValues(alpha: 0.67),
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuizBanner(BuildContext context) {
    return Material(
      color: _bannerGreen,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => _showNotice(context, 'Daily Quiz is coming soon.'),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: _softWhite.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(12),
                ),
                child:
                    const Icon(Icons.bolt_rounded, color: _softWhite, size: 27),
              ),
              const SizedBox(width: 13),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Daily Quiz',
                      style: TextStyle(
                        color: _softWhite,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Test today\'s vocabulary — 5 mins',
                      style: TextStyle(color: _softWhite, fontSize: 12),
                    ),
                  ],
                ),
              ),
              IconButton(
                tooltip: 'Start daily quiz',
                onPressed: () =>
                    _showNotice(context, 'Daily Quiz is coming soon.'),
                icon:
                    const Icon(Icons.arrow_forward_rounded, color: _softWhite),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStreakBanner(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
      decoration: BoxDecoration(
        color: _softWhite.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _leafGreen.withValues(alpha: 0.45)),
      ),
      child: Row(
        children: [
          const Text('🔥', style: TextStyle(fontSize: 27)),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '7 Day Streak!',
                  style: TextStyle(
                    color: _softWhite,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  'You\'re on fire — keep it up!',
                  style: TextStyle(color: _softWhite, fontSize: 12),
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
              foregroundColor: _softWhite,
              backgroundColor: _leafGreen,
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
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: _bannerGreen,
          behavior: SnackBarBehavior.floating,
        ),
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
    return Container(
      decoration: BoxDecoration(
        color: _warmCream,
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
        color: _warmCream,
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
                    color: _warmCream,
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
                  style: const TextStyle(
                    color: _charcoal,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  lessonCount,
                  style: TextStyle(
                    color: _charcoal.withValues(alpha: 0.65),
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
