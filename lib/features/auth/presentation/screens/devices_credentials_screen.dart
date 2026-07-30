import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/ui_feedback.dart';

class DevicesCredentialsScreen extends StatefulWidget {
  const DevicesCredentialsScreen({super.key});

  @override
  State<DevicesCredentialsScreen> createState() =>
      _DevicesCredentialsScreenState();
}

class _DevicesCredentialsScreenState extends State<DevicesCredentialsScreen> {
  bool _biometricEnabled = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        title: const Text('Devices & Credentials'),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Security Status Banner
            Container(
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Security Status',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: colorScheme.onPrimaryContainer,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Your account is currently secure.',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onPrimaryContainer.withOpacity(
                              0.9,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.shield_outlined,
                      size: 32,
                      color: colorScheme.onPrimaryContainer,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Credentials Management
            Text(
              'CREDENTIALS',
              style: theme.textTheme.labelLarge?.copyWith(
                color: colorScheme.onSurfaceVariant,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: theme.brightness == Brightness.dark
                    ? colorScheme.surfaceContainerHighest
                    : colorScheme.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildListTile(
                    context,
                    icon: Icons.pin,
                    title: 'Change MPIN',
                    subtitle: 'Update your mobile banking PIN',
                    onTap: () => UiFeedback.comingSoon(context, 'Change MPIN'),
                  ),
                  Divider(height: 1, color: colorScheme.surfaceVariant),
                  _buildListTile(
                    context,
                    icon: Icons.password,
                    title: 'Change Password',
                    subtitle: 'Update your login password',
                    onTap: () =>
                        UiFeedback.comingSoon(context, 'Change password'),
                  ),
                  Divider(height: 1, color: colorScheme.surfaceVariant),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: colorScheme.surfaceContainer,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.fingerprint,
                            color: colorScheme.primary,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Biometric Login',
                                style: theme.textTheme.titleMedium,
                              ),
                              Text(
                                'Use fingerprint or face ID',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Switch(
                          value: _biometricEnabled,
                          onChanged: (val) {
                            setState(() {
                              _biometricEnabled = val;
                            });
                          },
                          activeColor: colorScheme.primary,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Active Devices List
            Text(
              'ACTIVE DEVICES',
              style: theme.textTheme.labelLarge?.copyWith(
                color: colorScheme.onSurfaceVariant,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 16),
            _buildDeviceItem(
              context,
              icon: Icons.smartphone,
              name: 'iPhone 13 Pro',
              details: 'iOS 16.5 • App v2.4.1',
              status: 'Active Now',
              location: 'Kathmandu, NP',
              isCurrentDevice: true,
            ),
            const SizedBox(height: 16),
            _buildDeviceItem(
              context,
              icon: Icons.laptop_mac,
              name: 'MacBook Air M2',
              details: 'macOS Web Browser',
              status: 'Last active: Yesterday, 14:30',
              showRevoke: true,
            ),
            const SizedBox(height: 16),
            _buildDeviceItem(
              context,
              icon: Icons.android,
              name: 'Samsung Galaxy S21',
              details: 'Android 13 • App v2.4.0',
              status: 'Logged out: 12 Oct 2023',
              isFaded: true,
            ),

            const SizedBox(height: 32),
            Center(
              child: TextButton.icon(
                onPressed: () {
                  UiFeedback.showSnackBar(
                    context,
                    'Signed out from all devices',
                    icon: Icons.check_circle_outline,
                  );
                  context.go('/auth');
                },
                icon: const Icon(Icons.logout),
                label: const Text('Sign out of all devices'),
                style: TextButton.styleFrom(
                  foregroundColor: colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: colorScheme.primary),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: theme.textTheme.titleMedium),
                  Text(
                    subtitle,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: colorScheme.onSurfaceVariant),
          ],
        ),
      ),
    );
  }

  Widget _buildDeviceItem(
    BuildContext context, {
    required IconData icon,
    required String name,
    required String details,
    required String status,
    String? location,
    bool isCurrentDevice = false,
    bool showRevoke = false,
    bool isFaded = false,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Opacity(
      opacity: isFaded ? 0.6 : 1.0,
      child: Container(
        decoration: BoxDecoration(
          color: theme.brightness == Brightness.dark
              ? colorScheme.surfaceContainerHighest
              : colorScheme.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(24),
          border: isCurrentDevice
              ? Border.all(color: colorScheme.primary.withOpacity(0.2))
              : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            children: [
              if (isCurrentDevice)
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.primary,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                      ),
                    ),
                    child: Text(
                      'THIS DEVICE',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: isCurrentDevice
                            ? colorScheme.primaryContainer
                            : colorScheme.surfaceContainer,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        icon,
                        color: isCurrentDevice
                            ? colorScheme.onPrimaryContainer
                            : colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (isCurrentDevice) const SizedBox(height: 8),
                          Text(name, style: theme.textTheme.titleMedium),
                          Text(
                            details,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              if (isCurrentDevice) ...[
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: colorScheme.primary,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  status,
                                  style: theme.textTheme.labelLarge?.copyWith(
                                    color: colorScheme.primary,
                                  ),
                                ),
                                if (location != null)
                                  Text(
                                    ' • $location',
                                    style: theme.textTheme.labelLarge?.copyWith(
                                      color: colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                              ] else ...[
                                Expanded(
                                  child: Text(
                                    status,
                                    style: theme.textTheme.labelLarge?.copyWith(
                                      color: colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                    ),
                    if (showRevoke)
                      TextButton(
                        onPressed: () => UiFeedback.showSnackBar(
                          context,
                          '$name access revoked',
                          icon: Icons.security_update_warning,
                        ),
                        style: TextButton.styleFrom(
                          foregroundColor: colorScheme.error,
                          backgroundColor: colorScheme.errorContainer
                              .withOpacity(0.3),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                        ),
                        child: const Text('Revoke'),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
