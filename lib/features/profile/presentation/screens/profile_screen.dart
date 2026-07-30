import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/ui_feedback.dart';
import '../../../../core/widgets/buttons/primary_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () => UiFeedback.showSnackBar(
                context, 'Edit profile — coming soon'),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Avatar & name
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 96,
                      height: 96,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            colorScheme.primary,
                            colorScheme.primaryContainer,
                          ],
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'UD',
                          style: TextStyle(
                            color: colorScheme.onPrimary,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: colorScheme.primary,
                          shape: BoxShape.circle,
                          border:
                              Border.all(color: colorScheme.surface, width: 2),
                        ),
                        child: Icon(Icons.camera_alt,
                            size: 14, color: colorScheme.onPrimary),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Upendra Dhami',
                style: theme.textTheme.headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.verified, color: colorScheme.primary, size: 16),
                  const SizedBox(width: 4),
                  Text('KYC Verified',
                      style: theme.textTheme.labelMedium?.copyWith(
                          color: colorScheme.primary)),
                ],
              ),
              const SizedBox(height: 24),

              // FonePOINTS card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFFFF6F00),
                      const Color(0xFFFFCA28),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.stars, color: Colors.white, size: 32),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('FonePOINTS',
                            style: TextStyle(
                                color: Colors.white70, fontSize: 12)),
                        Text('1,240 pts',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Redeem',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Info card
              _InfoCard(
                context: context,
                items: [
                  _InfoItem(
                      icon: Icons.phone_outlined,
                      label: 'Phone',
                      value: '98 41234567'),
                  _InfoItem(
                      icon: Icons.email_outlined,
                      label: 'Email',
                      value: 'upendra@example.com'),
                  _InfoItem(
                      icon: Icons.badge_outlined,
                      label: 'Member Since',
                      value: 'Jan 2024'),
                ],
              ),
              const SizedBox(height: 16),

              // Menu options
              _ProfileMenuTile(
                icon: Icons.shield_outlined,
                title: 'Security Settings',
                onTap: () => context.pushNamed('security_settings'),
              ),
              _ProfileMenuTile(
                icon: Icons.settings_outlined,
                title: 'App Settings',
                onTap: () => context.pushNamed('app_settings'),
              ),
              _ProfileMenuTile(
                icon: Icons.language_outlined,
                title: 'Language',
                onTap: () => context.pushNamed('language'),
              ),
              _ProfileMenuTile(
                icon: Icons.verified_user_outlined,
                title: 'KYC Status',
                onTap: () => context.pushNamed('kyc_status'),
              ),
              _ProfileMenuTile(
                icon: Icons.headset_mic_outlined,
                title: 'Customer Support',
                onTap: () => context.go('/support'),
              ),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: () => _confirmLogout(context),
                icon: const Icon(Icons.logout, color: Colors.red),
                label: const Text('Log Out',
                    style: TextStyle(color: Colors.red)),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.red),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _confirmLogout(BuildContext context) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Log Out?'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancel')),
          FilledButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Log Out')),
        ],
      ),
    );
    if (confirm == true && context.mounted) {
      context.go('/login');
    }
  }
}

class _InfoCard extends StatelessWidget {
  final BuildContext context;
  final List<_InfoItem> items;

  const _InfoCard({required this.context, required this.items});

  @override
  Widget build(BuildContext buildContext) {
    final theme = Theme.of(buildContext);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
            color: colorScheme.outlineVariant.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: items
            .map((item) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      Icon(item.icon,
                          size: 18, color: colorScheme.primary),
                      const SizedBox(width: 12),
                      Text(item.label,
                          style: theme.textTheme.bodySmall
                              ?.copyWith(color: colorScheme.onSurfaceVariant)),
                      const Spacer(),
                      Text(item.value,
                          style: theme.textTheme.titleSmall
                              ?.copyWith(fontWeight: FontWeight.w600)),
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }
}

class _InfoItem {
  final IconData icon;
  final String label;
  final String value;
  const _InfoItem({required this.icon, required this.label, required this.value});
}

class _ProfileMenuTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _ProfileMenuTile({
    required this.icon,
    required this.title,
    required this.onTap,
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
      trailing: const Icon(Icons.chevron_right, size: 18),
      onTap: onTap,
    );
  }
}
