import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'route_names.dart';
import 'main_shell.dart';
import '../features/home/presentation/screens/home_screen.dart';

// Temporary placeholder screens
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
  initialLocation: '/home', // Skip splash for now during dev
  routes: [
    GoRoute(
      path: '/',
      name: RouteNames.splash,
      builder: (context, state) => const PlaceholderScreen(title: 'Splash Screen'),
    ),
    GoRoute(
      path: '/onboarding',
      name: RouteNames.onboarding,
      builder: (context, state) => const PlaceholderScreen(title: 'Onboarding'),
    ),
    GoRoute(
      path: '/auth',
      name: RouteNames.authHub,
      builder: (context, state) => const PlaceholderScreen(title: 'Auth Hub'),
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
