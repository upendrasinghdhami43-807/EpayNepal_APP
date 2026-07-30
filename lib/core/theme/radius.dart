import 'package:flutter/material.dart';

class AppRadius extends ThemeExtension<AppRadius> {
  final double sm;
  final double md;
  final double lg;
  final double xl;
  final double circular;

  const AppRadius({
    this.sm = 8.0,
    this.md = 12.0,
    this.lg = 16.0,
    this.xl = 24.0,
    this.circular = 100.0,
  });

  @override
  ThemeExtension<AppRadius> copyWith({
    double? sm,
    double? md,
    double? lg,
    double? xl,
    double? circular,
  }) {
    return AppRadius(
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
      circular: circular ?? this.circular,
    );
  }

  @override
  ThemeExtension<AppRadius> lerp(ThemeExtension<AppRadius>? other, double t) {
    if (other is! AppRadius) {
      return this;
    }
    return AppRadius(
      sm: _lerp(sm, other.sm, t),
      md: _lerp(md, other.md, t),
      lg: _lerp(lg, other.lg, t),
      xl: _lerp(xl, other.xl, t),
      circular: _lerp(circular, other.circular, t),
    );
  }

  double _lerp(double a, double b, double t) => a + (b - a) * t;
}
