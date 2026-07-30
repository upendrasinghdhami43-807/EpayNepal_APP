/// Input validation utilities for EpayNepal forms.
class AppValidators {
  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) return 'Phone number is required';
    final cleaned = value.replaceAll(RegExp(r'\s+'), '');
    if (!RegExp(r'^(98|97)\d{8}$').hasMatch(cleaned)) {
      return 'Enter a valid Nepali mobile number (98/97xxxxxxxx)';
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.trim().isEmpty) return 'Password is required';
    if (value.length < 8) return 'Password must be at least 8 characters';
    if (!RegExp(r'[A-Z]').hasMatch(value)) return 'Include at least one uppercase letter';
    if (!RegExp(r'[0-9]').hasMatch(value)) return 'Include at least one number';
    return null;
  }

  static String? confirmPassword(String? value, String original) {
    if (value == null || value.trim().isEmpty) return 'Please confirm your password';
    if (value != original) return 'Passwords do not match';
    return null;
  }

  static String? pin(String? value) {
    if (value == null || value.trim().isEmpty) return 'PIN is required';
    if (value.length != 4) return 'PIN must be exactly 4 digits';
    if (!RegExp(r'^\d{4}$').hasMatch(value)) return 'PIN must contain only digits';
    return null;
  }

  static String? otp(String? value) {
    if (value == null || value.trim().isEmpty) return 'OTP is required';
    if (value.length != 6) return 'OTP must be 6 digits';
    return null;
  }

  static String? amount(String? value) {
    if (value == null || value.trim().isEmpty) return 'Amount is required';
    final parsed = double.tryParse(value.replaceAll(',', ''));
    if (parsed == null || parsed <= 0) return 'Enter a valid amount';
    return null;
  }

  static String? required(String? value, [String fieldName = 'This field']) {
    if (value == null || value.trim().isEmpty) return '$fieldName is required';
    return null;
  }

  static String? fullName(String? value) {
    if (value == null || value.trim().isEmpty) return 'Full name is required';
    if (value.trim().length < 3) return 'Enter a valid full name';
    return null;
  }

  static String? accountNumber(String? value) {
    if (value == null || value.trim().isEmpty) return 'Account number is required';
    if (value.length < 9) return 'Enter a valid bank account number';
    return null;
  }
}
