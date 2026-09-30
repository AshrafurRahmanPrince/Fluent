import 'package:flutter/material.dart';

const Color _settingsGreen = Color(0xFF1C3A27);
const Color _settingsCream = Color(0xFFF5F2EB);
const Color _settingsAccent = Color(0xFF3E8E55);
const Color _settingsText = Color(0xFF1C2A23);

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _dailyReminder = true;
  bool _soundEffects = true;
  bool _darkMode = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _settingsGreen,
      appBar: AppBar(
        backgroundColor: _settingsGreen,
        foregroundColor: _settingsCream,
        elevation: 0,
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: [
          _sectionTitle('App Preferences'),
          _switchTile(
              'Daily Reminder Notifications',
              Icons.notifications_outlined,
              _dailyReminder,
              (value) => setState(() => _dailyReminder = value)),
          _switchTile('Sound Effects', Icons.volume_up_outlined, _soundEffects,
              (value) => setState(() => _soundEffects = value)),
          _sectionTitle('Account'),
          _actionTile('Edit Profile', Icons.person_outline_rounded,
              () => _showMessage('Profile editing is ready to connect.')),
          _actionTile('Change Password', Icons.lock_outline_rounded,
              () => _showMessage('Password changing is ready to connect.')),
          _switchTile('Dark Mode', Icons.dark_mode_outlined, _darkMode,
              (value) => setState(() => _darkMode = value)),
          _sectionTitle('About'),
          _actionTile('v1.0.0 - Fluent', Icons.info_outline_rounded, null),
          _actionTile(
              'About Developer',
              Icons.code_rounded,
              () => _showMessage(
                  'Developers: Sadman Sakib, Ashrafur Rahman, Abul Sadman Khan Sporsho.')),
          const SizedBox(height: 18),
          OutlinedButton.icon(
            onPressed: () => _showMessage('You have been logged out.'),
            icon: const Icon(Icons.logout_rounded),
            label: const Text('Log Out'),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.redAccent,
              side: const BorderSide(color: Colors.redAccent),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) => Padding(
        padding: const EdgeInsets.only(top: 18, bottom: 8),
        child: Text(title,
            style: const TextStyle(
                color: _settingsCream,
                fontSize: 17,
                fontWeight: FontWeight.bold)),
      );

  Widget _switchTile(
      String title, IconData icon, bool value, ValueChanged<bool> onChanged) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: _settingsCream,
        borderRadius: BorderRadius.circular(16),
        child: SwitchListTile(
          value: value,
          onChanged: onChanged,
          activeThumbColor: _settingsAccent,
          secondary: Icon(icon, color: _settingsAccent),
          title: Text(title,
              style: const TextStyle(
                  color: _settingsText, fontWeight: FontWeight.w600)),
        ),
      ),
    );
  }

  Widget _actionTile(String title, IconData icon, VoidCallback? onTap) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: _settingsCream,
        borderRadius: BorderRadius.circular(16),
        child: ListTile(
          onTap: onTap,
          leading: Icon(icon, color: _settingsAccent),
          title: Text(title,
              style: const TextStyle(
                  color: _settingsText, fontWeight: FontWeight.w600)),
          trailing: onTap == null
              ? null
              : const Icon(Icons.chevron_right_rounded, color: _settingsText),
        ),
      ),
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), behavior: SnackBarBehavior.floating));
  }
}
