import 'package:flutter/material.dart';

// ---- Palette pulled from the Fluent app mockup in the project PPTX ----
const Color _appBackground = Color(0xFFFAFAF8);
const Color _textDark = Color(0xFF232B3D);
const Color _textMuted = Color(0xFF8D8B92);
const Color _primaryOrange = Color(0xFFFF7A33);
const Color _streakOrange = Color(0xFFFF6B4A);
const Color _skyBlueLight = Color(0xFF6BD4F4);
const Color _skyBlueDark = Color(0xFF3EB8E8);
const Color _peachLight = Color(0xFFFFF1DA);
const Color _peachDark = Color(0xFFFCE1B4);
const Color _creamCard = Color(0xFFFAF3EC);
const Color _listeningColor = Color(0xFFFA6E52);
const Color _speakingColor = Color(0xFF7CC254);
const Color _grammarColor = Color(0xFFFDB934);
const Color _travelColor = Color(0xFF9B8DEA);

// Home dashboard for Fluent, a gamified language-learning app. Shows a
// streak badge and greeting, today's minutes goal, a "pick up where you
// left off" lesson card, quick entry points into topic categories, a
// progress snapshot, and a flat five-tab bottom nav — matching the Fluent
// home-screen mockup from the project PPTX (no floating header block and
// no raised center nav button, unlike the previous fitness-app version).
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedTab = 0;

  final List<_TopicData> _topics = const [
    _TopicData(
      icon: Icons.headphones_rounded,
      color: _listeningColor,
      label: 'Listening',
    ),
    _TopicData(
      icon: Icons.chat_bubble_rounded,
      color: _speakingColor,
      label: 'Speaking',
    ),
    _TopicData(
      icon: Icons.menu_book_rounded,
      color: _grammarColor,
      label: 'Grammar',
    ),
    _TopicData(
      icon: Icons.card_travel_rounded,
      color: _travelColor,
      label: 'Travel',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _appBackground,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTopBar(),
                    const SizedBox(height: 18),
                    _buildGreeting(),
                    const SizedBox(height: 20),
                    _buildDailyGoalCard(),
                    const SizedBox(height: 26),
                    _buildSectionHeader('Continue learning'),
                    const SizedBox(height: 12),
                    _buildContinueLearningCard(),
                    const SizedBox(height: 26),
                    _buildSectionHeader('Explore topics'),
                    const SizedBox(height: 14),
                    _buildTopicsRow(),
                    const SizedBox(height: 26),
                    _buildSectionHeader('Your progress', action: 'View Stats'),
                    const SizedBox(height: 12),
                    _buildProgressCard(),
                  ],
                ),
              ),
            ),
            _buildBottomNav(),
          ],
        ),
      ),
    );
  }

  // Menu icon on the left, current streak on the right — sits directly on
  // the page background, matching the mockup's plain (non-colored) header.
  Widget _buildTopBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Icon(Icons.menu_rounded, color: _textDark, size: 26),
        _StreakBadge(days: 72),
      ],
    );
  }

  Widget _buildGreeting() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '¡Hola, Alex!',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w800,
            color: _textDark,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Ready to learn Spanish?',
          style: TextStyle(fontSize: 15, color: _textMuted),
        ),
      ],
    );
  }

  // Peach gradient card showing today's minutes goal and a filled progress
  // bar. The leaf badge stands in for the mockup's illustrated potted plant.
  Widget _buildDailyGoalCard() {
    const double minutesDone = 15;
    const double minutesGoal = 15;
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [_peachLight, _peachDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'DAILY GOAL',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: _primaryOrange,
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: const [
                    Text(
                      '15 / 15',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: _textDark,
                      ),
                    ),
                    SizedBox(width: 6),
                    Text(
                      'min',
                      style: TextStyle(fontSize: 13, color: _textMuted),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: minutesDone / minutesGoal,
                    minHeight: 8,
                    backgroundColor: Colors.white.withValues(alpha: 0.5),
                    valueColor: const AlwaysStoppedAnimation(_primaryOrange),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 14),
          Container(
            width: 56,
            height: 56,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.eco_rounded,
              color: Color(0xFF6FA84A),
              size: 30,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, {String? action}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: _textDark,
          ),
        ),
        if (action != null)
          Text(
            action,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: _primaryOrange,
            ),
          ),
      ],
    );
  }

  // Blue gradient "resume lesson" card. The flag stands in for the
  // mockup's illustrated village scene since that needs real art assets.
  Widget _buildContinueLearningCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [_skyBlueLight, _skyBlueDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: _skyBlueDark.withValues(alpha: 0.3),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Basics 1',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Lesson 4',
                  style: TextStyle(fontSize: 14, color: Colors.white70),
                ),
              ],
            ),
          ),
          const SizedBox(width: 14),
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.chevron_right_rounded,
              color: _skyBlueDark,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }

  // Four evenly-spaced topic tiles — not a horizontal scroller, all four
  // fit the row at once, matching the mockup.
  Widget _buildTopicsRow() {
    return Row(
      children: List.generate(_topics.length * 2 - 1, (i) {
        if (i.isOdd) return const SizedBox(width: 12);
        return Expanded(child: _buildTopicTile(_topics[i ~/ 2]));
      }),
    );
  }

  Widget _buildTopicTile(_TopicData topic) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: Container(
            decoration: BoxDecoration(
              color: topic.color,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: topic.color.withValues(alpha: 0.35),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(topic.icon, color: Colors.white, size: 26),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          topic.label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: _textDark,
          ),
        ),
      ],
    );
  }

  // Cream card: lesson count and a small recent-activity bar chart on the
  // left, a circular "level" progress ring on the right.
  Widget _buildProgressCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _creamCard,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Lessons completed',
                  style: TextStyle(fontSize: 13, color: _textMuted),
                ),
                const SizedBox(height: 4),
                const Text(
                  '24',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: _textDark,
                  ),
                ),
                const SizedBox(height: 14),
                _buildMiniBarChart(),
              ],
            ),
          ),
          const SizedBox(width: 16),
          _buildLevelRing(),
        ],
      ),
    );
  }

  Widget _buildMiniBarChart() {
    const heights = [10.0, 16.0, 24.0, 30.0, 36.0];
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: List.generate(heights.length, (i) {
        final t = i / (heights.length - 1);
        final color = Color.lerp(_primaryOrange, _grammarColor, t)!;
        return Padding(
          padding: const EdgeInsets.only(right: 6),
          child: Container(
            width: 10,
            height: heights[i],
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildLevelRing() {
    return SizedBox(
      width: 64,
      height: 64,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 64,
            height: 64,
            child: CircularProgressIndicator(
              value: 0.62,
              strokeWidth: 5,
              strokeCap: StrokeCap.round,
              backgroundColor: _peachDark.withValues(alpha: 0.45),
              valueColor: const AlwaysStoppedAnimation(_primaryOrange),
            ),
          ),
          const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Level',
                style: TextStyle(fontSize: 10, color: _textMuted),
              ),
              Text(
                '3',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: _textDark,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Flat five-tab bar — no raised center button, matching the mockup.
  Widget _buildBottomNav() {
    final items = const [
      _NavItemData(icon: Icons.home_rounded, label: 'Home'),
      _NavItemData(icon: Icons.menu_book_rounded, label: 'Courses'),
      _NavItemData(icon: Icons.explore_rounded, label: 'Practice'),
      _NavItemData(icon: Icons.emoji_events_rounded, label: 'Achievements'),
      _NavItemData(icon: Icons.person_rounded, label: 'Profile'),
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          items.length,
          (index) => _buildNavItem(index, items[index]),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, _NavItemData item) {
    final isSelected = _selectedTab == index;
    final color = isSelected ? _streakOrange : _textMuted;

    return GestureDetector(
      onTap: () => setState(() => _selectedTab = index),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(item.icon, color: color, size: 22),
          const SizedBox(height: 4),
          Text(
            item.label,
            style: TextStyle(
              fontSize: 10,
              color: color,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

// Small flame + count badge used for the daily streak, top-right of header.
class _StreakBadge extends StatelessWidget {
  const _StreakBadge({required this.days});

  final int days;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.local_fire_department_rounded,
          color: _streakOrange,
          size: 22,
        ),
        const SizedBox(width: 4),
        Text(
          '$days',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: _textDark,
          ),
        ),
      ],
    );
  }
}

class _TopicData {
  const _TopicData({
    required this.icon,
    required this.color,
    required this.label,
  });

  final IconData icon;
  final Color color;
  final String label;
}

class _NavItemData {
  const _NavItemData({required this.icon, required this.label});

  final IconData icon;
  final String label;
}