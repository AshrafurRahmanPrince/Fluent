import 'package:flutter/material.dart';

const Color _profileGreen = Color(0xFF1C3A27);
const Color _profileCream = Color(0xFFF5F2EB);
const Color _profileAccent = Color(0xFF3E8E55);
const Color _profileText = Color(0xFF1C2A23);

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _profileGreen,
      appBar: AppBar(
        backgroundColor: _profileGreen,
        foregroundColor: _profileCream,
        elevation: 0,
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 20),
            _buildStats(),
            const SizedBox(height: 24),
            const Text('Recent Achievements',
                style: TextStyle(
                    color: _profileCream,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            _activityTile(Icons.local_fire_department_rounded,
                'Five-day streak', 'You practiced five days in a row.'),
            _activityTile(Icons.quiz_rounded, 'Quiz champion',
                'You completed 12 quizzes.'),
            _activityTile(Icons.menu_book_rounded, 'Reading progress',
                'You finished your first reading lesson.'),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: _profileCream, borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 34,
            backgroundColor: _profileAccent,
            child: Icon(Icons.person_rounded, color: _profileCream, size: 38),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('User',
                    style: TextStyle(
                        color: _profileText,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text('student@aust.edu',
                    style: TextStyle(color: _profileText, fontSize: 13)),
                SizedBox(height: 5),
                Text('Intermediate Learner',
                    style: TextStyle(
                        color: _profileAccent, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStats() {
    const stats = [
      ('5 Days', 'Current Streak'),
      ('12', 'Quizzes Completed'),
      ('85%', 'Overall Score'),
    ];
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18),
      decoration: BoxDecoration(
          color: _profileCream, borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: stats
            .map((stat) => Expanded(
                  child: Column(
                    children: [
                      Text(stat.$1,
                          style: const TextStyle(
                              color: _profileAccent,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 5),
                      Text(stat.$2,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: _profileText, fontSize: 11)),
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget _activityTile(IconData icon, String title, String detail) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
      leading: CircleAvatar(
          backgroundColor: _profileCream,
          child: Icon(icon, color: _profileAccent)),
      title: Text(title,
          style: const TextStyle(
              color: _profileCream, fontWeight: FontWeight.bold)),
      subtitle: Text(detail,
          style: TextStyle(color: _profileCream.withValues(alpha: 0.7))),
    );
  }
}
