import 'package:flutter/material.dart';

class AppElevation extends ThemeExtension<AppElevation> {
  final List<BoxShadow> none;
  final List<BoxShadow> sm;
  final List<BoxShadow> md;
  final List<BoxShadow> lg;

  const AppElevation({
    this.none = const [],
    this.sm = const [
      BoxShadow(
        color: Color(0x1A000000),
        blurRadius: 4,
        offset: Offset(0, 2),
      ),
    ],
    this.md = const [
      BoxShadow(
        color: Color(0x1A000000),
        blurRadius: 8,
        offset: Offset(0, 4),
      ),
    ],
    this.lg = const [
      BoxShadow(
        color: Color(0x1A000000),
        blurRadius: 16,
        offset: Offset(0, 8),
      ),
    ],
  });

  @override
  ThemeExtension<AppElevation> copyWith({
    List<BoxShadow>? none,
    List<BoxShadow>? sm,
    List<BoxShadow>? md,
    List<BoxShadow>? lg,
  }) {
    return AppElevation(
      none: none ?? this.none,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
    );
  }

  @override
  ThemeExtension<AppElevation> lerp(ThemeExtension<AppElevation>? other, double t) {
    if (other is! AppElevation) {
      return this;
    }
    return AppElevation(
      none: BoxShadow.lerpList(none, other.none, t) ?? const [],
      sm: BoxShadow.lerpList(sm, other.sm, t) ?? const [],
      md: BoxShadow.lerpList(md, other.md, t) ?? const [],
      lg: BoxShadow.lerpList(lg, other.lg, t) ?? const [],
    );
  }
}
