import 'package:flutter/material.dart';
import '../../../../core/utils/ui_feedback.dart';
import '../../data/demo_settings_store.dart';

class TestDemoSettingsScreen extends StatefulWidget {
  const TestDemoSettingsScreen({super.key});

  @override
  State<TestDemoSettingsScreen> createState() => _TestDemoSettingsScreenState();
}

class _TestDemoSettingsScreenState extends State<TestDemoSettingsScreen> {
  late bool _demoModeEnabled;
  late bool _mockBalanceEnabled;
  late bool _forceNetworkError;
  late bool _mockKycPending;
  late double _mockBalance;
  late TextEditingController _balanceController;

  @override
  void initState() {
    super.initState();
    _demoModeEnabled = DemoSettingsStore.demoModeEnabled;
    _mockBalanceEnabled = DemoSettingsStore.mockBalanceEnabled;
    _forceNetworkError = DemoSettingsStore.forceNetworkError;
    _mockKycPending = DemoSettingsStore.mockKycPending;
    _mockBalance = DemoSettingsStore.mockBalance;
    _balanceController = TextEditingController(
      text: _mockBalance.toStringAsFixed(2),
    );
  }

  @override
  void dispose() {
    _balanceController.dispose();
    super.dispose();
  }

  Future<void> _updateMockBalance() async {
    final value = double.tryParse(_balanceController.text.trim());
    if (value == null || value < 0) {
      UiFeedback.showSnackBar(
        context,
        'Enter a valid non-negative amount',
        icon: Icons.warning_amber_rounded,
      );
      return;
    }

    _mockBalance = value;
    await DemoSettingsStore.setMockBalance(value);
    if (!mounted) return;
    UiFeedback.showSnackBar(
      context,
      'Mock balance updated',
      icon: Icons.check_circle_outline,
    );
  }

  Future<void> _applyDelta(double delta) async {
    final next = (_mockBalance + delta).clamp(0, 999999999).toDouble();
    setState(() {
      _mockBalance = next;
      _balanceController.text = _mockBalance.toStringAsFixed(2);
    });
    await DemoSettingsStore.setMockBalance(_mockBalance);
  }

  Future<void> _setDemoMode(bool value) async {
    setState(() {
      _demoModeEnabled = value;
    });
    await DemoSettingsStore.setDemoModeEnabled(value);
  }

  Future<void> _setMockBalanceEnabled(bool value) async {
    setState(() {
      _mockBalanceEnabled = value;
    });
    await DemoSettingsStore.setMockBalanceEnabled(value);
  }

  Future<void> _setForceNetworkError(bool value) async {
    setState(() {
      _forceNetworkError = value;
    });
    await DemoSettingsStore.setForceNetworkError(value);
  }

  Future<void> _setMockKycPending(bool value) async {
    setState(() {
      _mockKycPending = value;
    });
    await DemoSettingsStore.setMockKycPending(value);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Demo Settings'),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: colorScheme.errorContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  color: colorScheme.onErrorContainer,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Demo settings affect only this device. They are useful for testing UI and payment flow states.',
                    style: TextStyle(color: colorScheme.onErrorContainer),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: SwitchListTile(
              title: const Text('Enable Demo Mode'),
              subtitle: const Text(
                'Turns on local test controls and simulated states.',
              ),
              value: _demoModeEnabled,
              onChanged: _setDemoMode,
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: Column(
              children: [
                SwitchListTile(
                  title: const Text('Use Mock Wallet Balance'),
                  subtitle: const Text('Home balance card reads this value.'),
                  value: _mockBalanceEnabled,
                  onChanged: _demoModeEnabled ? _setMockBalanceEnabled : null,
                ),
                const Divider(height: 1),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextField(
                        controller: _balanceController,
                        enabled: _demoModeEnabled && _mockBalanceEnabled,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        decoration: const InputDecoration(
                          labelText: 'Mock Balance (NPR)',
                          prefixText: 'NPR ',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: _demoModeEnabled && _mockBalanceEnabled
                                  ? () => _applyDelta(1000)
                                  : null,
                              child: const Text('+ 1,000'),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: OutlinedButton(
                              onPressed: _demoModeEnabled && _mockBalanceEnabled
                                  ? () => _applyDelta(5000)
                                  : null,
                              child: const Text('+ 5,000'),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: OutlinedButton(
                              onPressed: _demoModeEnabled && _mockBalanceEnabled
                                  ? () => _applyDelta(-_mockBalance)
                                  : null,
                              child: const Text('Reset'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      FilledButton(
                        onPressed: _demoModeEnabled && _mockBalanceEnabled
                            ? _updateMockBalance
                            : null,
                        child: const Text('Save Balance'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: Column(
              children: [
                SwitchListTile(
                  title: const Text('Force Network Error'),
                  subtitle: const Text(
                    'Simulate failed API behavior in demo flows.',
                  ),
                  value: _forceNetworkError,
                  onChanged: _demoModeEnabled ? _setForceNetworkError : null,
                ),
                const Divider(height: 1),
                SwitchListTile(
                  title: const Text('Mock KYC Pending'),
                  subtitle: const Text(
                    'Simulate user as unverified for testing.',
                  ),
                  value: _mockKycPending,
                  onChanged: _demoModeEnabled ? _setMockKycPending : null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
