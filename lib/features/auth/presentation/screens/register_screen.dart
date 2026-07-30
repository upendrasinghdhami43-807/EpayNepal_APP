import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/ui_feedback.dart';
import '../../../../core/widgets/buttons/primary_button.dart';
import '../../../../core/widgets/inputs/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _phoneController = TextEditingController();
  final _nameController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _phoneController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _handleRegister() {
    final name = _nameController.text.trim();
    final phone = _phoneController.text.trim();

    if (name.length < 3) {
      UiFeedback.showSnackBar(
        context,
        'Please enter a valid full name',
        icon: Icons.warning_amber_rounded,
      );
      return;
    }

    if (phone.length != 10 || int.tryParse(phone) == null) {
      UiFeedback.showSnackBar(
        context,
        'Please enter a valid 10-digit mobile number',
        icon: Icons.warning_amber_rounded,
      );
      return;
    }

    setState(() => _isLoading = true);
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      setState(() => _isLoading = false);
      // Demo simply routes to OTP
      context.pushNamed('otp'); // Will add route later
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Create your Emerald Wallet account',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32),
              CustomTextField(
                label: 'Full Name',
                hint: 'e.g., Ram Bahadur',
                controller: _nameController,
                prefixIcon: const Icon(Icons.person),
              ),
              const SizedBox(height: 24),
              CustomTextField(
                label: 'Mobile Number',
                hint: 'e.g., 98XXXXXXXX',
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                prefixIcon: const Icon(Icons.phone),
              ),
              const SizedBox(height: 48),
              PrimaryButton(
                text: 'Continue',
                isLoading: _isLoading,
                onPressed: _handleRegister,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
