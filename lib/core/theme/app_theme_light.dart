import 'package:flutter/material.dart';
import 'color_schemes.dart';
import 'typography.dart';
import 'spacing.dart';
import 'radius.dart';
import 'elevation.dart';

final ThemeData appThemeLight = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: lightColorScheme,
  textTheme: AppTypography.getTextTheme(AppColors.textPrimaryLight),
  scaffoldBackgroundColor: AppColors.backgroundLight,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.primary,
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
