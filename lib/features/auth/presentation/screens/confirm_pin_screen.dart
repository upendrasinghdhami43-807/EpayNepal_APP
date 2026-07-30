import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/buttons/primary_button.dart';

class ConfirmPinScreen extends StatefulWidget {
  /// The original PIN entered by the user on the previous screen.
  final String originalPin;
  const ConfirmPinScreen({super.key, required this.originalPin});

  @override
  State<ConfirmPinScreen> createState() => _ConfirmPinScreenState();
}

class _ConfirmPinScreenState extends State<ConfirmPinScreen> {
  final List<TextEditingController> _controllers =
      List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());
  bool _isLoading = false;
  String? _error;

  String get _enteredPin =>
      _controllers.map((c) => c.text).join();

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _onDigitChanged(int index, String value) {
    if (value.isNotEmpty && index < 3) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
    setState(() {});
    if (_enteredPin.length == 4) _verify();
  }

  Future<void> _verify() async {
    if (_enteredPin.length < 4) return;
    setState(() {
      _isLoading = true;
      _error = null;
    });
    await Future.delayed(const Duration(milliseconds: 600));
    if (!mounted) return;
    if (_enteredPin == widget.originalPin) {
      setState(() => _isLoading = false);
      context.pushNamed('biometric_setup');
    } else {
      setState(() {
        _isLoading = false;
        _error = 'PINs do not match. Please try again.';
        for (final c in _controllers) {
          c.clear();
        }
      });
      _focusNodes[0].requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Confirm PIN')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              Icon(Icons.pin, size: 56, color: colorScheme.primary),
              const SizedBox(height: 24),
              Text(
                'Confirm your PIN',
                style: theme.textTheme.headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Re-enter your 4-digit transaction PIN',
                style: theme.textTheme.bodyMedium
                    ?.copyWith(color: colorScheme.onSurfaceVariant),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (i) => _buildDigitBox(i)),
              ),
              if (_error != null) ...[
                const SizedBox(height: 16),
                Text(
                  _error!,
                  style: TextStyle(color: colorScheme.error),
                  textAlign: TextAlign.center,
                ),
              ],
              const Spacer(),
              PrimaryButton(
                text: 'Confirm PIN',
                isLoading: _isLoading,
                onPressed: () => _verify(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDigitBox(int index) {
    final colorScheme = Theme.of(context).colorScheme;
    final isFilled = _controllers[index].text.isNotEmpty;
    return Container(
      width: 60,
      height: 60,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: isFilled
            ? colorScheme.primaryContainer.withValues(alpha: 0.3)
            : colorScheme.surfaceContainerLow,
        border: Border.all(
          color: isFilled ? colorScheme.primary : colorScheme.outlineVariant,
          width: isFilled ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        obscureText: true,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        decoration: const InputDecoration(
          counterText: '',
          border: InputBorder.none,
        ),
        onChanged: (v) => _onDigitChanged(index, v),
      ),
    );
  }
}
