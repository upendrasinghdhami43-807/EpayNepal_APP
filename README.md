# Emerald Wallet Flutter App

Emerald Wallet is a Flutter-based digital wallet demo inspired by eSewa-style flows.
It focuses on realistic wallet UI journeys, offline-first demo behavior, and modular screen organization.

Important: this is a demo application. It does not perform real payment transactions.

## App Concept

The app simulates the core experience of a Nepali digital wallet:

1. User onboarding and authentication
2. Wallet dashboard with balance, quick actions, and recent activity
3. QR scan to payment flow
4. Utility and travel payments
5. KYC status and verification flow
6. Statement and transaction detail views
7. Support and settings style screens

The current project emphasizes presentation, navigation, and local demo states over backend integration.

## Tech Stack

- Flutter, Dart
- flutter_riverpod for state management
- go_router for navigation
- hive and hive_flutter for local data storage
- flutter_secure_storage for secure local key/value
- mobile_scanner and image_picker for QR scanning and gallery import
- lottie, flutter_svg, cached_network_image, intl for UI utilities

## Architecture Overview

The source code is organized under lib using a layered approach:

- app: app-level routing and shell navigation
- core: shared constants, services, theme, and reusable widgets
- features: screen modules grouped by business domain

Entrypoint flow:

1. main.dart initializes Hive local storage
2. Riverpod ProviderScope is mounted
3. MaterialApp.router uses go_router configuration
4. Splash route decides navigation based on local auth state

## Project Structure

Top-level (trimmed):

```text
.
|- lib/
|  |- main.dart
|  |- app/
|  |- core/
|  \- features/
|- android/
|- ios/
|- web/
|- test/
|- stitch_esewa_jetpack_wallet_app/
|- DESIGN_ASSET_MAP.md
\- README.md
```

Primary source layout:

```text
lib/
|- main.dart
|- app/
|  \- router/
|     |- app_router.dart
|     |- main_shell.dart
|     \- route_names.dart
|- core/
|  |- constants/
|  |- services/
|  |- theme/
|  |- utils/
|  \- widgets/
\- features/
	|- auth/
	|- bank/
	|- demo_settings/
	|- history/
	|- home/
	|- kyc/
	|- load_money/
	|- more/
	|- onboarding/
	|- payment/
	|- qr/
	|- remittance/
	|- support/
	|- travel/
	\- utility/
```

## Route and Navigation Concept

Navigation uses go_router with two route groups:

- top-level routes for onboarding, auth, payments, utilities, travel, QR, and detail screens
- a ShellRoute that wraps home tabs with a custom bottom navigation in MainShell

Bottom shell tabs:

- /home
- /statement
- /support
- /more

Floating center action opens /scan_qr.

## Implemented Feature Areas

Implemented with Dart files and screens:

- auth
- bank
- demo_settings
- history
- home
- kyc
- load_money
- more
- onboarding
- payment
- qr
- remittance
- support
- travel
- utility

Scaffolded feature folders with no Dart implementation yet:

- airline_ticketing
- bills
- calendar
- developer_tools
- events
- payments
- profile
- send_money
- settings
- transactions
- wallet

## Data and State Concept

Local persistence:

- Hive is initialized at startup and opens multiple boxes for wallet/profile/transactions/settings and demo content.
- Auth state is currently demo-local and stored in Hive settings keys.
- Demo settings are stored in Hive and can simulate balance and error states.

State management:

- Riverpod is currently used for auth state notifier.
- Most feature screens are UI-focused and currently manage local widget state.

## Main User Journeys

1. Splash -> onboarding/auth
2. Login -> Home
3. Home -> Load Money / Bank Transfer / Remittance / Payment entry
4. QR Scanner -> detect QR -> pay now -> payment details -> confirm -> success
5. Home/Statement -> transaction details
6. More -> test demo settings / app options

## Design Asset References

The folder stitch_esewa_jetpack_wallet_app contains per-screen design references:

- code.html: design-exported HTML mock for the screen
- screen.png: screenshot reference

Mapping status between design folders and Flutter screens is tracked in DESIGN_ASSET_MAP.md.

## Getting Started

Prerequisites:

- Flutter SDK (stable)
- Dart SDK (from Flutter)
- Android Studio or Xcode (for platform targets)

Run locally:

```bash
flutter pub get
flutter run
```

Useful commands:

```bash
flutter analyze
flutter test
```

Note: current test folder is minimal and may not include meaningful test coverage yet.

## Current Limitations

- No production backend integration
- No real payments
- Some flows are placeholder or coming-soon actions
- Several feature directories are scaffolds for future implementation

## Next Recommended Improvements

1. Add domain/data layers per feature and repository interfaces
2. Expand Riverpod usage beyond auth
3. Add integration with real APIs behind an environment layer
4. Add widget and integration tests for key journeys
5. Complete scaffolded feature modules
