import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/buttons/primary_button.dart';
import '../../../../core/widgets/inputs/custom_text_field.dart';

class KycAddressScreen extends StatefulWidget {
  const KycAddressScreen({super.key});

  @override
  State<KycAddressScreen> createState() => _KycAddressScreenState();
}

class _KycAddressScreenState extends State<KycAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  final _permanentController = TextEditingController();
  final _permanentDistrictController = TextEditingController();
  final _currentController = TextEditingController();
  final _currentDistrictController = TextEditingController();
  bool _sameAsPermanent = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _permanentController.dispose();
    _permanentDistrictController.dispose();
    _currentController.dispose();
    _currentDistrictController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 1200));
    if (!mounted) return;
    setState(() => _isLoading = false);
    context.pushNamed('kyc_status');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Address Information'),
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
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Section: Permanent
                _sectionHeader(context, Icons.home_outlined, 'Permanent Address'),
                const SizedBox(height: 12),
                CustomTextField(
                  label: 'Village/Municipality/City',
                  hint: 'e.g., Kathmandu Metropolitan City',
                  controller: _permanentController,
                  prefixIcon: const Icon(Icons.location_on_outlined),
                  validator: (v) => AppValidators.required(v, 'Permanent address'),
                ),
                const SizedBox(height: 12),
                CustomTextField(
                  label: 'District',
                  hint: 'e.g., Kathmandu',
                  controller: _permanentDistrictController,
                  prefixIcon: const Icon(Icons.map_outlined),
                  validator: (v) => AppValidators.required(v, 'District'),
                ),
                const SizedBox(height: 24),

                // Same as permanent
                Container(
                  decoration: BoxDecoration(
                    color: _sameAsPermanent
                        ? colorScheme.primaryContainer.withValues(alpha: 0.15)
                        : colorScheme.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: _sameAsPermanent
                          ? colorScheme.primary.withValues(alpha: 0.3)
                          : colorScheme.outlineVariant.withValues(alpha: 0.3),
                    ),
                  ),
                  child: SwitchListTile(
                    title: const Text('Temporary address same as permanent'),
                    value: _sameAsPermanent,
                    activeColor: colorScheme.primary,
                    onChanged: (val) => setState(() => _sameAsPermanent = val),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 16),

                if (!_sameAsPermanent) ...[
                  _sectionHeader(
                      context, Icons.apartment_outlined, 'Temporary Address'),
                  const SizedBox(height: 12),
                  CustomTextField(
                    label: 'Village/Municipality/City',
                    hint: 'e.g., Pokhara Metropolitan City',
                    controller: _currentController,
                    prefixIcon: const Icon(Icons.location_on_outlined),
                    validator: (v) =>
                        AppValidators.required(v, 'Temporary address'),
                  ),
                  const SizedBox(height: 12),
                  CustomTextField(
                    label: 'District',
                    hint: 'e.g., Kaski',
                    controller: _currentDistrictController,
                    prefixIcon: const Icon(Icons.map_outlined),
                    validator: (v) =>
                        AppValidators.required(v, 'District'),
                  ),
                  const SizedBox(height: 24),
                ],

                PrimaryButton(
                  text: 'Submit KYC',
                  isLoading: _isLoading,
                  onPressed: _submit,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _sectionHeader(BuildContext context, IconData icon, String title) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Row(
      children: [
        Icon(icon, color: colorScheme.primary, size: 20),
        const SizedBox(width: 8),
        Text(title,
            style: theme.textTheme.titleSmall
                ?.copyWith(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
