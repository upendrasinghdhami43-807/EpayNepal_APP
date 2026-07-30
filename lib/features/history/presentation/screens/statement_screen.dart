import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/ui_feedback.dart';

class StatementScreen extends StatelessWidget {
  const StatementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        title: const Text('Statement'),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () => UiFeedback.comingSoon(context, 'Statement share'),
          ),
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            onPressed: () =>
                UiFeedback.comingSoon(context, 'Statement PDF export'),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Finance 360 Overview Card
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: theme.brightness == Brightness.dark
                          ? colorScheme.surfaceContainerHighest
                          : colorScheme.surfaceContainerLowest,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: colorScheme.outlineVariant.withOpacity(0.3),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: colorScheme.primaryContainer.withOpacity(
                              0.2,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Icon(
                            Icons.account_balance_wallet,
                            color: colorScheme.primary,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'NPR 3,530 spent on July',
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Finance 360 Overview',
                                style: theme.textTheme.labelMedium?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.chevron_right,
                            color: colorScheme.primary,
                          ),
                          onPressed: () => UiFeedback.comingSoon(
                            context,
                            'Finance 360 overview',
                          ),
                          style: IconButton.styleFrom(
                            backgroundColor: colorScheme.primaryContainer
                                .withOpacity(0.2),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Search and Filter
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                            color: colorScheme.surfaceContainer,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search Statement',
                              prefixIcon: Icon(
                                Icons.search,
                                color: colorScheme.onSurfaceVariant,
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        width: 1,
                        height: 32,
                        color: colorScheme.outlineVariant,
                      ),
                      const SizedBox(width: 12),
                      Container(
                        decoration: BoxDecoration(
                          color: colorScheme.surfaceContainer,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: IconButton(
                          icon: Icon(Icons.tune, color: colorScheme.onSurface),
                          onPressed: () => UiFeedback.comingSoon(
                            context,
                            'Statement filters',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Group Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'MON, JUL 27',
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                          letterSpacing: 1.2,
                        ),
                      ),
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: colorScheme.primaryContainer,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.expand_more,
                          size: 16,
                          color: colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),

          // Transaction List
          SliverPadding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 100),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildTransactionCard(
                  context,
                  icon: Icons.send_to_mobile,
                  title: 'Fund Transferred to Lalita Kumari Dhami',
                  time: '05:23 PM',
                  amount: '100.00',
                  isExpense: true,
                  balance: '22.20',
                  onTap: () => context.push('/transaction_details'),
                ),
                const SizedBox(height: 16),
                _buildTransactionCard(
                  context,
                  icon: Icons.local_pharmacy,
                  iconBgColor: Colors.blue.withOpacity(0.1),
                  iconColor: Colors.blue,
                  title: 'Paid for Bhadra Pharmacy',
                  time: '04:39 PM',
                  amount: '10.00',
                  isExpense: true,
                  balance: '122.20',
                  onTap: () => context.push('/transaction_details'),
                ),
                const SizedBox(height: 16),
                _buildTransactionCard(
                  context,
                  icon: Icons.storefront,
                  iconBgColor: Colors.orange.withOpacity(0.1),
                  iconColor: Colors.orange,
                  title: 'Paid for Prabhat Dairy',
                  time: '03:08 PM',
                  amount: '70.00',
                  isExpense: true,
                  balance: '132.20',
                  onTap: () => context.push('/transaction_details'),
                ),
                const SizedBox(height: 16),
                _buildTransactionCard(
                  context,
                  icon: Icons.account_balance,
                  iconBgColor: colorScheme.surfaceContainerHigh,
                  iconColor: colorScheme.primary,
                  title: 'Money transferred from AGRICULTURAL...',
                  time: '03:07 PM',
                  amount: '100.00',
                  isExpense: false,
                  balance: null,
                  onTap: () => context.push('/transaction_details'),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String time,
    required String amount,
    required bool isExpense,
    Color? iconBgColor,
    Color? iconColor,
    String? balance,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: theme.brightness == Brightness.dark
              ? colorScheme.surfaceContainerHighest
              : colorScheme.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: colorScheme.outlineVariant.withOpacity(0.2),
          ),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: iconBgColor ?? colorScheme.surfaceContainerHigh,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    color: iconColor ?? colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        time,
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      isExpense ? Icons.arrow_drop_down : Icons.arrow_drop_up,
                      color: isExpense
                          ? colorScheme.error
                          : colorScheme.primary,
                      size: 20,
                    ),
                    Text(
                      amount,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: isExpense
                            ? colorScheme.error
                            : colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            if (balance != null) ...[
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'BALANCE',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                          letterSpacing: 1.2,
                        ),
                      ),
                      Text(
                        balance,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  if (isExpense)
                    TextButton(
                      onPressed: () => context.push('/payment_details'),
                      style: TextButton.styleFrom(
                        backgroundColor: colorScheme.primaryContainer
                            .withOpacity(0.2),
                        foregroundColor: colorScheme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                      child: const Text(
                        'REDO',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
