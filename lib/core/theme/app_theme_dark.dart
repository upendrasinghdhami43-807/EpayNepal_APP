import 'package:flutter/material.dart';
import 'color_schemes.dart';
import 'typography.dart';
import 'spacing.dart';
import 'radius.dart';
import 'elevation.dart';

final ThemeData appThemeDark = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: darkColorScheme,
  textTheme: AppTypography.getTextTheme(AppColors.textPrimaryDark),
  scaffoldBackgroundColor: AppColors.backgroundDark,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.surfaceDark,
    foregroundColor: Colors.white,
    elevation: 0,
    centerTitle: true,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      elevation: 0,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  ),
  extensions: const [
    AppSpacing(),
    AppRadius(),
    AppElevation(),
  ],
);
