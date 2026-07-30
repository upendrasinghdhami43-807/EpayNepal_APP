import 'package:hive_flutter/hive_flutter.dart';
import '../../../core/constants/hive_box_names.dart';

class DemoSettingsStore {
  static const String _demoModeEnabledKey = 'demoModeEnabled';
  static const String _mockBalanceEnabledKey = 'demoMockBalanceEnabled';
  static const String _mockBalanceKey = 'demoMockBalance';
  static const String _forceNetworkErrorKey = 'demoForceNetworkError';
  static const String _mockKycPendingKey = 'demoMockKycPending';

  static Box<dynamic> get _box => Hive.box(HiveBoxNames.settingsBox);

  static bool get demoModeEnabled =>
      (_box.get(_demoModeEnabledKey, defaultValue: false) as bool?) ?? false;

  static bool get mockBalanceEnabled =>
      (_box.get(_mockBalanceEnabledKey, defaultValue: false) as bool?) ?? false;

  static double get mockBalance {
    final value = _box.get(_mockBalanceKey, defaultValue: 45280.50);
    if (value is num) {
      return value.toDouble();
    }
    return 45280.50;
  }

  static bool get forceNetworkError =>
      (_box.get(_forceNetworkErrorKey, defaultValue: false) as bool?) ?? false;

  static bool get mockKycPending =>
      (_box.get(_mockKycPendingKey, defaultValue: false) as bool?) ?? false;

  static Future<void> setDemoModeEnabled(bool value) {
    return _box.put(_demoModeEnabledKey, value);
  }

  static Future<void> setMockBalanceEnabled(bool value) {
    return _box.put(_mockBalanceEnabledKey, value);
  }

  static Future<void> setMockBalance(double value) {
    return _box.put(_mockBalanceKey, value);
  }

  static Future<void> setForceNetworkError(bool value) {
    return _box.put(_forceNetworkErrorKey, value);
  }

  static Future<void> setMockKycPending(bool value) {
    return _box.put(_mockKycPendingKey, value);
  }
}
