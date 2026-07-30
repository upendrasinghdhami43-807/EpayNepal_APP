import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class QrScannerScreen extends StatefulWidget {
  const QrScannerScreen({super.key});

  @override
  State<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Mock Camera Background
          Positioned.fill(
            child: Opacity(
              opacity: 0.8,
              child: Image.network(
                'https://lh3.googleusercontent.com/aida-public/AB6AXuBHUocDjWPHQnMcHP6OLCpRASZKXJ9_A7Yj2peNe6YQ4g57cB7ETol_OyxkLRk1oQvrJnmQmi5oWu0CFbmcu-IPmaBPA0g0Djx6Wo-pw0BZ-TEXC-1LDYc5hL6AtlQwn141LJCwLYwRZVdQqxaHrrJYGFMCk3KtaALlKlm4Gy_P0YadjbrFFw6Z9Ucb_Qs95u3NiE56czPHSOy6PREZUO_jzLTBlrkZP0yVUQwVSQOmtItOsrDo42VVLnpYNNxmo7_kQUJijUaE1M2e',
                fit: BoxFit.cover,
              ),
            ),
          ),
          
          // UI Overlay
          SafeArea(
            child: Column(
              children: [
                // Header Controls
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _flashOn = !_flashOn;
                          });
                        },
                        style: IconButton.styleFrom(
                          backgroundColor: _flashOn ? Colors.white.withOpacity(0.4) : Colors.white.withOpacity(0.2),
                          foregroundColor: _flashOn ? Colors.yellowAccent : Colors.white,
                        ),
                        icon: Icon(_flashOn ? Icons.flash_on : Icons.flash_off),
                      ),
                      const Text(
                        'Scan QR Code to Pay',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          shadows: [Shadow(color: Colors.black45, blurRadius: 4, offset: Offset(0, 2))],
                        ),
                      ),
                      IconButton(
                        onPressed: () => context.pop(),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.2),
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
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
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
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: BorderSide(color: Colors.white.withOpacity(0.3)),
                      backgroundColor: Colors.white.withOpacity(0.1),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    icon: const Icon(Icons.grid_view),
                    label: const Text('ADD QR CODE FROM GALLERY', style: TextStyle(letterSpacing: 1.2)),
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
                            border: Border.all(color: colorScheme.primaryContainer.withOpacity(0.8), width: 2),
                            borderRadius: BorderRadius.circular(32),
                            boxShadow: const [
                              BoxShadow(color: Colors.black45, spreadRadius: 1000)
                            ]
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
                                              color: colorScheme.primaryContainer,
                                              blurRadius: 8,
                                              spreadRadius: 2,
                                            )
                                          ]
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
                        Positioned(top: -4, left: -4, child: _buildCorner(true, true)),
                        Positioned(top: -4, right: -4, child: _buildCorner(true, false)),
                        Positioned(bottom: -4, left: -4, child: _buildCorner(false, true)),
                        Positioned(bottom: -4, right: -4, child: _buildCorner(false, false)),
                      ],
                    ),
                  ),
                ),

                // Zoom controls
                Container(
                  margin: const EdgeInsets.only(bottom: 24),
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildZoomBtn(1),
                      _buildZoomBtn(2),
                      _buildZoomBtn(3),
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
          color: theme.brightness == Brightness.dark 
              ? colorScheme.surface 
              : colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
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
              
              // Tabs
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text('My QR', style: theme.textTheme.titleMedium?.copyWith(color: colorScheme.primary, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Container(width: 48, height: 4, decoration: BoxDecoration(color: colorScheme.primary, borderRadius: const BorderRadius.vertical(top: Radius.circular(2)))),
                      ],
                    ),
                    Text('Favorite QR', style: theme.textTheme.titleMedium?.copyWith(color: colorScheme.onSurfaceVariant)),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: colorScheme.primaryContainer,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.expand_less, color: colorScheme.onPrimaryContainer),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              
              // Content
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: colorScheme.outlineVariant.withOpacity(0.5)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: colorScheme.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(Icons.qr_code_2, color: colorScheme.primary),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Upendra's Wallet QR", style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                            Text('Tap to show your QR to others', style: theme.textTheme.labelMedium?.copyWith(color: colorScheme.onSurfaceVariant)),
                          ],
                        ),
                      ),
                      Icon(Icons.chevron_right, color: colorScheme.outline),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildZoomBtn(int level) {
    final isSelected = _zoomLevel == level;
    return GestureDetector(
      onTap: () {
        setState(() {
          _zoomLevel = level;
        });
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: isSelected ? Theme.of(context).colorScheme.primaryContainer : Colors.transparent,
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
          top: isTop ? BorderSide(color: Theme.of(context).colorScheme.primaryContainer, width: 4) : BorderSide.none,
          bottom: !isTop ? BorderSide(color: Theme.of(context).colorScheme.primaryContainer, width: 4) : BorderSide.none,
          left: isLeft ? BorderSide(color: Theme.of(context).colorScheme.primaryContainer, width: 4) : BorderSide.none,
          right: !isLeft ? BorderSide(color: Theme.of(context).colorScheme.primaryContainer, width: 4) : BorderSide.none,
        ),
        borderRadius: BorderRadius.only(
          topLeft: isTop && isLeft ? const Radius.circular(32) : Radius.zero,
          topRight: isTop && !isLeft ? const Radius.circular(32) : Radius.zero,
          bottomLeft: !isTop && isLeft ? const Radius.circular(32) : Radius.zero,
          bottomRight: !isTop && !isLeft ? const Radius.circular(32) : Radius.zero,
        ),
      ),
    );
  }
}
