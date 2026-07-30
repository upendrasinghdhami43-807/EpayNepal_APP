import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'route_names.dart';
import 'main_shell.dart';
import '../../features/home/presentation/screens/home_screen.dart';

import '../../features/onboarding/presentation/screens/splash_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_flow_screen.dart';

import '../../features/auth/presentation/screens/auth_hub_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/auth/presentation/screens/otp_screen.dart';
import '../../features/auth/presentation/screens/create_mpin_screen.dart';
import '../../features/auth/presentation/screens/devices_credentials_screen.dart';

import '../../features/load_money/presentation/screens/load_money_screen.dart';
import '../../features/bank/presentation/screens/bank_accounts_screen.dart';
import '../../features/bank/presentation/screens/bank_transfer_screen.dart';

import '../../features/remittance/presentation/screens/remittance_screen.dart';
import '../../features/payment/presentation/screens/payment_details_screen.dart';
import '../../features/payment/presentation/screens/confirm_payment_screen.dart';
import '../../features/payment/presentation/screens/payment_success_screen.dart';

import '../../features/utility/presentation/screens/utility_payments_screen.dart';
import '../../features/utility/presentation/screens/mobile_topup_screen.dart';
import '../../features/utility/presentation/screens/internet_bill_screen.dart';
import '../../features/utility/presentation/screens/electricity_bill_screen.dart';
import '../../features/utility/presentation/screens/government_payment_screen.dart';
import '../../features/utility/presentation/screens/education_fee_screen.dart';

import '../../features/travel/presentation/screens/flight_booking_screen.dart';
import '../../features/travel/presentation/screens/travel_hub_screen.dart';

import '../../features/more/presentation/screens/more_screen.dart';
import '../../features/kyc/presentation/screens/kyc_dashboard_screen.dart';
import '../../features/kyc/presentation/screens/kyc_personal_info_screen.dart';

import '../../features/history/presentation/screens/statement_screen.dart';
import '../../features/history/presentation/screens/transaction_details_screen.dart';
import '../../features/support/presentation/screens/support_screen.dart';
import '../../features/qr/presentation/screens/qr_scanner_screen.dart';
import '../../features/demo_settings/presentation/screens/test_demo_settings_screen.dart';

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
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  errorBuilder: (context, state) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page not found')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, size: 48),
              const SizedBox(height: 12),
              Text(state.error?.toString() ?? 'Unable to open requested page'),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () => context.go('/home'),
                child: const Text('Go to Home'),
              ),
            ],
          ),
        ),
      ),
    );
  },
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
    GoRoute(
      path: '/remittance',
      name: 'remittance',
      builder: (context, state) => const RemittanceScreen(),
    ),
    GoRoute(
      path: '/payment_details',
      name: 'payment_details',
      builder: (context, state) => const PaymentDetailsScreen(),
    ),
    GoRoute(
      path: '/confirm_payment',
      name: 'confirm_payment',
      builder: (context, state) => const ConfirmPaymentScreen(),
    ),
    GoRoute(
      path: '/payment_success',
      name: 'payment_success',
      builder: (context, state) => const PaymentSuccessScreen(),
    ),
    GoRoute(
      path: '/utility',
      name: 'utility',
      builder: (context, state) => const UtilityPaymentsScreen(),
    ),
    GoRoute(
      path: '/topup',
      name: 'topup',
      builder: (context, state) => const MobileTopupScreen(),
    ),
    GoRoute(
      path: '/internet',
      name: 'internet',
      builder: (context, state) => const InternetBillScreen(),
    ),
    GoRoute(
      path: '/electricity',
      name: 'electricity',
      builder: (context, state) => const ElectricityBillScreen(),
    ),
    GoRoute(
      path: '/govt_payment',
      name: 'govt_payment',
      builder: (context, state) => const GovernmentPaymentScreen(),
    ),
    GoRoute(
      path: '/education_fee',
      name: 'education_fee',
      builder: (context, state) => const EducationFeeScreen(),
    ),
    GoRoute(
      path: '/flight_booking',
      name: 'flight_booking',
      builder: (context, state) => const FlightBookingScreen(),
    ),
    GoRoute(
      path: '/travel_hub',
      name: 'travel_hub',
      builder: (context, state) => const TravelHubScreen(),
    ),
    GoRoute(
      path: '/kyc_dashboard',
      name: 'kyc_dashboard',
      builder: (context, state) => const KycDashboardScreen(),
    ),
    GoRoute(
      path: '/kyc_personal_info',
      name: 'kyc_personal_info',
      builder: (context, state) => const KycPersonalInfoScreen(),
    ),
    GoRoute(
      path: '/transaction_details',
      name: 'transaction_details',
      builder: (context, state) => const TransactionDetailsScreen(),
    ),
    GoRoute(
      path: '/scan_qr',
      name: 'scan_qr',
      builder: (context, state) => const QrScannerScreen(),
    ),
    GoRoute(
      path: '/test_demo_settings',
      name: 'test_demo_settings',
      builder: (context, state) => const TestDemoSettingsScreen(),
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
        GoRoute(
          path: '/statement',
          name: 'statement',
          builder: (context, state) => const StatementScreen(),
        ),
        GoRoute(
          path: '/support',
          name: 'support',
          builder: (context, state) => const SupportScreen(),
        ),
        GoRoute(
          path: '/more',
          name: 'more',
          builder: (context, state) => const MoreScreen(),
        ),
      ],
    ),
  ],
);
