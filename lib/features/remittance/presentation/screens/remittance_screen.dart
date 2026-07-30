import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RemittanceScreen extends StatefulWidget {
  const RemittanceScreen({super.key});

  @override
  State<RemittanceScreen> createState() => _RemittanceScreenState();
}

class _RemittanceScreenState extends State<RemittanceScreen> {
  bool isInternational = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        title: const Text('Remittance'),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(24),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Type Selection
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: theme.brightness == Brightness.dark 
                    ? colorScheme.surfaceContainerHighest 
                    : colorScheme.surfaceContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _buildTabButton(
                      'International',
                      isSelected: isInternational,
                      onTap: () => setState(() => isInternational = true),
                    ),
                  ),
                  Expanded(
                    child: _buildTabButton(
                      'Domestic',
                      isSelected: !isInternational,
                      onTap: () => setState(() => isInternational = false),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Exchange Calculator
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: theme.brightness == Brightness.dark 
                    ? colorScheme.surfaceContainerHighest 
                    : colorScheme.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: colorScheme.surfaceVariant),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildCurrencyInput(
                    context,
                    label: 'You send',
                    currency: 'USD',
                    value: '1000',
                  ),
                  const SizedBox(height: 16),
                  
                  // Exchange Rate Divider
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Divider(color: colorScheme.outlineVariant, thickness: 1),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        decoration: BoxDecoration(
                          color: theme.brightness == Brightness.dark 
                              ? colorScheme.surfaceContainerHighest 
                              : colorScheme.surfaceContainerLowest,
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.swap_vert, color: colorScheme.primary),
                            Text(
                              '1 USD = 132.45 NPR',
                              style: theme.textTheme.labelMedium?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  _buildCurrencyInput(
                    context,
                    label: 'Recipient gets',
                    currency: 'NPR',
                    value: '132450.00',
                    isReadOnly: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Partners Selection
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Select Partner', style: theme.textTheme.titleMedium),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'View All',
                    style: TextStyle(color: colorScheme.primary),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            
            _buildPartnerCard(
              context,
              name: 'Western Union',
              time: 'Instant',
              fee: '\$5.00',
              icon: Icons.language, // Placeholder for logo
              isSelected: true,
            ),
            const SizedBox(height: 12),
            _buildPartnerCard(
              context,
              name: 'IME',
              time: '10 mins',
              fee: '\$3.50',
              icon: Icons.sync_alt,
              isSelected: false,
            ),
            const SizedBox(height: 12),
            _buildPartnerCard(
              context,
              name: 'Prabhu Money',
              time: '30 mins',
              fee: '\$2.00',
              icon: Icons.account_balance,
              isSelected: false,
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: theme.brightness == Brightness.dark 
              ? colorScheme.background 
              : colorScheme.surface,
        ),
        child: SafeArea(
          child: ElevatedButton(
            onPressed: () {
              context.push('/payment_details');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.primary,
              foregroundColor: colorScheme.onPrimary,
              minimumSize: const Size.fromHeight(56),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
              elevation: 4,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Send Money',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 8),
                Icon(Icons.arrow_forward),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabButton(String text, {required bool isSelected, required VoidCallback onTap}) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? colorScheme.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: theme.textTheme.titleSmall?.copyWith(
            color: isSelected ? colorScheme.onPrimary : colorScheme.onSurfaceVariant,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildCurrencyInput(BuildContext context, {
    required String label,
    required String currency,
    required String value,
    bool isReadOnly = false,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: theme.textTheme.titleMedium),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: colorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Text(currency, style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(width: 4),
                  const Icon(Icons.expand_more, size: 16),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(16),
          ),
          child: TextField(
            readOnly: isReadOnly,
            style: theme.textTheme.headlineMedium?.copyWith(
              color: isReadOnly ? colorScheme.onSurface.withOpacity(0.5) : colorScheme.onSurface,
            ),
            decoration: InputDecoration(
              hintText: '0.00',
              prefixIcon: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  currency == 'USD' ? '\$' : 'Rs', 
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  )
                ),
              ),
              prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 16),
            ),
            controller: TextEditingController(text: value),
          ),
        ),
      ],
    );
  }

  Widget _buildPartnerCard(BuildContext context, {
    required String name,
    required String time,
    required String fee,
    required IconData icon,
    required bool isSelected,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.dark 
            ? colorScheme.surfaceContainerHighest 
            : colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isSelected ? colorScheme.primary : colorScheme.surfaceVariant,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: colorScheme.primary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: theme.textTheme.titleMedium),
                Row(
                  children: [
                    Icon(Icons.schedule, size: 14, color: colorScheme.onSurfaceVariant),
                    const SizedBox(width: 4),
                    Text(
                      time,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Fee: $fee',
                style: theme.textTheme.titleSmall?.copyWith(
                  color: isSelected ? colorScheme.primary : colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 4),
              Radio<bool>(
                value: true,
                groupValue: isSelected,
                onChanged: (val) {},
                activeColor: colorScheme.primary,
                visualDensity: VisualDensity.compact,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
