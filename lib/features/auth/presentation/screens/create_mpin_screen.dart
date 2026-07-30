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
    return Scaffold(
      appBar: AppBar(title: const Text('Create MPIN')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Set a 4-digit MPIN to secure your wallet.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 32),
              CustomTextField(
                label: 'New MPIN',
                hint: '****',
                controller: _mpinController,
                keyboardType: TextInputType.number,
                obscureText: true,
                prefixIcon: const Icon(Icons.lock),
              ),
              const SizedBox(height: 24),
              CustomTextField(
                label: 'Confirm MPIN',
                hint: '****',
                controller: _confirmMpinController,
                keyboardType: TextInputType.number,
                obscureText: true,
                prefixIcon: const Icon(Icons.lock),
              ),
              const SizedBox(height: 48),
              PrimaryButton(
                text: 'Complete Setup',
                isLoading: _isLoading,
                onPressed: _handleCreate,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
