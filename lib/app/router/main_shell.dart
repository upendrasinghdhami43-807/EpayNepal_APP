import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainShell extends StatelessWidget {
  final Widget child;
  
  const MainShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 80,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(context, 'Home', Icons.home_filled, true),
                _buildNavItem(context, 'Statement', Icons.receipt_long, false),
                const SizedBox(width: 64), // Space for floating action button
                _buildNavItem(context, 'Support', Icons.help_outline, false),
                _buildNavItem(context, 'More', Icons.more_horiz, false),
              ],
            ),
          ),
          Positioned(
            top: -30,
            left: 0,
            right: 0,
            child: Center(
              child: FloatingActionButton(
                onPressed: () {},
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                shape: const CircleBorder(),
                elevation: 4,
                child: const Icon(Icons.qr_code_scanner, size: 32),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, String label, IconData icon, bool isSelected) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () {},
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: isSelected
                ? BoxDecoration(
                    color: colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(20),
                  )
                : null,
            child: Icon(
              icon,
              color: isSelected ? colorScheme.onPrimaryContainer : colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: isSelected ? colorScheme.onPrimaryContainer : colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
