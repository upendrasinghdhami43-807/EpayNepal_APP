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
    if (AppValidators.phone(_phoneController.text) != null) return;
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
    context.push('/payment_details');
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
                // Recipient search
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
                              label: 'Mobile Number',
                              hint: '98XXXXXXXX',
                              controller: _phoneController,
                              keyboardType: TextInputType.phone,
                              prefixIcon:
                                  const Icon(Icons.phone_outlined),
                              validator: AppValidators.phone,
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
                const SizedBox(height: 16),

                // Amount entry
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
                      Text('Amount (NPR)',
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
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (final amt in ['500', '1000', '2000', '5000'])
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 6),
                              child: InkWell(
                                onTap: () => setState(() =>
                                    _amountController.text = amt),
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14, vertical: 8),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: colorScheme.outlineVariant),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(amt,
                                      style:
                                          theme.textTheme.labelMedium),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Remarks
                CustomTextField(
                  label: 'Remarks (Optional)',
                  hint: 'Add a note for recipient',
                  controller: _remarksController,
                  prefixIcon: const Icon(Icons.edit_note_outlined),
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
}
