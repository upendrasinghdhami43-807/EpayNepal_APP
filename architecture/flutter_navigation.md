# EpayNepal — Flutter Navigation Design

## go_router Configuration

### Navigator Keys
```dart
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();
```

### Route Structure

```
GoRouter
├── / (splash) — top level
├── /onboarding — top level
├── /auth — top level
├── /login — top level
├── /register — top level
├── /otp — top level
├── /create_mpin — top level
├── /devices — top level
├── /scan_qr — top level (fullscreen camera)
├── /load_money — top level
├── /bank_accounts — top level
├── /bank_transfer — top level
├── /remittance — top level
├── /payment_details — top level
├── /confirm_payment — top level
├── /payment_success — top level
├── /topup — top level
├── /electricity — top level
├── /internet — top level
├── /govt_payment — top level
├── /education_fee — top level
├── /utility — top level
├── /flight_booking — top level
├── /travel_hub — top level
├── /kyc_dashboard — top level
├── /kyc_personal_info — top level
├── /transaction_details — top level
├── /test_demo_settings — top level
│
└── ShellRoute (MainShell — bottom navigation)
    ├── /home
    ├── /statement
    ├── /support
    └── /more
```

### Route Names (route_names.dart)
```dart
class RouteNames {
  static const splash = 'splash';
  static const onboarding = 'onboarding';
  static const authHub = 'auth_hub';
  static const login = 'login';
  static const register = 'register';
  static const otp = 'otp';
  static const createMpin = 'create_mpin';
  static const home = 'home';
  static const statement = 'statement';
  static const support = 'support';
  static const more = 'more';
  static const scanQr = 'scan_qr';
  // ... etc
}
```

### Route Guards (Future — Phase 12)

```dart
GoRouter(
  redirect: (context, state) {
    final isLoggedIn = ref.read(authProvider).isLoggedIn;
    final isOnAuthRoute = state.matchedLocation.startsWith('/login') ||
                          state.matchedLocation.startsWith('/register');

    if (!isLoggedIn && !isOnAuthRoute && state.matchedLocation != '/') {
      return '/login';
    }
    if (isLoggedIn && isOnAuthRoute) {
      return '/home';
    }
    return null;
  },
);
```

### MainShell (Bottom Navigation)

```dart
ShellRoute(
  navigatorKey: _shellNavigatorKey,
  builder: (context, state, child) => MainShell(child: child),
  routes: [
    GoRoute(path: '/home', ...),
    GoRoute(path: '/statement', ...),
    GoRoute(path: '/support', ...),
    GoRoute(path: '/more', ...),
  ],
)
```

Bottom nav bar tabs:
1. **Home** — Dashboard icon
2. **Statement** — Receipt/document icon
3. **QR Scan** — Floating center button (navigates to top-level `/scan_qr`)
4. **Support** — Headset icon
5. **More** — Menu/grid icon

### Parameter Passing

```dart
// Transaction details with ID
GoRoute(
  path: '/transaction_details/:id',
  builder: (context, state) {
    final txId = state.pathParameters['id']!;
    return TransactionDetailsScreen(transactionId: txId);
  },
),

// Payment with extra data
context.push('/confirm_payment', extra: PaymentData(...));
```
