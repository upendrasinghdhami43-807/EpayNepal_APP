import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/utils/ui_feedback.dart';
import '../../../../core/widgets/buttons/primary_button.dart';
import '../../../../core/widgets/inputs/custom_text_field.dart';

class LinkBankScreen extends StatefulWidget {
  const LinkBankScreen({super.key});

  @override
  State<LinkBankScreen> createState() => _LinkBankScreenState();
}

class _LinkBankScreenState extends State<LinkBankScreen> {
  final _formKey = GlobalKey<FormState>();
  final _accountController = TextEditingController();
  final _nameController = TextEditingController();
  int _selectedBank = -1;
  bool _isLoading = false;

  final _banks = [
    {'name': 'NIC Asia Bank', 'code': 'NICASIA'},
    {'name': 'Global IME Bank', 'code': 'GIBL'},
    {'name': 'Nabil Bank', 'code': 'NABIL'},
    {'name': 'Sanima Bank', 'code': 'SANIMA'},
    {'name': 'Machhapuchchhre Bank', 'code': 'MBL'},
    {'name': 'Everest Bank', 'code': 'EBL'},
    {'name': 'Sunrise Bank', 'code': 'SUNRISE'},
    {'name': 'Citizens Bank', 'code': 'CBL'},
    {'name': 'Standard Chartered', 'code': 'SCB'},
    {'name': 'Himalayan Bank', 'code': 'HBL'},
  ];

  @override
  void dispose() {
    _accountController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_selectedBank == -1) {
      UiFeedback.showSnackBar(context, 'Please select a bank',
          icon: Icons.warning_amber_rounded);
      return;
    }
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 1500));
    if (!mounted) return;
    setState(() => _isLoading = false);
    UiFeedback.showSnackBar(context, 'Bank account linked successfully!',
        icon: Icons.check_circle_outline);
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Link Bank Account'),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Step banner
              Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.account_balance,
                          color: colorScheme.primary, size: 28),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Link Your Bank',
                                style: theme.textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.bold)),
                            Text(
                                'Top up your wallet and withdraw directly from your bank account.',
                                style: theme.textTheme.bodySmall?.copyWith(
                                    color: colorScheme.onSurfaceVariant)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Bank list
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    Text('Select Bank',
                        style: theme.textTheme.titleSmall
                            ?.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: List.generate(_banks.length, (i) {
                        final selected = _selectedBank == i;
                        return FilterChip(
                          label: Text(_banks[i]['name']!),
                          selected: selected,
                          onSelected: (val) =>
                              setState(() => _selectedBank = val ? i : -1),
                          selectedColor:
                              colorScheme.primaryContainer.withValues(alpha: 0.3),
                          checkmarkColor: colorScheme.primary,
                        );
                      }),
                    ),
                    const SizedBox(height: 24),
                    Text('Account Details',
                        style: theme.textTheme.titleSmall
                            ?.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    CustomTextField(
                      label: 'Account Number',
                      hint: 'Enter account number',
                      controller: _accountController,
                      keyboardType: TextInputType.number,
                      prefixIcon: const Icon(Icons.credit_card_outlined),
                      validator: AppValidators.accountNumber,
                    ),
                    const SizedBox(height: 12),
                    CustomTextField(
                      label: 'Account Holder Name',
                      hint: 'As per bank records',
                      controller: _nameController,
                      prefixIcon: const Icon(Icons.person_outline),
                      validator: AppValidators.fullName,
                    ),
                    const SizedBox(height: 24),
                    PrimaryButton(
                      text: 'Link Bank Account',
                      isLoading: _isLoading,
                      onPressed: _submit,
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
