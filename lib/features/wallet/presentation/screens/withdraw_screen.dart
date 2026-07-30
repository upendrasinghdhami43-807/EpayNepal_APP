import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/utils/ui_feedback.dart';
import '../../../../core/widgets/buttons/primary_button.dart';
import '../../../../core/widgets/inputs/custom_text_field.dart';

class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({super.key});

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  final _amountController = TextEditingController();
  final _pinController = TextEditingController();
  int _selectedMethod = 0;
  bool _isLoading = false;

  final _methods = [
    {'icon': Icons.account_balance, 'title': 'Bank Transfer', 'sub': 'NIC Asia •••• 1234'},
    {'icon': Icons.credit_card, 'title': 'SCT Card', 'sub': 'Smart Choice Card'},
    {'icon': Icons.sync_alt, 'title': 'ConnectIPS', 'sub': 'Direct bank transfer'},
  ];

  @override
  void dispose() {
    _amountController.dispose();
    _pinController.dispose();
    super.dispose();
  }

  Future<void> _withdraw() async {
    final amount = double.tryParse(_amountController.text.replaceAll(',', ''));
    if (amount == null || amount <= 0) {
      UiFeedback.showSnackBar(context, 'Enter a valid amount',
          icon: Icons.warning_amber_rounded);
      return;
    }
    if (_pinController.text.length != 4) {
      UiFeedback.showSnackBar(context, 'Enter your 4-digit PIN',
          icon: Icons.warning_amber_rounded);
      return;
    }
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 1500));
    if (!mounted) return;
    setState(() => _isLoading = false);
    context.push('/payment_success');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Withdraw Money'),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Balance chip
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.account_balance_wallet,
                          color: colorScheme.primary, size: 18),
                      const SizedBox(width: 8),
                      Text('Balance: NPR 45,280.50',
                          style: theme.textTheme.titleSmall?.copyWith(
                              color: colorScheme.primary,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Amount
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: theme.brightness == Brightness.dark
                      ? colorScheme.surfaceContainerHighest
                      : colorScheme.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: colorScheme.outlineVariant.withValues(alpha: 0.3)),
                ),
                child: Column(
                  children: [
                    Text('Enter Amount',
                        style: theme.textTheme.titleSmall?.copyWith(
                            color: colorScheme.onSurfaceVariant)),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('रु.',
                            style: theme.textTheme.headlineLarge?.copyWith(
                                color: colorScheme.primary,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(width: 8),
                        Flexible(
                          child: TextField(
                            controller: _amountController,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.headlineMedium,
                            decoration: InputDecoration(
                              hintText: '0',
                              border: InputBorder.none,
                              hintStyle: theme.textTheme.headlineMedium
                                  ?.copyWith(
                                      color: colorScheme.onSurfaceVariant
                                          .withValues(alpha: 0.4)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (final a in ['1000', '5000', '10000'])
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: ActionChip(
                              label: Text('NPR $a'),
                              onPressed: () => setState(
                                  () => _amountController.text = a),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Withdrawal method
              Text('Withdrawal Method',
                  style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              ...List.generate(_methods.length, (i) {
                final m = _methods[i];
                final selected = _selectedMethod == i;
                return GestureDetector(
                  onTap: () => setState(() => _selectedMethod = i),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: selected
                          ? colorScheme.primaryContainer.withValues(alpha: 0.15)
                          : (theme.brightness == Brightness.dark
                              ? colorScheme.surfaceContainerHighest
                              : colorScheme.surfaceContainerLowest),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: selected
                            ? colorScheme.primary
                            : colorScheme.outlineVariant.withValues(alpha: 0.3),
                        width: selected ? 1.5 : 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: (selected
                                    ? colorScheme.primary
                                    : colorScheme.onSurfaceVariant)
                                .withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(m['icon'] as IconData,
                              color: selected
                                  ? colorScheme.primary
                                  : colorScheme.onSurfaceVariant,
                              size: 20),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(m['title'] as String,
                                  style: theme.textTheme.titleSmall?.copyWith(
                                      fontWeight: FontWeight.bold)),
                              Text(m['sub'] as String,
                                  style: theme.textTheme.labelSmall?.copyWith(
                                      color: colorScheme.onSurfaceVariant)),
                            ],
                          ),
                        ),
                        if (selected)
                          Icon(Icons.check_circle,
                              color: colorScheme.primary, size: 20),
                      ],
                    ),
                  ),
                );
              }),
              const SizedBox(height: 16),

              // PIN
              CustomTextField(
                label: 'Transaction PIN',
                hint: 'Enter 4-digit PIN',
                controller: _pinController,
                obscureText: true,
                keyboardType: TextInputType.number,
                prefixIcon: const Icon(Icons.lock_outline),
                maxLength: 4,
              ),
              const SizedBox(height: 24),
              PrimaryButton(
                text: 'Withdraw',
                isLoading: _isLoading,
                onPressed: _withdraw,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
