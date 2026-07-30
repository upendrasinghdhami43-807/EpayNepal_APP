import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/services/hive_service.dart';
import 'app/router/app_router.dart';
import 'core/theme/app_theme_light.dart';
import 'core/theme/app_theme_dark.dart';
import 'core/constants/app_strings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize local Hive storage for demo mode
  await HiveService.init();

  runApp(const ProviderScope(child: EmeraldWalletApp()));
}

class EmeraldWalletApp extends ConsumerWidget {
  const EmeraldWalletApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // We default to light theme for now. Later we will listen to themeBox or system preferences.
    return MaterialApp.router(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: appThemeLight,
      darkTheme: appThemeDark,
      themeMode: ThemeMode.system,
      routerConfig: appRouter,
    );
  }
}
