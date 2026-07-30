import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'route_names.dart';
import 'main_shell.dart';
import '../features/home/presentation/screens/home_screen.dart';

import '../features/onboarding/presentation/screens/splash_screen.dart';
import '../features/onboarding/presentation/screens/onboarding_flow_screen.dart';

import '../features/auth/presentation/screens/auth_hub_screen.dart';
import '../features/auth/presentation/screens/login_screen.dart';
import '../features/auth/presentation/screens/register_screen.dart';
import '../features/auth/presentation/screens/otp_screen.dart';
import '../features/auth/presentation/screens/create_mpin_screen.dart';
import '../features/auth/presentation/screens/devices_credentials_screen.dart';

import '../features/load_money/presentation/screens/load_money_screen.dart';
import '../features/bank/presentation/screens/bank_accounts_screen.dart';
import '../features/bank/presentation/screens/bank_transfer_screen.dart';

// Temporary placeholder screens for unresolved routes
class PlaceholderScreen extends StatelessWidget {
  final String title;
  const PlaceholderScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text('Screen: $title')),
    );
  }
}

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: RouteNames.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      name: RouteNames.onboarding,
      builder: (context, state) => const OnboardingFlowScreen(),
    ),
    GoRoute(
      path: '/auth',
      name: RouteNames.authHub,
      builder: (context, state) => const AuthHubScreen(),
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      name: 'register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/otp',
      name: 'otp',
      builder: (context, state) => const OtpScreen(),
    ),
    GoRoute(
      path: '/create_mpin',
      name: 'create_mpin',
      builder: (context, state) => const CreateMpinScreen(),
    ),
    GoRoute(
      path: '/devices',
      name: 'devices',
      builder: (context, state) => const DevicesCredentialsScreen(),
    ),
    GoRoute(
      path: '/load_money',
      name: 'load_money',
      builder: (context, state) => const LoadMoneyScreen(),
    ),
    GoRoute(
      path: '/bank_accounts',
      name: 'bank_accounts',
      builder: (context, state) => const BankAccountsScreen(),
    ),
    GoRoute(
      path: '/bank_transfer',
      name: 'bank_transfer',
      builder: (context, state) => const BankTransferScreen(),
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return MainShell(child: child);
      },
      routes: [
        GoRoute(
          path: '/home',
          name: RouteNames.home,
          builder: (context, state) => const HomeScreen(),
        ),
      ],
    ),
  ],
);
