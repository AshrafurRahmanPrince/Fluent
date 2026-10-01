import 'package:flutter/material.dart';

import '../services/theme_provider.dart';

class SettingsScreen extends StatefulWidget {
  final ThemeProvider? themeProvider;

  const SettingsScreen({super.key, this.themeProvider});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _dailyReminder = true;
  bool _soundEffects = true;

  @override
  Widget build(BuildContext context) {
    final themeProvider = widget.themeProvider ?? ThemeProvider.instance;

    return AnimatedBuilder(
      animation: themeProvider,
      builder: (context, _) {
        final colors = Theme.of(context).colorScheme;
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            backgroundColor: colors.surface,
            foregroundColor: colors.onSurface,
            title: const Text('Settings'),
          ),
          body: ListView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
            children: [
              _sectionTitle(context, 'App Preferences'),
              _switchTile(
                context,
                'Daily Reminder Notifications',
                Icons.notifications_outlined,
                _dailyReminder,
                (value) => setState(() => _dailyReminder = value),
              ),
              _switchTile(
                context,
                'Sound Effects',
                Icons.volume_up_outlined,
                _soundEffects,
                (value) => setState(() => _soundEffects = value),
              ),
              _sectionTitle(context, 'Account'),
              _actionTile(
                context,
                'Edit Profile',
                Icons.person_outline_rounded,
                () => _showMessage('Profile editing is ready to connect.'),
              ),
              _actionTile(
                context,
                'Change Password',
                Icons.lock_outline_rounded,
                () => _showMessage('Password changing is ready to connect.'),
              ),
              _switchTile(
                context,
                'Dark Mode',
                Icons.dark_mode_outlined,
                themeProvider.isDarkMode,
                themeProvider.setDarkMode,
              ),
              _sectionTitle(context, 'About'),
              _actionTile(
                context,
                'v1.0.0 - Fluent',
                Icons.info_outline_rounded,
                null,
              ),
              _actionTile(
                context,
                'About Developer',
                Icons.code_rounded,
                () => _showMessage(
                  'Developers: Sadman Sakib, Ashrafur Rahman, Abul Sadman Khan Sporsho.',
                ),
              ),
              const SizedBox(height: 18),
              OutlinedButton.icon(
                onPressed: () => _showMessage('You have been logged out.'),
                icon: const Icon(Icons.logout_rounded),
                label: const Text('Log Out'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: colors.error,
                  side: BorderSide(color: colors.error),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _sectionTitle(BuildContext context, String title) => Padding(
        padding: const EdgeInsets.only(top: 18, bottom: 8),
        child: Text(
          title,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
      );

  Widget _switchTile(
    BuildContext context,
    String title,
    IconData icon,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: colors.surfaceContainer,
        borderRadius: BorderRadius.circular(16),
        child: SwitchListTile(
          value: value,
          onChanged: onChanged,
          activeThumbColor: colors.primary,
          secondary: Icon(icon, color: colors.primary),
          title: Text(
            title,
            style: TextStyle(
              color: colors.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _actionTile(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback? onTap,
  ) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: colors.surfaceContainer,
        borderRadius: BorderRadius.circular(16),
        child: ListTile(
          onTap: onTap,
          leading: Icon(icon, color: colors.primary),
          title: Text(
            title,
            style: TextStyle(
              color: colors.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
          trailing: onTap == null
              ? null
              : Icon(Icons.chevron_right_rounded, color: colors.onSurface),
        ),
      ),
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
    );
  }
}
