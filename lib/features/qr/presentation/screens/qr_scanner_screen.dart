import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../../../core/utils/ui_feedback.dart';

class QrScannerScreen extends StatefulWidget {
  const QrScannerScreen({super.key});

  @override
  State<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen>
    with SingleTickerProviderStateMixin {
  final MobileScannerController _scannerController = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
    facing: CameraFacing.back,
  );

  final ImagePicker _imagePicker = ImagePicker();
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _isHandlingScan = false;
  bool _flashOn = false;
  int _zoomLevel = 1;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2, milliseconds: 500),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 280).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scannerController.dispose();
    super.dispose();
  }

  Future<void> _toggleFlash() async {
    try {
      await _scannerController.toggleTorch();
      if (!mounted) return;
      setState(() {
        _flashOn = !_flashOn;
      });
    } catch (_) {
      if (!mounted) return;
      UiFeedback.showSnackBar(
        context,
        'Flash is not available on this device',
        icon: Icons.flash_off,
      );
    }
  }

  Future<void> _setZoomLevel(int level) async {
    final zoomScale = switch (level) {
      1 => 0.0,
      2 => 0.5,
      _ => 1.0,
    };

    await _scannerController.setZoomScale(zoomScale);
    if (!mounted) return;
    setState(() {
      _zoomLevel = level;
    });
  }

  Future<void> _handleDetectedBarcode(BarcodeCapture capture) async {
    if (_isHandlingScan) return;

    String? scannedValue;
    for (final barcode in capture.barcodes) {
      final raw = barcode.rawValue?.trim();
      if (raw != null && raw.isNotEmpty) {
        scannedValue = raw;
        break;
      }
    }

    if (scannedValue == null) return;

    _isHandlingScan = true;
    await _scannerController.pause();
    if (!mounted) return;

    final action = await showModalBottomSheet<_ScanResultAction>(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (bottomSheetContext) {
        final theme = Theme.of(bottomSheetContext);
        final colorScheme = theme.colorScheme;
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Icon(Icons.qr_code_2, color: colorScheme.primary),
                    const SizedBox(width: 8),
                    Text(
                      'QR Detected',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: colorScheme.outlineVariant),
                  ),
                  child: Text(
                    scannedValue!,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
                const SizedBox(height: 16),
                FilledButton.icon(
                  onPressed: () => Navigator.of(
                    bottomSheetContext,
                  ).pop(_ScanResultAction.payNow),
                  icon: const Icon(Icons.payments),
                  label: const Text('Pay Now'),
                ),
                const SizedBox(height: 10),
                OutlinedButton.icon(
                  onPressed: () => Navigator.of(
                    bottomSheetContext,
                  ).pop(_ScanResultAction.copy),
                  icon: const Icon(Icons.copy),
                  label: const Text('Copy Code'),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () => Navigator.of(
                    bottomSheetContext,
                  ).pop(_ScanResultAction.scanAgain),
                  child: const Text('Scan Again'),
                ),
              ],
            ),
          ),
        );
      },
    );

    if (!mounted) return;

    switch (action) {
      case _ScanResultAction.payNow:
        context.push('/payment_details');
        break;
      case _ScanResultAction.copy:
        await UiFeedback.copyText(
          context,
          scannedValue,
          successMessage: 'QR value copied',
        );
        break;
      case _ScanResultAction.scanAgain:
      case null:
        break;
    }

    _isHandlingScan = false;
    await _scannerController.start();
  }

  Future<void> _importFromGallery() async {
    final image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) return;

    final capture = await _scannerController.analyzeImage(image.path);
    if (!mounted) return;

    if (capture == null || capture.barcodes.isEmpty) {
      UiFeedback.showSnackBar(
        context,
        'No QR code found in selected image',
        icon: Icons.info_outline,
      );
      return;
    }

    await _handleDetectedBarcode(capture);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: MobileScanner(
              controller: _scannerController,
              fit: BoxFit.cover,
              onDetect: _handleDetectedBarcode,
              errorBuilder: (context, error) {
                return Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Camera error: ${error.errorDetails?.message ?? 'Unable to start scanner'}',
                      style: const TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              },
            ),
          ),

          // Dark overlay for readability
          Positioned.fill(
            child: Container(color: Colors.black.withValues(alpha: 0.35)),
          ),

          // UI Overlay
          SafeArea(
            child: Column(
              children: [
                // Header Controls
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: _toggleFlash,
                        style: IconButton.styleFrom(
                          backgroundColor: _flashOn
                              ? Colors.white.withValues(alpha: 0.4)
                              : Colors.white.withValues(alpha: 0.2),
                          foregroundColor: _flashOn
                              ? Colors.yellowAccent
                              : Colors.white,
                        ),
                        icon: Icon(_flashOn ? Icons.flash_on : Icons.flash_off),
                      ),
                      const Text(
                        'Scan QR Code to Pay',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              color: Colors.black45,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => context.pop(),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.white.withValues(alpha: 0.2),
                          foregroundColor: Colors.white,
                        ),
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                ),

                // Fonepay Logo mock
                Container(
                  margin: const EdgeInsets.only(top: 24),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Text(
                    'FONEPAY',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),

                // Gallery Button
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: OutlinedButton.icon(
                    onPressed: _importFromGallery,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: BorderSide(
                        color: Colors.white.withValues(alpha: 0.3),
                      ),
                      backgroundColor: Colors.white.withValues(alpha: 0.1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                    icon: const Icon(Icons.grid_view),
                    label: const Text(
                      'ADD QR CODE FROM GALLERY',
                      style: TextStyle(letterSpacing: 1.2),
                    ),
                  ),
                ),

                // Scanning Area
                Expanded(
                  child: Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Dimmed overlay outside scanner is typically done with a CustomPainter or stack trick.
                        // For simplicity in UI mockup, we just use a styled border.
                        Container(
                          width: 280,
                          height: 280,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: colorScheme.primaryContainer.withValues(
                                alpha: 0.8,
                              ),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(32),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black45,
                                spreadRadius: 1000,
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(32),
                            child: AnimatedBuilder(
                              animation: _animation,
                              builder: (context, child) {
                                return Stack(
                                  children: [
                                    Positioned(
                                      top: _animation.value,
                                      left: 0,
                                      right: 0,
                                      child: Container(
                                        height: 3,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Colors.transparent,
                                              colorScheme.primaryContainer,
                                              Colors.transparent,
                                            ],
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  colorScheme.primaryContainer,
                                              blurRadius: 8,
                                              spreadRadius: 2,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                        // Corners
                        Positioned(
                          top: -4,
                          left: -4,
                          child: _buildCorner(true, true),
                        ),
                        Positioned(
                          top: -4,
                          right: -4,
                          child: _buildCorner(true, false),
                        ),
                        Positioned(
                          bottom: -4,
                          left: -4,
                          child: _buildCorner(false, true),
                        ),
                        Positioned(
                          bottom: -4,
                          right: -4,
                          child: _buildCorner(false, false),
                        ),
                      ],
                    ),
                  ),
                ),

                // Zoom controls
                Container(
                  margin: const EdgeInsets.only(bottom: 24),
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildZoomBtn(1, onPressed: () => _setZoomLevel(1)),
                      _buildZoomBtn(2, onPressed: () => _setZoomLevel(2)),
                      _buildZoomBtn(3, onPressed: () => _setZoomLevel(3)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 24,
              offset: const Offset(0, -8),
            ),
          ],
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              Container(
                width: 48,
                height: 4,
                decoration: BoxDecoration(
                  color: colorScheme.outlineVariant,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  children: [
                    Icon(Icons.qr_code_scanner, color: colorScheme.primary),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Point your camera at a QR code',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'If scan does not trigger, move closer and increase brightness.',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),

              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: colorScheme.outlineVariant.withOpacity(0.5),
                    ),
                  ),
                  child: InkWell(
                    onTap: () =>
                        UiFeedback.comingSoon(context, 'My QR display'),
                    borderRadius: BorderRadius.circular(24),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: colorScheme.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Icon(
                            Icons.qr_code_2,
                            color: colorScheme.primary,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Upendra's Wallet QR",
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Tap to show your QR to others',
                                style: theme.textTheme.labelMedium?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(Icons.chevron_right, color: colorScheme.outline),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildZoomBtn(int level, {required VoidCallback onPressed}) {
    final isSelected = _zoomLevel == level;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).colorScheme.primaryContainer
              : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            '${level}X',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCorner(bool isTop, bool isLeft) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        border: Border(
          top: isTop
              ? BorderSide(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  width: 4,
                )
              : BorderSide.none,
          bottom: !isTop
              ? BorderSide(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  width: 4,
                )
              : BorderSide.none,
          left: isLeft
              ? BorderSide(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  width: 4,
                )
              : BorderSide.none,
          right: !isLeft
              ? BorderSide(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  width: 4,
                )
              : BorderSide.none,
        ),
        borderRadius: BorderRadius.only(
          topLeft: isTop && isLeft ? const Radius.circular(32) : Radius.zero,
          topRight: isTop && !isLeft ? const Radius.circular(32) : Radius.zero,
          bottomLeft: !isTop && isLeft
              ? const Radius.circular(32)
              : Radius.zero,
          bottomRight: !isTop && !isLeft
              ? const Radius.circular(32)
              : Radius.zero,
        ),
      ),
    );
  }
}

enum _ScanResultAction { payNow, copy, scanAgain }
