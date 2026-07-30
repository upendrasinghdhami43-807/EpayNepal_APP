import 'package:flutter/material.dart';
import '../../../../core/utils/ui_feedback.dart';

class AppSettingsScreen extends StatefulWidget {
  const AppSettingsScreen({super.key});

  @override
  State<AppSettingsScreen> createState() => _AppSettingsScreenState();
}

class _AppSettingsScreenState extends State<AppSettingsScreen> {
  bool _pushNotifications = true;
  bool _transactionAlerts = true;
  bool _promoNotifications = false;
  bool _soundEnabled = true;
  bool _vibrationEnabled = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('App Settings'),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Notifications
            _sectionTitle(context, 'Notifications'),
            const SizedBox(height: 8),
            _SwitchCard(
              icon: Icons.notifications_outlined,
              title: 'Push Notifications',
              subtitle: 'Receive app notifications',
              value: _pushNotifications,
              onChanged: (v) => setState(() => _pushNotifications = v),
            ),
            const SizedBox(height: 8),
            _SwitchCard(
              icon: Icons.swap_horiz,
              title: 'Transaction Alerts',
              subtitle: 'Get notified on every transaction',
              value: _transactionAlerts,
              onChanged: (v) => setState(() => _transactionAlerts = v),
            ),
            const SizedBox(height: 8),
            _SwitchCard(
              icon: Icons.local_offer_outlined,
              title: 'Promotions',
              subtitle: 'Deals, cashback and offers',
              value: _promoNotifications,
              onChanged: (v) => setState(() => _promoNotifications = v),
            ),
            const SizedBox(height: 16),

            // Sound & Feedback
            _sectionTitle(context, 'Feedback'),
            const SizedBox(height: 8),
            _SwitchCard(
              icon: Icons.volume_up_outlined,
              title: 'Sound',
              subtitle: 'Enable sounds on actions',
              value: _soundEnabled,
              onChanged: (v) => setState(() => _soundEnabled = v),
            ),
            const SizedBox(height: 8),
            _SwitchCard(
              icon: Icons.vibration,
              title: 'Vibration',
              subtitle: 'Haptic feedback',
              value: _vibrationEnabled,
              onChanged: (v) => setState(() => _vibrationEnabled = v),
            ),
            const SizedBox(height: 16),

            // App Info
            _sectionTitle(context, 'About'),
            const SizedBox(height: 8),
            _InfoTile(
              icon: Icons.info_outline,
              title: 'App Version',
              trailing: '1.0.0',
            ),
            _InfoTile(
              icon: Icons.gavel_outlined,
              title: 'Terms & Conditions',
              onTap: () =>
                  UiFeedback.showSnackBar(context, 'Opening terms...'),
            ),
            _InfoTile(
              icon: Icons.privacy_tip_outlined,
              title: 'Privacy Policy',
              onTap: () =>
                  UiFeedback.showSnackBar(context, 'Opening privacy policy...'),
            ),
            _InfoTile(
              icon: Icons.delete_outline,
              title: 'Clear Cache',
              onTap: () async {
                await Future.delayed(const Duration(milliseconds: 700));
                if (context.mounted) {
                  UiFeedback.showSnackBar(context, 'Cache cleared',
                      icon: Icons.check_circle_outline);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 2),
      child: Text(title,
          style: Theme.of(context)
              .textTheme
              .labelLarge
              ?.copyWith(color: Theme.of(context).colorScheme.primary)),
    );
  }
}

class _SwitchCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SwitchCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
            color: colorScheme.outlineVariant.withValues(alpha: 0.2)),
      ),
      child: SwitchListTile(
        secondary: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: colorScheme.primary, size: 20),
        ),
        title: Text(title, style: theme.textTheme.titleSmall),
        subtitle: Text(subtitle,
            style: theme.textTheme.bodySmall
                ?.copyWith(color: colorScheme.onSurfaceVariant)),
        value: value,
        activeColor: colorScheme.primary,
        onChanged: onChanged,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? trailing;
  final VoidCallback? onTap;

  const _InfoTile({
    required this.icon,
    required this.title,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: colorScheme.primaryContainer.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: colorScheme.primary, size: 20),
      ),
      title: Text(title, style: theme.textTheme.titleSmall),
      trailing: trailing != null
          ? Text(trailing!,
              style: theme.textTheme.bodySmall
                  ?.copyWith(color: colorScheme.onSurfaceVariant))
          : (onTap != null
              ? const Icon(Icons.chevron_right, size: 18)
              : null),
      onTap: onTap,
    );
  }
}
