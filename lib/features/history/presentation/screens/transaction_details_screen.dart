import 'package:flutter/material.dart';

class TransactionDetailsScreen extends StatelessWidget {
  const TransactionDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        title: const Text('Transaction Details'),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(24),
          ),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.picture_as_pdf), onPressed: () {}),
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Balance Refresher
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.brightness == Brightness.dark 
                    ? colorScheme.surfaceContainerHighest 
                    : colorScheme.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(24),
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
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: colorScheme.secondaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(Icons.account_balance_wallet, color: colorScheme.onSecondaryContainer),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Balance', style: theme.textTheme.labelMedium?.copyWith(color: colorScheme.onSurfaceVariant)),
                        Text('NPR XXXX.XX', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.refresh, color: colorScheme.primary),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Success Message Banner
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer.withOpacity(0.1),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: colorScheme.primaryContainer.withOpacity(0.3), width: 2),
              ),
              child: Column(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: colorScheme.primaryContainer.withOpacity(0.4),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Icon(Icons.check_circle, size: 40, color: colorScheme.onPrimaryContainer),
                  ),
                  const SizedBox(height: 16),
                  Text('Payment Successful', style: theme.textTheme.headlineSmall?.copyWith(color: colorScheme.primary, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text('The funds have been transferred', style: theme.textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant)),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Main Details Card
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: theme.brightness == Brightness.dark 
                    ? colorScheme.surfaceContainerHighest 
                    : colorScheme.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                  ),
                ],
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
                          color: colorScheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(Icons.account_balance, color: colorScheme.primary),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Send Money', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                            Text('2026-07-27 05:23 PM', style: theme.textTheme.labelMedium?.copyWith(color: colorScheme.onSurfaceVariant)),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('- 100.00', style: theme.textTheme.titleMedium?.copyWith(color: colorScheme.error, fontWeight: FontWeight.bold)),
                          Text('NPR', style: theme.textTheme.labelMedium?.copyWith(color: colorScheme.onSurfaceVariant)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.verified, size: 14, color: colorScheme.primary),
                          const SizedBox(width: 4),
                          Text('Complete', style: theme.textTheme.labelMedium?.copyWith(color: colorScheme.primary)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 16),
                  
                  // Details Grid
                  Row(
                    children: [
                      Expanded(child: _buildDetailItem(context, 'Amount (NPR)', '100')),
                      Expanded(child: _buildDetailItem(context, 'Transaction Code', '1N6UTUU')),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildDetailItem(context, 'Processed By', '9762349101'),
                  const SizedBox(height: 16),
                  
                  // Dashed divider
                  Container(
                    height: 1,
                    width: double.infinity,
                    color: colorScheme.outlineVariant.withOpacity(0.5),
                  ),
                  const SizedBox(height: 16),

                  Row(
                    children: [
                      Expanded(child: _buildDetailItem(context, 'Purpose', 'Bill sharing')),
                      Expanded(child: _buildDetailItem(context, 'Receiver Name', 'Lalita Kumari Dhami')),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(child: _buildDetailItem(context, 'Payment Method', 'eSewa Wallet')),
                      Expanded(child: _buildDetailItem(context, 'Receiver eSewa Id', '9741695893')),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(child: _buildDetailItem(context, 'Remarks', 'Pay for it')),
                      Expanded(child: _buildDetailItem(context, 'Initiator Name', 'Upendra Singh Dhami')),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Additional Action
            InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(24),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  children: [
                    Icon(Icons.group_add, color: colorScheme.primary),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text('Split payment with friends?', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Icon(Icons.chevron_right, color: colorScheme.onSurfaceVariant),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Done Button
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary,
                foregroundColor: colorScheme.onPrimary,
                minimumSize: const Size.fromHeight(56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                elevation: 4,
              ),
              child: const Text('DONE', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 16),
            
            // Add expense category hint
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.add, color: colorScheme.onPrimaryContainer, size: 20),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Add expense category', style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
                    Text('This will help organize your expenses.', style: theme.textTheme.labelMedium?.copyWith(color: colorScheme.onSurfaceVariant)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(BuildContext context, String label, String value) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: theme.textTheme.labelMedium?.copyWith(color: colorScheme.onSurfaceVariant)),
        const SizedBox(height: 4),
        Text(value, style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
