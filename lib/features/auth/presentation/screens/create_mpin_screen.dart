import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/router/route_names.dart';
import '../../../../core/widgets/buttons/primary_button.dart';
import '../../../../core/widgets/inputs/custom_text_field.dart';
import '../providers/auth_provider.dart';

class CreateMpinScreen extends ConsumerStatefulWidget {
  const CreateMpinScreen({super.key});

  @override
  ConsumerState<CreateMpinScreen> createState() => _CreateMpinScreenState();
}

class _CreateMpinScreenState extends ConsumerState<CreateMpinScreen> {
  final _mpinController = TextEditingController();
  final _confirmMpinController = TextEditingController();
  bool _isLoading = false;
  bool _obscureMpin = true;
  bool _obscureConfirmMpin = true;

  @override
  void dispose() {
    _mpinController.dispose();
    _confirmMpinController.dispose();
    super.dispose();
  }

  Future<void> _handleCreate() async {
    if (_mpinController.text.length != 4 || _mpinController.text != _confirmMpinController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid matching 4-digit MPIN.')),
      );
      return;
    }

    setState(() => _isLoading = true);
    
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    
    if (!mounted) return;
    
    // Perform demo login directly after MPIN creation
    await ref.read(authProvider.notifier).login('9800000000', _mpinController.text);
    
    if (!mounted) return;
    context.goNamed(RouteNames.home);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: colorScheme.onSurface),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Set MPIN',
                style: textTheme.headlineLarge,
              ),
              const SizedBox(height: 8),
              Text(
                'Set a 4-digit MPIN to secure your wallet transactions.',
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 48),
              CustomTextField(
                label: 'New MPIN',
                hint: '••••',
                controller: _mpinController,
                keyboardType: TextInputType.number,
                obscureText: _obscureMpin,
                prefixIcon: Icon(Icons.lock_outline, color: colorScheme.primary),
                maxLength: 4,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureMpin ? Icons.visibility_off : Icons.visibility,
                    color: colorScheme.onSurfaceVariant,
                  ),
                  onPressed: () {
                    setState(() => _obscureMpin = !_obscureMpin);
                  },
                ),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                label: 'Confirm MPIN',
                hint: '••••',
                controller: _confirmMpinController,
                keyboardType: TextInputType.number,
                obscureText: _obscureConfirmMpin,
                prefixIcon: Icon(Icons.lock_outline, color: colorScheme.primary),
                maxLength: 4,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureConfirmMpin ? Icons.visibility_off : Icons.visibility,
                    color: colorScheme.onSurfaceVariant,
                  ),
                  onPressed: () {
                    setState(() => _obscureConfirmMpin = !_obscureConfirmMpin);
                  },
                ),
              ),
              const Spacer(),
              PrimaryButton(
                text: 'Complete Setup',
                isLoading: _isLoading,
                onPressed: _handleCreate,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
