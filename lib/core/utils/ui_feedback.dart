import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UiFeedback {
  static void showSnackBar(
    BuildContext context,
    String message, {
    IconData? icon,
  }) {
    final messenger = ScaffoldMessenger.maybeOf(context);
    if (messenger == null) return;

    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Row(
            children: [
              if (icon != null) ...[
                Icon(icon, size: 18, color: Colors.white),
                const SizedBox(width: 10),
              ],
              Expanded(child: Text(message)),
            ],
          ),
        ),
      );
  }

  static void comingSoon(
    BuildContext context, [
    String feature = 'This feature',
  ]) {
    showSnackBar(context, '$feature is coming soon', icon: Icons.info_outline);
  }

  static Future<void> copyText(
    BuildContext context,
    String text, {
    String successMessage = 'Copied to clipboard',
  }) async {
    await Clipboard.setData(ClipboardData(text: text));
    if (!context.mounted) return;
    showSnackBar(context, successMessage, icon: Icons.check_circle_outline);
  }
}
