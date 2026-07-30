import 'package:flutter/material.dart';

class AppColors {
  // Primary (Green variants)
  static const Color primary = Color(0xFF006e0d);
  static const Color onPrimary = Color(0xFFffffff);
  static const Color primaryContainer = Color(0xFF37c837);
  static const Color onPrimaryContainer = Color(0xFF004d06);
  static const Color primaryFixed = Color(0xFF75ff69);
  static const Color primaryFixedDim = Color(0xFF54e24e);
  static const Color onPrimaryFixed = Color(0xFF002201);
  static const Color onPrimaryFixedVariant = Color(0xFF005307);

  // Secondary
  static const Color secondary = Color(0xFF5e5f58);
  static const Color onSecondary = Color(0xFFffffff);
  static const Color secondaryContainer = Color(0xFFe4e3da);
  static const Color onSecondaryContainer = Color(0xFF64655e);
  static const Color secondaryFixed = Color(0xFFe4e3da);
  static const Color secondaryFixedDim = Color(0xFFc8c7bf);
  static const Color onSecondaryFixed = Color(0xFF1b1c17);
  static const Color onSecondaryFixedVariant = Color(0xFF474741);

  // Tertiary
  static const Color tertiary = Color(0xFF396668);
  static const Color onTertiary = Color(0xFFffffff);
  static const Color tertiaryContainer = Color(0xFF88b6b8);
  static const Color onTertiaryContainer = Color(0xFF18484a);
  static const Color tertiaryFixed = Color(0xFFbcebed);
  static const Color tertiaryFixedDim = Color(0xFFa0cfd1);
  static const Color onTertiaryFixed = Color(0xFF002021);
  static const Color onTertiaryFixedVariant = Color(0xFF1f4d50);

  // Error
  static const Color error = Color(0xFFba1a1a);
  static const Color onError = Color(0xFFffffff);
  static const Color errorContainer = Color(0xFFffdad6);
  static const Color onErrorContainer = Color(0xFF93000a);

  // Background / Surface
  static const Color background = Color(0xFFfafaf2);
  static const Color onBackground = Color(0xFF1a1c18);
  static const Color surface = Color(0xFFfafaf2);
  static const Color onSurface = Color(0xFF1a1c18);
  static const Color surfaceContainerHighest = Color(0xFFe3e3db);
  static const Color onSurfaceVariant = Color(0xFF3d4a39);
  static const Color outline = Color(0xFF6d7b68);
  static const Color outlineVariant = Color(0xFFbccbb4);
  static const Color shadow = Color(0xFF000000);
  static const Color scrim = Color(0xFF000000);
  static const Color inverseSurface = Color(0xFF2f312c);
  static const Color inverseOnSurface = Color(0xFFf1f1e9);
  static const Color inversePrimary = Color(0xFF54e24e);

  // Surface Containers
  static const Color surfaceDim = Color(0xFFdadad3);
  static const Color surfaceBright = Color(0xFFfafaf2);
  static const Color surfaceContainerLowest = Color(0xFFffffff);
  static const Color surfaceContainerLow = Color(0xFFf4f4ec);
  static const Color surfaceContainer = Color(0xFFeeeee6);
  static const Color surfaceContainerHigh = Color(0xFFe8e9e1);
}

const ColorScheme lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: AppColors.primary,
  onPrimary: AppColors.onPrimary,
  primaryContainer: AppColors.primaryContainer,
  onPrimaryContainer: AppColors.onPrimaryContainer,
  secondary: AppColors.secondary,
  onSecondary: AppColors.onSecondary,
  secondaryContainer: AppColors.secondaryContainer,
  onSecondaryContainer: AppColors.onSecondaryContainer,
  tertiary: AppColors.tertiary,
  onTertiary: AppColors.onTertiary,
  tertiaryContainer: AppColors.tertiaryContainer,
  onTertiaryContainer: AppColors.onTertiaryContainer,
  error: AppColors.error,
  onError: AppColors.onError,
  errorContainer: AppColors.errorContainer,
  onErrorContainer: AppColors.onErrorContainer,
  background: AppColors.background,
  onBackground: AppColors.onBackground,
  surface: AppColors.surface,
  onSurface: AppColors.onSurface,
  surfaceContainerHighest: AppColors.surfaceContainerHighest,
  onSurfaceVariant: AppColors.onSurfaceVariant,
  outline: AppColors.outline,
  outlineVariant: AppColors.outlineVariant,
  shadow: AppColors.shadow,
  scrim: AppColors.scrim,
  inverseSurface: AppColors.inverseSurface,
  onInverseSurface: AppColors.inverseOnSurface,
  inversePrimary: AppColors.inversePrimary,
  surfaceTint: AppColors.primary,
);

// We need a proper dark mode mapping. Currently using inverted or dark overrides where appropriate.
// Ideally, the Stitch export should have dark mode colors, but we will extrapolate for now.
const ColorScheme darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: AppColors.inversePrimary,
  onPrimary: AppColors.onPrimaryContainer,
  primaryContainer: AppColors.primary,
  onPrimaryContainer: AppColors.primaryFixed,
  secondary: AppColors.secondaryFixedDim,
  onSecondary: AppColors.onSecondaryFixed,
  secondaryContainer: AppColors.secondary,
  onSecondaryContainer: AppColors.secondaryFixed,
  tertiary: AppColors.tertiaryFixedDim,
  onTertiary: AppColors.onTertiaryFixed,
  tertiaryContainer: AppColors.tertiary,
  onTertiaryContainer: AppColors.tertiaryFixed,
  error: Color(0xFFffb4ab),
  onError: Color(0xFF690005),
  errorContainer: Color(0xFF93000a),
  onErrorContainer: Color(0xFFffdad6),
  background: Color(0xFF1a1c18),
  onBackground: Color(0xFFe3e3db),
  surface: Color(0xFF121411), // Dark surface
  onSurface: Color(0xFFe3e3db),
  surfaceContainerHighest: Color(0xFF3d4a39),
  onSurfaceVariant: Color(0xFFbccbb4),
  outline: Color(0xFF879581),
  outlineVariant: Color(0xFF3d4a39),
  shadow: Color(0xFF000000),
  scrim: Color(0xFF000000),
  inverseSurface: Color(0xFFe3e3db),
  onInverseSurface: Color(0xFF2f312c),
  inversePrimary: AppColors.primary,
  surfaceTint: AppColors.inversePrimary,
);
