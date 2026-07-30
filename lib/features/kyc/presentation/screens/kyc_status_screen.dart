import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/ui_feedback.dart';

enum KycStatus { notStarted, pending, approved, rejected }

class KycStatusScreen extends StatelessWidget {
  const KycStatusScreen({super.key});

  static const KycStatus _status = KycStatus.pending;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('KYC Status'),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Status Hero
              _StatusHero(status: _status),
              const SizedBox(height: 32),

              // Steps timeline
              Text('Verification Steps',
                  style: theme.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              _TimelineItem(
                title: 'Personal Information',
                subtitle: 'Name, date of birth, phone',
                isDone: true,
                isActive: false,
              ),
              _TimelineItem(
                title: 'Citizenship Front',
                subtitle: 'Document photo uploaded',
                isDone: true,
                isActive: false,
              ),
              _TimelineItem(
                title: 'Citizenship Back',
                subtitle: 'Document photo uploaded',
                isDone: true,
                isActive: false,
              ),
              _TimelineItem(
                title: 'Selfie Verification',
                subtitle: 'Live selfie captured',
                isDone: true,
                isActive: false,
              ),
              _TimelineItem(
                title: 'Under Review',
                subtitle: 'KYC officer reviewing documents (1–2 business days)',
                isDone: false,
                isActive: _status == KycStatus.pending,
                isLast: true,
              ),

              if (_status == KycStatus.approved) ...[
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                        color: colorScheme.primary.withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.check_circle, color: colorScheme.primary),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('KYC Approved',
                                style: theme.textTheme.titleSmall
                                    ?.copyWith(fontWeight: FontWeight.bold)),
                            Text(
                                'Your account is verified. Transaction limits upgraded to NPR 1,000,000/day.',
                                style: theme.textTheme.bodySmall?.copyWith(
                                    color: colorScheme.onSurfaceVariant)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              if (_status == KycStatus.rejected) ...[
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: colorScheme.errorContainer.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                        color: colorScheme.error.withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.cancel_outlined, color: colorScheme.error),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('KYC Rejected',
                                style: theme.textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: colorScheme.error)),
                            Text('Reason: Photo of citizenship was blurry. Please re-upload.',
                                style: theme.textTheme.bodySmall?.copyWith(
                                    color: colorScheme.onSurfaceVariant)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                FilledButton.icon(
                  onPressed: () => context.pushNamed('kyc_dashboard'),
                  icon: const Icon(Icons.refresh),
                  label: const Text('Re-submit KYC'),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusHero extends StatelessWidget {
  final KycStatus status;
  const _StatusHero({required this.status});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final (icon, color, label, sub) = switch (status) {
      KycStatus.pending => (
          Icons.pending_actions,
          Colors.orange,
          'Under Review',
          'Your documents are being verified by our team.',
        ),
      KycStatus.approved => (
          Icons.verified_user,
          colorScheme.primary,
          'KYC Approved',
          'Your identity has been verified successfully.',
        ),
      KycStatus.rejected => (
          Icons.report_problem_outlined,
          colorScheme.error,
          'KYC Rejected',
          'Please check the reason below and re-submit.',
        ),
      _ => (
          Icons.upload_file,
          colorScheme.secondary,
          'Not Started',
          'Begin your KYC verification to unlock higher limits.',
        ),
    };

    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          Icon(icon, size: 56, color: color),
          const SizedBox(height: 16),
          Text(label,
              style: theme.textTheme.headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold, color: color)),
          const SizedBox(height: 8),
          Text(sub,
              style: theme.textTheme.bodyMedium
                  ?.copyWith(color: colorScheme.onSurfaceVariant),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class _TimelineItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isDone;
  final bool isActive;
  final bool isLast;

  const _TimelineItem({
    required this.title,
    required this.subtitle,
    required this.isDone,
    required this.isActive,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final dotColor = isDone
        ? colorScheme.primary
        : (isActive ? Colors.orange : colorScheme.outlineVariant);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 32,
            child: Column(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: dotColor.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                    border: Border.all(color: dotColor, width: 2),
                  ),
                  child: isDone
                      ? Icon(Icons.check, size: 12, color: dotColor)
                      : (isActive
                          ? Icon(Icons.circle, size: 8, color: dotColor)
                          : null),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                        width: 2,
                        color: colorScheme.outlineVariant
                            .withValues(alpha: 0.4)),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: theme.textTheme.titleSmall
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 2),
                  Text(subtitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
