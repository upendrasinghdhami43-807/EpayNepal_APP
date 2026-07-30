import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/utils/ui_feedback.dart';
import '../../../../models/transaction_model.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final List<_NotifItem> _items = [
    _NotifItem(
      id: '1',
      icon: Icons.payments,
      title: 'Money Received',
      body: 'NPR 500 received from Sita Sharma',
      time: '2m ago',
      isRead: false,
      type: 'credit',
    ),
    _NotifItem(
      id: '2',
      icon: Icons.security,
      title: 'Login Alert',
      body: 'New login from Android device at 10:24 AM',
      time: '1h ago',
      isRead: false,
      type: 'security',
    ),
    _NotifItem(
      id: '3',
      icon: Icons.bolt,
      title: 'Bill Payment Success',
      body: 'NEA electricity bill of NPR 890 paid successfully',
      time: '3h ago',
      isRead: true,
      type: 'bill',
    ),
    _NotifItem(
      id: '4',
      icon: Icons.local_offer,
      title: '10% Cashback Offer',
      body: 'Pay internet bills this week and get 10% cashback',
      time: '1d ago',
      isRead: true,
      type: 'promo',
    ),
    _NotifItem(
      id: '5',
      icon: Icons.verified_user,
      title: 'KYC Approved',
      body: 'Your identity verification is complete. Higher limits unlocked.',
      time: '2d ago',
      isRead: true,
      type: 'kyc',
    ),
  ];

  void _markRead(String id) {
    setState(() {
      final idx = _items.indexWhere((n) => n.id == id);
      if (idx != -1) {
        _items[idx] = _items[idx].copyWith(isRead: true);
      }
    });
  }

  void _markAllRead() {
    setState(() {
      for (int i = 0; i < _items.length; i++) {
        _items[i] = _items[i].copyWith(isRead: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final unreadCount = _items.where((n) => !n.isRead).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
        ),
        actions: [
          if (unreadCount > 0)
            TextButton(
              onPressed: _markAllRead,
              child: Text(
                'Mark all read',
                style: TextStyle(
                    color: colorScheme.onPrimary.withValues(alpha: 0.9)),
              ),
            ),
        ],
      ),
      body: _items.isEmpty
          ? const Center(child: Text('No notifications yet'))
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: _items.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final n = _items[index];
                return _NotifTile(
                  item: n,
                  onTap: () => _markRead(n.id),
                );
              },
            ),
    );
  }
}

class _NotifTile extends StatelessWidget {
  final _NotifItem item;
  final VoidCallback onTap;

  const _NotifTile({required this.item, required this.onTap});

  Color _iconColor(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return switch (item.type) {
      'credit' => cs.primary,
      'security' => cs.error,
      'bill' => Colors.orange,
      'promo' => cs.tertiary,
      _ => cs.secondary,
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final iconColor = _iconColor(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: item.isRead
              ? colorScheme.surfaceContainerLowest
              : colorScheme.primaryContainer.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: item.isRead
                ? colorScheme.outlineVariant.withValues(alpha: 0.3)
                : colorScheme.primary.withValues(alpha: 0.2),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(item.icon, color: iconColor, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(item.title,
                            style: theme.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.bold)),
                      ),
                      if (!item.isRead)
                        Container(
                          width: 8,
                          height: 8,
                          margin: const EdgeInsets.only(left: 8),
                          decoration: BoxDecoration(
                            color: colorScheme.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(item.body,
                      style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant)),
                  const SizedBox(height: 4),
                  Text(item.time,
                      style: theme.textTheme.labelSmall?.copyWith(
                          color: colorScheme.outline)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NotifItem {
  final String id;
  final IconData icon;
  final String title;
  final String body;
  final String time;
  final bool isRead;
  final String type;

  const _NotifItem({
    required this.id,
    required this.icon,
    required this.title,
    required this.body,
    required this.time,
    required this.isRead,
    required this.type,
  });

  _NotifItem copyWith({bool? isRead}) => _NotifItem(
        id: id,
        icon: icon,
        title: title,
        body: body,
        time: time,
        isRead: isRead ?? this.isRead,
        type: type,
      );
}
