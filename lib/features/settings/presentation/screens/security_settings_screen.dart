import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/ui_feedback.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/buttons/primary_button.dart';
import '../../../../core/widgets/inputs/custom_text_field.dart';

class SecuritySettingsScreen extends StatefulWidget {
  const SecuritySettingsScreen({super.key});

  @override
  State<SecuritySettingsScreen> createState() =>
      _SecuritySettingsScreenState();
}

class _SecuritySettingsScreenState extends State<SecuritySettingsScreen> {
  bool _biometricEnabled = true;
  bool _loginNotificationEnabled = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Security Settings'),
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
            // Section: Authentication
            _sectionTitle(context, 'Authentication'),
            const SizedBox(height: 8),
            _ActionCard(
              icon: Icons.pin,
              title: 'Change Transaction PIN',
              subtitle: 'Update your 4-digit PIN',
              onTap: () => _showChangePinSheet(context),
            ),
            const SizedBox(height: 8),
            _ActionCard(
              icon: Icons.lock_reset_outlined,
              title: 'Change Password',
              subtitle: 'Update your account password',
              onTap: () => _showChangePasswordSheet(context),
            ),
            const SizedBox(height: 16),

            // Section: Biometric
            _sectionTitle(context, 'Biometric'),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerLow,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                    color: colorScheme.outlineVariant.withValues(alpha: 0.2)),
              ),
              child: SwitchListTile(
                title: Text('Face ID / Fingerprint',
                    style: theme.textTheme.titleSmall),
                subtitle: Text('Use biometrics to log in',
                    style: theme.textTheme.bodySmall
                        ?.copyWith(color: colorScheme.onSurfaceVariant)),
                secondary: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color:
                        colorScheme.primaryContainer.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.fingerprint,
                      color: colorScheme.primary, size: 20),
                ),
                value: _biometricEnabled,
                activeThumbColor: colorScheme.primary,
                onChanged: (val) => setState(() => _biometricEnabled = val),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
              ),
            ),
            const SizedBox(height: 16),

            // Section: Notifications
            _sectionTitle(context, 'Security Alerts'),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerLow,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                    color: colorScheme.outlineVariant.withValues(alpha: 0.2)),
              ),
              child: SwitchListTile(
                title: Text('Login Notifications',
                    style: theme.textTheme.titleSmall),
                subtitle: Text('Get alerted on new device logins',
                    style: theme.textTheme.bodySmall
                        ?.copyWith(color: colorScheme.onSurfaceVariant)),
                secondary: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color:
                        colorScheme.primaryContainer.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.notifications_active_outlined,
                      color: colorScheme.primary, size: 20),
                ),
                value: _loginNotificationEnabled,
                activeThumbColor: colorScheme.primary,
                onChanged: (val) =>
                    setState(() => _loginNotificationEnabled = val),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
              ),
            ),
            const SizedBox(height: 16),

            // Manage Devices
            _ActionCard(
              icon: Icons.devices_outlined,
              title: 'Manage Devices',
              subtitle: 'View and revoke active sessions',
              onTap: () => context.pushNamed('devices'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(title,
          style: Theme.of(context)
              .textTheme
              .labelLarge
              ?.copyWith(color: Theme.of(context).colorScheme.primary)),
    );
  }

  void _showChangePinSheet(BuildContext context) {
    final currentPin = TextEditingController();
    final newPin = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) => Padding(
        padding: EdgeInsets.fromLTRB(
            24, 24, 24, MediaQuery.of(ctx).viewInsets.bottom + 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Change PIN',
                style: Theme.of(ctx).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            CustomTextField(
                label: 'Current PIN',
                controller: currentPin,
                obscureText: true,
                keyboardType: TextInputType.number,
                maxLength: 4),
            const SizedBox(height: 12),
            CustomTextField(
                label: 'New PIN (4 digits)',
                controller: newPin,
                obscureText: true,
                keyboardType: TextInputType.number,
                maxLength: 4),
            const SizedBox(height: 16),
            PrimaryButton(
              text: 'Update PIN',
              onPressed: () {
                Navigator.pop(ctx);
                UiFeedback.showSnackBar(context, 'PIN updated successfully',
                    icon: Icons.check_circle_outline);
              },
            ),
          ],
        ),
      ),
    );
    currentPin.dispose();
    newPin.dispose();
  }

  void _showChangePasswordSheet(BuildContext context) {
    final oldPwd = TextEditingController();
    final newPwd = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) => Padding(
        padding: EdgeInsets.fromLTRB(
            24, 24, 24, MediaQuery.of(ctx).viewInsets.bottom + 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Change Password',
                style: Theme.of(ctx).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            CustomTextField(
                label: 'Current Password',
                controller: oldPwd,
                obscureText: true),
            const SizedBox(height: 12),
            CustomTextField(
                label: 'New Password',
                controller: newPwd,
                obscureText: true,
                validator: AppValidators.password),
            const SizedBox(height: 16),
            PrimaryButton(
              text: 'Update Password',
              onPressed: () {
                Navigator.pop(ctx);
                UiFeedback.showSnackBar(
                    context, 'Password updated successfully',
                    icon: Icons.check_circle_outline);
              },
            ),
          ],
        ),
      ),
    );
    oldPwd.dispose();
    newPwd.dispose();
  }
}

class _ActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      elevation: 0,
      color: colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
        subtitle: Text(subtitle,
            style: theme.textTheme.bodySmall
                ?.copyWith(color: colorScheme.onSurfaceVariant)),
        trailing: const Icon(Icons.chevron_right, size: 18),
        onTap: onTap,
      ),
    );
  }
}
