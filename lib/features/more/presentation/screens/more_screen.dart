import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/ui_feedback.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        title: const Text('More'),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () => context.push('/notifications'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Profile Summary Bento
            Container(
              decoration: BoxDecoration(
                color: theme.brightness == Brightness.dark
                    ? colorScheme.surfaceContainerHighest
                    : colorScheme.surfaceContainerLow,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: colorScheme.outlineVariant.withValues(alpha: 0.3),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 4,
                  ),
                ],
              ),
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: colorScheme.primary,
                            width: 2,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: CircleAvatar(
                            backgroundColor: colorScheme.primaryContainer,
                            child: Icon(
                              Icons.person,
                              color: colorScheme.onPrimaryContainer,
                              size: 32,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Upendra Singh Dhami',
                              style: theme.textTheme.titleMedium,
                            ),
                            Text(
                              '9841234567',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(
                                  Icons.verified,
                                  color: colorScheme.primary,
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'Active / Verified',
                                  style: theme.textTheme.labelMedium?.copyWith(
                                    color: colorScheme.primary,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: colorScheme.primary,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Balance',
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.8),
                                fontSize: 12,
                              ),
                            ),
                            const Text(
                              'Rs. 500,000.00',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: 1,
                          height: 32,
                          color: Colors.white.withValues(alpha: 0.2),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Fonepoints',
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.8),
                                fontSize: 12,
                              ),
                            ),
                            const Text(
                              '1,250',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // My Accounts Section
            _buildSectionHeader(context, 'MY ACCOUNTS'),
            _buildSection(context, [
              _buildListItem(
                context,
                Icons.business_center,
                'Business Accounts',
              ),
              _buildListItem(context, Icons.calendar_month, 'My Calendar'),
              _buildListItem(
                context,
                Icons.account_balance_wallet,
                'Transaction Limits',
              ),
              _buildListItem(context, Icons.devices, 'Devices & Credentials'),
              _buildListItem(context, Icons.analytics, 'Finance360'),
            ]),
            const SizedBox(height: 24),

            // Settings Section
            _buildSectionHeader(context, 'SETTINGS'),
            _buildSection(context, [
              _buildListItem(
                context,
                Icons.bug_report,
                'Test Demo Settings',
                isHighlighted: true,
              ),
              _buildListItem(context, Icons.palette, 'Appearance'),
              _buildListItem(context, Icons.language, 'Language'),
              _buildListItem(context, Icons.notifications, 'Notifications'),
            ]),
            const SizedBox(height: 24),

            // Security Section
            _buildSectionHeader(context, 'SECURITY & PERMISSIONS'),
            _buildSection(context, [
              _buildListItem(context, Icons.lock_open, 'Permission'),
              _buildListItem(context, Icons.security, 'Security'),
            ]),
            const SizedBox(height: 24),

            // Info Section
            _buildSectionHeader(context, 'HELP & INFO'),
            _buildSection(context, [
              _buildListItem(context, Icons.help, 'Help & FAQs'),
              _buildListItem(context, Icons.campaign, 'Offers & Campaigns'),
              _buildListItem(context, Icons.info, 'About'),
            ]),
            const SizedBox(height: 24),

            // Logout Button
            ElevatedButton(
              onPressed: () => context.go('/auth'),
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.errorContainer,
                foregroundColor: colorScheme.onErrorContainer,
                minimumSize: const Size.fromHeight(56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.logout),
                  SizedBox(width: 8),
                  Text(
                    'Logout Account',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            Center(
              child: Text(
                'App Version 5.24.1 (Stable)',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: colorScheme.outlineVariant,
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
      child: Text(
        title,
        style: theme.textTheme.labelMedium?.copyWith(
          color: colorScheme.outline,
          letterSpacing: 1.2,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, List<Widget> children) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.dark
            ? colorScheme.surfaceContainerHighest
            : colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: colorScheme.outlineVariant.withValues(alpha: 0.2)),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildListItem(
    BuildContext context,
    IconData icon,
    String title, {
    bool isHighlighted = false,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return InkWell(
      onTap: () => _handleMenuTap(context, title),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: isHighlighted
              ? colorScheme.primaryContainer.withValues(alpha: 0.1)
              : Colors.transparent,
          border: Border(
            bottom: BorderSide(
              color: colorScheme.outlineVariant.withValues(alpha: 0.1),
            ),
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: colorScheme.primary),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: isHighlighted
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
            ),
            Icon(Icons.chevron_right, color: colorScheme.outlineVariant),
          ],
        ),
      ),
    );
  }

  void _handleMenuTap(BuildContext context, String title) {
    switch (title) {
      case 'Devices & Credentials':
        context.push('/devices');
        return;
      case 'Help & FAQs':
        context.go('/support');
        return;
      case 'Test Demo Settings':
        context.push('/test_demo_settings');
        return;
      case 'Language':
        context.push('/language');
        return;
      case 'Notifications':
        context.push('/notifications');
        return;
      case 'Security':
        context.push('/security_settings');
        return;
      case 'Appearance':
        context.push('/app_settings');
        return;
      case 'KYC Status':
        context.push('/kyc_status');
        return;
      case 'My Profile':
        context.push('/profile');
        return;
      case 'Business Accounts':
      case 'My Calendar':
      case 'Transaction Limits':
      case 'Finance360':
      case 'Permission':
      case 'Offers & Campaigns':
      case 'About':
        UiFeedback.comingSoon(context, title);
        return;
      default:
        UiFeedback.comingSoon(context);
    }
  }
}
