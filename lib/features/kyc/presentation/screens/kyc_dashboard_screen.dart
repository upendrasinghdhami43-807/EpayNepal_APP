import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class KycDashboardScreen extends StatelessWidget {
  const KycDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        title: const Text('KYC Verification'),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(24),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Status Hero Card
            Container(
              decoration: BoxDecoration(
                color: theme.brightness == Brightness.dark 
                    ? colorScheme.surfaceContainerHighest 
                    : colorScheme.surface,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(24),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Unlock Your Wallet',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Verify your identity to enjoy higher transaction limits and enhanced security for your digital payments.',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Graphic placeholder
                      Container(
                        height: 120,
                        decoration: BoxDecoration(
                          color: colorScheme.surfaceContainer,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Icon(Icons.fingerprint, size: 64, color: colorScheme.primary.withOpacity(0.4)),
                              Positioned(
                                top: 16,
                                left: 16,
                                child: Icon(Icons.security, color: colorScheme.primary.withOpacity(0.2)),
                              ),
                              Positioned(
                                bottom: 16,
                                right: 16,
                                child: Icon(Icons.verified_user, color: colorScheme.primary.withOpacity(0.2)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: colorScheme.errorContainer,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.warning, color: colorScheme.onErrorContainer, size: 14),
                          const SizedBox(width: 4),
                          Text(
                            'Unverified',
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: colorScheme.onErrorContainer,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Verification Steps
            Text('Verification Steps', style: theme.textTheme.titleMedium),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: theme.brightness == Brightness.dark 
                    ? colorScheme.surfaceContainerLow 
                    : colorScheme.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Connecting line
                  Positioned(
                    top: 20,
                    left: 20,
                    right: 20,
                    child: Container(
                      height: 2,
                      color: colorScheme.outlineVariant,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildStepItem(context, Icons.person, 'Personal Info', true),
                      _buildStepItem(context, Icons.location_on, 'Address', false),
                      _buildStepItem(context, Icons.description, 'Documents', false),
                      _buildStepItem(context, Icons.add_a_photo, 'Selfie', false),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Benefits Grid
            Row(
              children: [
                Expanded(
                  child: _buildBenefitCard(
                    context,
                    Icons.history,
                    'Fast Process',
                    'Takes less than 5 minutes to complete.',
                    colorScheme.tertiary,
                    colorScheme.tertiaryContainer,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildBenefitCard(
                    context,
                    Icons.payments,
                    'Higher Limits',
                    'Transact up to NPR 1,000,000.',
                    colorScheme.primary,
                    colorScheme.primaryContainer,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 100), // Padding for fixed bottom button
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: theme.brightness == Brightness.dark 
              ? colorScheme.background 
              : colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          child: ElevatedButton(
            // NOTE: In a real app, this uses go_router.
            onPressed: () {
              context.push('/kyc_personal_info');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.primary,
              foregroundColor: colorScheme.onPrimary,
              minimumSize: const Size.fromHeight(56),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
              elevation: 4,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('Start Verification', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(width: 8),
                Icon(Icons.arrow_forward),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStepItem(BuildContext context, IconData icon, String label, bool isActive) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: isActive ? colorScheme.primaryContainer : theme.scaffoldBackgroundColor,
            shape: BoxShape.circle,
            border: Border.all(
              color: isActive ? colorScheme.primary : colorScheme.outlineVariant,
              width: 2,
            ),
          ),
          child: Icon(
            icon,
            size: 20,
            color: isActive ? colorScheme.onPrimaryContainer : colorScheme.outline,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: theme.textTheme.labelMedium?.copyWith(
            color: isActive ? colorScheme.onSurfaceVariant : colorScheme.outline,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildBenefitCard(BuildContext context, IconData icon, String title, String subtitle, Color iconColor, Color bgColor) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.dark 
            ? colorScheme.surfaceContainerHighest 
            : colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorScheme.outlineVariant.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: bgColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(height: 12),
          Text(title, style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(subtitle, style: theme.textTheme.labelMedium?.copyWith(color: colorScheme.onSurfaceVariant)),
        ],
      ),
    );
  }
}
