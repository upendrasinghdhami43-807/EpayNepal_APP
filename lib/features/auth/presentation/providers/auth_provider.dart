import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../../core/constants/hive_box_names.dart';

enum AuthState {
  initial,
  unauthenticated,
  authenticated,
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState.initial) {
    _checkAuthStatus();
  }

  void _checkAuthStatus() {
    final box = Hive.box(HiveBoxNames.settingsBox);
    final isLoggedIn = box.get('isLoggedIn', defaultValue: false);
    
    if (isLoggedIn) {
      state = AuthState.authenticated;
    } else {
      state = AuthState.unauthenticated;
    }
  }

  Future<void> login(String phoneNumber, String mpin) async {
    // Demo login: Accept anything for now, or check against a dummy hashed MPIN
    final box = Hive.box(HiveBoxNames.settingsBox);
    await box.put('isLoggedIn', true);
    await box.put('currentUserPhone', phoneNumber);
    state = AuthState.authenticated;
  }

  Future<void> logout() async {
    final box = Hive.box(HiveBoxNames.settingsBox);
    await box.put('isLoggedIn', false);
    await box.delete('currentUserPhone');
    state = AuthState.unauthenticated;
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});
