import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/buttons/primary_button.dart';

class BiometricSetupScreen extends StatefulWidget {
  const BiometricSetupScreen({super.key});

  @override
  State<BiometricSetupScreen> createState() => _BiometricSetupScreenState();
}

class _BiometricSetupScreenState extends State<BiometricSetupScreen> {
  bool _isLoading = false;

  Future<void> _enableBiometric() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 1200));
    if (!mounted) return;
    setState(() => _isLoading = false);
    context.goNamed('home');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(flex: 2),
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      colorScheme.primaryContainer,
                      colorScheme.primary,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.fingerprint, size: 64, color: colorScheme.onPrimary),
              ),
              const SizedBox(height: 40),
              Text(
                'Enable Biometric Login',
                style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Use your fingerprint or Face ID to log in quickly and securely — no password needed next time.',
                style: theme.textTheme.bodyLarge?.copyWith(
                    color: colorScheme.onSurfaceVariant),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              _buildFeatureRow(context, Icons.speed, 'Quick Access',
                  'Log in in under a second'),
              const SizedBox(height: 16),
              _buildFeatureRow(context, Icons.security, 'More Secure',
                  'No PIN to type, no shoulder surfing'),
              const SizedBox(height: 16),
              _buildFeatureRow(context, Icons.privacy_tip, 'Private',
                  'Biometrics never leave your device'),
              const Spacer(flex: 3),
              PrimaryButton(
                text: 'Enable Biometric',
                isLoading: _isLoading,
                onPressed: _enableBiometric,
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => context.goNamed('home'),
                child: Text(
                  'Skip for now',
                  style: TextStyle(color: colorScheme.onSurfaceVariant),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureRow(
      BuildContext context, IconData icon, String title, String desc) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: colorScheme.primary),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: theme.textTheme.titleSmall
                      ?.copyWith(fontWeight: FontWeight.bold)),
              Text(desc,
                  style: theme.textTheme.bodySmall
                      ?.copyWith(color: colorScheme.onSurfaceVariant)),
            ],
          ),
        ),
      ],
    );
  }
}
