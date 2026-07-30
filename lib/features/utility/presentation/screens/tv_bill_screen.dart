import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/ui_feedback.dart';
import '../../../../core/widgets/buttons/primary_button.dart';
import '../../../../core/widgets/inputs/custom_text_field.dart';

class TvBillScreen extends StatefulWidget {
  const TvBillScreen({super.key});

  @override
  State<TvBillScreen> createState() => _TvBillScreenState();
}

class _TvBillScreenState extends State<TvBillScreen> {
  final _accountController = TextEditingController();
  final _pinController = TextEditingController();
  int _selectedProvider = 0;
  bool _isLoading = false;
  bool _isPending = false;
  double? _billAmount;

  final _providers = [
    {'name': 'Dish Home', 'icon': Icons.satellite_alt, 'color': Color(0xFF2196F3)},
    {'name': 'Simtv', 'icon': Icons.tv, 'color': Color(0xFF9C27B0)},
    {'name': 'Nepal1 TV', 'icon': Icons.connected_tv, 'color': Color(0xFFE91E63)},
    {'name': 'Hello Nepal', 'icon': Icons.live_tv, 'color': Color(0xFFFF9800)},
  ];

  @override
  void dispose() {
    _accountController.dispose();
    _pinController.dispose();
    super.dispose();
  }

  Future<void> _fetchBill() async {
    if (_accountController.text.trim().isEmpty) {
      UiFeedback.showSnackBar(context, 'Enter subscriber ID',
          icon: Icons.warning_amber_rounded);
      return;
    }
    setState(() => _isPending = true);
    await Future.delayed(const Duration(milliseconds: 1000));
    if (!mounted) return;
    setState(() {
      _isPending = false;
      _billAmount = 600.0;
    });
  }

  Future<void> _payBill() async {
    if (_billAmount == null) {
      UiFeedback.showSnackBar(context, 'Fetch bill details first',
          icon: Icons.info_outline);
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
        title: const Text('TV / Cable Bill'),
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
              // Provider grid
              Text('Select Provider',
                  style: theme.textTheme.titleSmall
                      ?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              GridView.count(
                crossAxisCount: 4,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.85,
                children: List.generate(_providers.length, (i) {
                  final p = _providers[i];
                  final selected = _selectedProvider == i;
                  return GestureDetector(
                    onTap: () => setState(() {
                      _selectedProvider = i;
                      _billAmount = null;
                    }),
                    child: Container(
                      decoration: BoxDecoration(
                        color: selected
                            ? (p['color'] as Color).withValues(alpha: 0.15)
                            : colorScheme.surfaceContainerLow,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: selected
                              ? (p['color'] as Color)
                              : colorScheme.outlineVariant
                                  .withValues(alpha: 0.3),
                          width: selected ? 1.5 : 1,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(p['icon'] as IconData,
                              color: p['color'] as Color, size: 24),
                          const SizedBox(height: 6),
                          Text(
                            p['name'] as String,
                            style: theme.textTheme.labelSmall
                                ?.copyWith(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 24),

              // Subscriber ID
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: CustomTextField(
                      label: 'Subscriber ID',
                      hint: 'Enter subscriber number',
                      controller: _accountController,
                      keyboardType: TextInputType.number,
                      prefixIcon: const Icon(Icons.confirmation_number_outlined),
                      onChanged: (_) => setState(() => _billAmount = null),
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
                      child: _isPending
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

              // Bill result
              if (_billAmount != null) ...[
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color:
                        colorScheme.primaryContainer.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                        color: colorScheme.primary.withValues(alpha: 0.2)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              _providers[_selectedProvider]['name'] as String,
                              style: theme.textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.bold)),
                          Text('Monthly subscription',
                              style: theme.textTheme.labelSmall?.copyWith(
                                  color: colorScheme.onSurfaceVariant)),
                        ],
                      ),
                      Text(
                        'NPR ${_billAmount!.toStringAsFixed(2)}',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: colorScheme.primary),
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
              ],
              PrimaryButton(
                text: _billAmount == null ? 'Fetch Bill' : 'Pay NPR ${_billAmount!.toStringAsFixed(2)}',
                isLoading: _isLoading,
                onPressed: _billAmount == null ? _fetchBill : _payBill,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
