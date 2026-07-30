import 'package:intl/intl.dart';

/// Formats currency amounts in Nepali Rupees.
class CurrencyFormatter {
  static final _compact = NumberFormat.compact(locale: 'en_IN');
  static final _full = NumberFormat('#,##,##,###.##', 'en_IN');

  /// Returns `NPR 1,20,000.00`
  static String format(double amount) {
    return 'NPR ${_full.format(amount)}';
  }

  /// Returns `NPR 1.2L` (compact form for display in small spaces)
  static String compact(double amount) {
    return 'NPR ${_compact.format(amount)}';
  }

  /// Returns `NPR 1,20,000.00` or hides with `NPR ●●●●.●●`
  static String formatMasked(double amount, {bool visible = true}) {
    if (!visible) return 'NPR ●●●●.●●';
    return format(amount);
  }

  /// Parses a user-typed amount string into a double.
  static double? parse(String value) {
    return double.tryParse(value.replaceAll(',', '').trim());
  }
}
