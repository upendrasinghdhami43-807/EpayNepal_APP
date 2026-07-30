import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../../../core/utils/ui_feedback.dart';
import '../../../../core/widgets/buttons/primary_button.dart';

/// Reusable KYC document upload screen for citizenship front/back.
class KycDocumentUploadScreen extends StatefulWidget {
  final String side; // 'front' or 'back'

  const KycDocumentUploadScreen({super.key, required this.side});

  @override
  State<KycDocumentUploadScreen> createState() =>
      _KycDocumentUploadScreenState();
}

class _KycDocumentUploadScreenState extends State<KycDocumentUploadScreen> {
  File? _image;
  bool _isLoading = false;

  Future<void> _pickImage(ImageSource source) async {
    try {
      final picker = ImagePicker();
      final picked = await picker.pickImage(
        source: source,
        imageQuality: 80,
        maxWidth: 1280,
      );
      if (picked == null) return;
      setState(() => _image = File(picked.path));
    } catch (e) {
      if (mounted) {
        UiFeedback.showSnackBar(context, 'Could not open camera/gallery',
            icon: Icons.error_outline);
      }
    }
  }

  Future<void> _upload() async {
    if (_image == null) {
      UiFeedback.showSnackBar(context, 'Please capture or upload the document',
          icon: Icons.warning_amber_rounded);
      return;
    }
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 1500));
    if (!mounted) return;
    setState(() => _isLoading = false);

    final isFront = widget.side == 'front';
    if (isFront) {
      context.pushNamed('kyc_citizenship_back');
    } else {
      context.pushNamed('kyc_selfie');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isFront = widget.side == 'front';
    final title = isFront ? 'Citizenship Front' : 'Citizenship Back';

    return Scaffold(
      appBar: AppBar(
        title: Text('Upload $title'),
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
              // Progress tracker
              _KycProgressBar(currentStep: isFront ? 1 : 2),
              const SizedBox(height: 32),

              Text(
                'Upload $title',
                style: theme.textTheme.headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Take a clear photo of your ${isFront ? 'front' : 'back'} side of citizenship certificate.',
                style: theme.textTheme.bodyMedium
                    ?.copyWith(color: colorScheme.onSurfaceVariant),
              ),
              const SizedBox(height: 32),

              // Image preview / placeholder
              GestureDetector(
                onTap: () => _showSourceDialog(),
                child: Container(
                  height: 220,
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: _image != null
                          ? colorScheme.primary
                          : colorScheme.outlineVariant,
                      style: BorderStyle.solid,
                      width: _image != null ? 2 : 1,
                    ),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: _image != null
                      ? Image.file(_image!, fit: BoxFit.cover)
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              isFront
                                  ? Icons.credit_card
                                  : Icons.flip_to_back_outlined,
                              size: 56,
                              color: colorScheme.outlineVariant,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Tap to capture / upload',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                  color: colorScheme.onSurfaceVariant),
                            ),
                          ],
                        ),
                ),
              ),
              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _pickImage(ImageSource.camera),
                      icon: const Icon(Icons.camera_alt_outlined),
                      label: const Text('Camera'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _pickImage(ImageSource.gallery),
                      icon: const Icon(Icons.photo_library_outlined),
                      label: const Text('Gallery'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),

              // Guidelines
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color:
                      colorScheme.tertiaryContainer.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    for (final tip in [
                      'Ensure good lighting and no reflections',
                      'All four corners of the document must be visible',
                      'Photo must be clear and in focus',
                    ])
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3),
                        child: Row(
                          children: [
                            Icon(Icons.check_circle_outline,
                                size: 14, color: colorScheme.tertiary),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(tip,
                                  style: theme.textTheme.labelSmall?.copyWith(
                                      color: colorScheme.onSurfaceVariant)),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              PrimaryButton(
                text: 'Continue',
                isLoading: _isLoading,
                onPressed: _upload,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSourceDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt_outlined),
              title: const Text('Take Photo'),
              onTap: () {
                Navigator.pop(ctx);
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: const Text('Choose from Gallery'),
              onTap: () {
                Navigator.pop(ctx);
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _KycProgressBar extends StatelessWidget {
  final int currentStep; // 1–4

  const _KycProgressBar({required this.currentStep});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final steps = ['Personal', 'Front', 'Back', 'Selfie', 'Status'];

    return Row(
      children: List.generate(steps.length, (i) {
        final step = i + 1;
        final isActive = step == currentStep;
        final isDone = step < currentStep;

        return Expanded(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Container(
                      height: 4,
                      decoration: BoxDecoration(
                        color: isDone || isActive
                            ? colorScheme.primary
                            : colorScheme.outlineVariant,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      steps[i],
                      style: TextStyle(
                        fontSize: 9,
                        color: isActive
                            ? colorScheme.primary
                            : colorScheme.outlineVariant,
                        fontWeight: isActive
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              if (i < steps.length - 1)
                const SizedBox(width: 4),
            ],
          ),
        );
      }),
    );
  }
}
