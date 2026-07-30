import 'package:flutter/material.dart';
import 'spacing.dart';
import 'radius.dart';
import 'elevation.dart';

extension AppThemeExtension on ThemeData {
  AppSpacing get spacing => extension<AppSpacing>() ?? const AppSpacing();
  AppRadius get radius => extension<AppRadius>() ?? const AppRadius();
  AppElevation get elevation => extension<AppElevation>() ?? const AppElevation();
}

extension BuildContextThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => theme.colorScheme;
  TextTheme get textTheme => theme.textTheme;
  
  AppSpacing get spacing => theme.spacing;
  AppRadius get radius => theme.radius;
  AppElevation get elevation => theme.elevation;
}
