import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../../../core/utils/ui_feedback.dart';
import '../../../../core/widgets/buttons/primary_button.dart';

class KycSelfieScreen extends StatefulWidget {
  const KycSelfieScreen({super.key});

  @override
  State<KycSelfieScreen> createState() => _KycSelfieScreenState();
}

class _KycSelfieScreenState extends State<KycSelfieScreen> {
  File? _selfie;
  bool _isLoading = false;

  Future<void> _takeSelfie() async {
    try {
      final picker = ImagePicker();
      final picked = await picker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.front,
        imageQuality: 80,
      );
      if (picked == null) return;
      setState(() => _selfie = File(picked.path));
    } catch (e) {
      if (mounted) {
        UiFeedback.showSnackBar(context, 'Could not open camera',
            icon: Icons.error_outline);
      }
    }
  }

  Future<void> _submit() async {
    if (_selfie == null) {
      UiFeedback.showSnackBar(context, 'Please capture your selfie',
          icon: Icons.warning_amber_rounded);
      return;
    }
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 1500));
    if (!mounted) return;
    setState(() => _isLoading = false);
    context.pushNamed('kyc_address');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Selfie Verification'),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              Text(
                'Take a selfie',
                style: theme.textTheme.headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Hold your phone at eye level and look straight at the camera.',
                style: theme.textTheme.bodyMedium
                    ?.copyWith(color: colorScheme.onSurfaceVariant),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              // Face frame
              GestureDetector(
                onTap: _takeSelfie,
                child: Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 220,
                        height: 260,
                        decoration: BoxDecoration(
                          color: colorScheme.surfaceContainerLow,
                          borderRadius: BorderRadius.circular(120),
                          border: Border.all(
                            color: _selfie != null
                                ? colorScheme.primary
                                : colorScheme.outlineVariant,
                            width: 2,
                          ),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: _selfie != null
                            ? Image.file(_selfie!, fit: BoxFit.cover)
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.face,
                                      size: 72,
                                      color: colorScheme.outlineVariant),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Tap to take selfie',
                                    style: theme.textTheme.labelMedium
                                        ?.copyWith(
                                            color: colorScheme.onSurfaceVariant),
                                  ),
                                ],
                              ),
                      ),
                      if (_selfie != null)
                        Positioned(
                          bottom: 10,
                          right: 20,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: colorScheme.primary,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.check,
                                color: colorScheme.onPrimary, size: 18),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Tips
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color:
                      colorScheme.tertiaryContainer.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    for (final tip in [
                      'Remove glasses and face mask',
                      'Ensure good, even lighting on your face',
                      'Keep your face fully in the oval frame',
                    ])
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          children: [
                            Icon(Icons.circle, size: 6, color: colorScheme.tertiary),
                            const SizedBox(width: 8),
                            Expanded(
                                child: Text(tip,
                                    style: theme.textTheme.bodySmall?.copyWith(
                                        color: colorScheme.onSurfaceVariant))),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              const Spacer(),
              if (_selfie != null)
                OutlinedButton.icon(
                  onPressed: _takeSelfie,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Retake'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                  ),
                ),
              const SizedBox(height: 12),
              PrimaryButton(
                text: _selfie == null ? 'Take Selfie' : 'Continue',
                isLoading: _isLoading,
                onPressed: _selfie == null ? _takeSelfie : _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
