import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/ui_feedback.dart';
import '../../../../core/widgets/buttons/primary_button.dart';
import '../../../../core/widgets/inputs/custom_text_field.dart';

class WaterBillScreen extends StatefulWidget {
  const WaterBillScreen({super.key});

  @override
  State<WaterBillScreen> createState() => _WaterBillScreenState();
}

class _WaterBillScreenState extends State<WaterBillScreen> {
  final _accountController = TextEditingController();
  final _pinController = TextEditingController();
  bool _isFetching = false;
  bool _isLoading = false;
  Map<String, dynamic>? _billData;

  @override
  void dispose() {
    _accountController.dispose();
    _pinController.dispose();
    super.dispose();
  }

  Future<void> _fetchBill() async {
    if (_accountController.text.trim().isEmpty) {
      UiFeedback.showSnackBar(context, 'Enter customer number',
          icon: Icons.warning_amber_rounded);
      return;
    }
    setState(() => _isFetching = true);
    await Future.delayed(const Duration(milliseconds: 1000));
    if (!mounted) return;
    setState(() {
      _isFetching = false;
      _billData = {
        'name': 'Upendra Dhami',
        'address': 'Kathmandu Ward-15',
        'units': '14',
        'amount': 280.0,
        'due_date': '2026-08-15',
      };
    });
  }

  Future<void> _payBill() async {
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
        title: const Text('Water Bill (Khanepani)'),
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
              // Provider header
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF1565C0),
                      const Color(0xFF42A5F5),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.water_drop,
                          color: Colors.white, size: 28),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Nepal Water Supply',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16)),
                        Text('Melamchi Water Supply Authority',
                            style: TextStyle(
                                color: Colors.white70, fontSize: 12)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Customer number
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: CustomTextField(
                      label: 'Customer Number',
                      hint: 'Enter your water customer number',
                      controller: _accountController,
                      keyboardType: TextInputType.number,
                      prefixIcon: const Icon(Icons.confirmation_number_outlined),
                      onChanged: (_) => setState(() => _billData = null),
                    ),
                  ),
                  const SizedBox(width: 12),
                  InkWell(
                    onTap: _fetchBill,
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: 48,
                      height: 56,
                      decoration: BoxDecoration(
                        color: colorScheme.primary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: _isFetching
                          ? Padding(
                              padding: const EdgeInsets.all(14),
                              child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: colorScheme.onPrimary),
                            )
                          : Icon(Icons.search, color: colorScheme.onPrimary),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              if (_billData != null) ...[
                // Bill details
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: theme.brightness == Brightness.dark
                        ? colorScheme.surfaceContainerHighest
                        : colorScheme.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: colorScheme.outlineVariant
                            .withValues(alpha: 0.3)),
                  ),
                  child: Column(
                    children: [
                      _billRow(context, 'Customer Name',
                          _billData!['name'] as String),
                      const Divider(height: 20),
                      _billRow(context, 'Address',
                          _billData!['address'] as String),
                      const Divider(height: 20),
                      _billRow(context, 'Units Consumed',
                          '${_billData!['units']} units'),
                      const Divider(height: 20),
                      _billRow(context, 'Due Date',
                          _billData!['due_date'] as String),
                      const Divider(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total Amount',
                              style: theme.textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.bold)),
                          Text(
                            'NPR ${(_billData!['amount'] as double).toStringAsFixed(2)}',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: colorScheme.primary),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  label: 'Transaction PIN',
                  hint: '4-digit PIN',
                  controller: _pinController,
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  prefixIcon: const Icon(Icons.lock_outline),
                  maxLength: 4,
                ),
                const SizedBox(height: 16),
                PrimaryButton(
                  text: 'Pay NPR ${(_billData!['amount'] as double).toStringAsFixed(2)}',
                  isLoading: _isLoading,
                  onPressed: _payBill,
                ),
              ] else ...[
                PrimaryButton(
                  text: 'Fetch Bill',
                  isLoading: _isFetching,
                  onPressed: _fetchBill,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _billRow(BuildContext context, String label, String value) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: theme.textTheme.bodyMedium
                ?.copyWith(color: colorScheme.onSurfaceVariant)),
        Text(value,
            style: theme.textTheme.titleSmall
                ?.copyWith(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
