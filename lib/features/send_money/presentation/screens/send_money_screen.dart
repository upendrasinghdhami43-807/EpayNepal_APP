import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/utils/ui_feedback.dart';
import '../../../../core/widgets/buttons/primary_button.dart';
import '../../../../core/widgets/inputs/custom_text_field.dart';

class SendMoneyScreen extends StatefulWidget {
  const SendMoneyScreen({super.key});

  @override
  State<SendMoneyScreen> createState() => _SendMoneyScreenState();
}

class _SendMoneyScreenState extends State<SendMoneyScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _amountController = TextEditingController();
  final _remarksController = TextEditingController();
  bool _isSearching = false;
  bool _isLoading = false;
  String? _foundName;

  @override
  void dispose() {
    _phoneController.dispose();
    _amountController.dispose();
    _remarksController.dispose();
    super.dispose();
  }

  Future<void> _findUser() async {
    if (_phoneController.text.trim().isEmpty) return;
    setState(() => _isSearching = true);
    await Future.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;
    setState(() {
      _isSearching = false;
      _foundName = 'Sita Sharma'; // Demo user lookup
    });
  }

  Future<void> _proceed() async {
    if (!_formKey.currentState!.validate()) return;
    if (_foundName == null) {
      UiFeedback.showSnackBar(context, 'Please search for a recipient first',
          icon: Icons.warning_amber_rounded);
      return;
    }
    context.push(
      '/payment_details',
      extra: {
        'name': _foundName,
        'number': _phoneController.text,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Money'),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Balance Display
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: colorScheme.primaryContainer),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Current Balance',
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                'NPR ',
                                style: theme.textTheme.titleSmall?.copyWith(
                                  color: colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'XXXX.XX', // Masked balance for demo
                                style: theme.textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: colorScheme.primary,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.account_balance_wallet, color: colorScheme.onPrimary),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Recent Transactions
                Text(
                  'Recent',
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 90,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildRecentUser('Sita Sharma', '98XXXXXX01', context),
                      _buildRecentUser('Ram Bahadur', '98XXXXXX02', context),
                      _buildRecentUser('Hari Thapa', '98XXXXXX03', context),
                      _buildRecentUser('Gita Rana', '98XXXXXX04', context),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Recipient search
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Send To',
                          style: theme.textTheme.titleSmall?.copyWith(
                              color: colorScheme.onSurfaceVariant)),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              label: 'Enter EpayID',
                              hint: 'Mobile Number or Email',
                              controller: _phoneController,
                              keyboardType: TextInputType.text,
                              prefixIcon:
                                  const Icon(Icons.account_circle_outlined),
                              validator: (val) {
                                if (val == null || val.trim().isEmpty) {
                                  return 'Please enter receiver details';
                                }
                                return null;
                              },
                              onChanged: (_) =>
                                  setState(() => _foundName = null),
                            ),
                          ),
                          const SizedBox(width: 12),
                          InkWell(
                            onTap: _findUser,
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: colorScheme.primary,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: _isSearching
                                  ? Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: colorScheme.onPrimary),
                                    )
                                  : Icon(Icons.search,
                                      color: colorScheme.onPrimary),
                            ),
                          ),
                        ],
                      ),
                      if (_foundName != null) ...[
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: colorScheme.primaryContainer
                                .withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: colorScheme.primary,
                                child: Text(
                                  _foundName![0],
                                  style: TextStyle(
                                      color: colorScheme.onPrimary,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(_foundName!,
                                      style: theme.textTheme.titleSmall
                                          ?.copyWith(
                                              fontWeight: FontWeight.bold)),
                                  Text(_phoneController.text,
                                      style: theme.textTheme.labelSmall
                                          ?.copyWith(
                                              color: colorScheme
                                                  .onSurfaceVariant)),
                                ],
                              ),
                              const Spacer(),
                              Icon(Icons.verified,
                                  color: colorScheme.primary, size: 18),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                const SizedBox(height: 24),
                PrimaryButton(
                  text: 'Proceed',
                  isLoading: _isLoading,
                  onPressed: _proceed,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRecentUser(String name, String number, BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return GestureDetector(
      onTap: () {
        _phoneController.text = number;
        _findUser();
      },
      child: Container(
        width: 72,
        margin: const EdgeInsets.only(right: 16),
        child: Column(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: colorScheme.surfaceContainerHigh,
              child: Text(
                name[0],
                style: theme.textTheme.titleLarge?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              name.split(' ')[0],
              style: theme.textTheme.labelSmall,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
