import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/buttons/primary_button.dart';
import '../../../../core/widgets/inputs/custom_text_field.dart';

class CreatePasswordScreen extends StatefulWidget {
  const CreatePasswordScreen({super.key});

  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _isLoading = false;
  bool _passVisible = false;
  bool _confirmVisible = false;

  @override
  void dispose() {
    _passController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 1200));
    if (!mounted) return;
    setState(() => _isLoading = false);
    context.goNamed('login');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Create Password')),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 32),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Password requirements:',
                          style: theme.textTheme.labelLarge),
                      const SizedBox(height: 12),
                      ...[
                        '8+ characters',
                        'At least one uppercase letter',
                        'At least one number',
                      ].map((req) => Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: Row(
                              children: [
                                Icon(Icons.check_circle_outline,
                                    size: 16, color: colorScheme.primary),
                                const SizedBox(width: 8),
                                Text(req,
                                    style: theme.textTheme.bodySmall?.copyWith(
                                        color: colorScheme.onSurfaceVariant)),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                CustomTextField(
                  label: 'New Password',
                  hint: 'Min 8 characters',
                  controller: _passController,
                  obscureText: !_passVisible,
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(_passVisible
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined),
                    onPressed: () =>
                        setState(() => _passVisible = !_passVisible),
                  ),
                  validator: AppValidators.password,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  label: 'Confirm Password',
                  hint: 'Re-enter password',
                  controller: _confirmController,
                  obscureText: !_confirmVisible,
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(_confirmVisible
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined),
                    onPressed: () =>
                        setState(() => _confirmVisible = !_confirmVisible),
                  ),
                  validator: (val) =>
                      AppValidators.confirmPassword(val, _passController.text),
                ),
                const SizedBox(height: 32),
                PrimaryButton(
                  text: 'Set Password',
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
}
