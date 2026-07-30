# EpayNepal — Folder Structure

## Mobile App (Flutter)

```
lib/
├── main.dart
├── app/
│   └── router/
│       ├── app_router.dart          # GoRouter configuration
│       ├── main_shell.dart          # Bottom navigation shell
│       └── route_names.dart         # Route name constants
├── core/
│   ├── constants/
│   │   ├── api_endpoints.dart       # Base URLs, endpoint paths
│   │   ├── app_colors.dart          # Color constants (legacy compat)
│   │   ├── app_strings.dart         # User-facing strings
│   │   └── hive_box_names.dart      # Hive box name constants
│   ├── error/
│   │   └── error_handler.dart       # Centralized error mapping
│   ├── network/
│   │   ├── api_client.dart          # Dio HTTP client
│   │   ├── api_response.dart        # Response wrapper model
│   │   └── token_interceptor.dart   # Auth token injection
│   ├── services/
│   │   ├── hive_service.dart        # Local storage init
│   │   └── secure_storage_service.dart  # Encrypted key-value
│   ├── theme/
│   │   ├── app_theme_light.dart     # Light ThemeData
│   │   ├── app_theme_dark.dart      # Dark ThemeData
│   │   ├── color_schemes.dart       # Material 3 color schemes
│   │   ├── typography.dart          # Text theme (Inter)
│   │   ├── spacing.dart             # Spacing constants
│   │   ├── radius.dart              # Border radius constants
│   │   └── elevation.dart           # Shadow/elevation constants
│   ├── utils/
│   │   ├── validators.dart          # Input validation helpers
│   │   ├── currency_formatter.dart  # NPR formatting
│   │   └── ui_feedback.dart         # Snackbar/toast helpers
│   └── widgets/
│       ├── buttons/
│       │   └── primary_button.dart
│       ├── cards/
│       │   └── base_card.dart
│       └── inputs/
│           └── custom_text_field.dart
├── features/
│   ├── auth/
│   │   └── presentation/
│   │       ├── screens/             # login, register, otp, mpin, etc.
│   │       └── providers/           # auth_provider.dart
│   ├── home/
│   │   └── presentation/screens/    # home_screen.dart
│   ├── wallet/
│   │   └── presentation/screens/    # wallet_overview, top_up, withdraw
│   ├── payment/
│   │   └── presentation/screens/    # details, confirm, success
│   ├── qr/
│   │   └── presentation/screens/    # scanner, generate
│   ├── kyc/
│   │   └── presentation/screens/    # dashboard, personal_info, doc_upload
│   ├── bank/
│   │   └── presentation/screens/    # accounts, transfer, link
│   ├── utility/
│   │   └── presentation/screens/    # topup, electricity, internet, govt, edu
│   ├── travel/
│   │   └── presentation/screens/    # flight, hub
│   ├── history/
│   │   └── presentation/screens/    # statement, transaction_details
│   ├── support/
│   │   └── presentation/screens/    # support, faq, tickets
│   ├── more/
│   │   └── presentation/screens/    # more menu hub
│   ├── profile/
│   │   └── presentation/screens/    # profile view/edit
│   ├── settings/
│   │   └── presentation/screens/    # app settings, language, theme
│   ├── onboarding/
│   │   └── presentation/screens/    # splash, welcome, flow
│   ├── remittance/
│   │   └── presentation/screens/    # remittance
│   ├── load_money/
│   │   └── presentation/screens/    # load money
│   └── demo_settings/
│       ├── data/                    # demo_settings_store.dart
│       └── presentation/screens/    # test_demo_settings
```

## Backend (Laravel)

```
backend/
├── app/
│   ├── Http/
│   │   ├── Controllers/
│   │   │   └── Api/
│   │   │       ├── AuthController.php
│   │   │       ├── UserController.php
│   │   │       ├── WalletController.php
│   │   │       ├── TransactionController.php
│   │   │       ├── QrController.php
│   │   │       ├── BillController.php
│   │   │       ├── KycController.php
│   │   │       ├── MerchantController.php
│   │   │       ├── NotificationController.php
│   │   │       ├── SupportController.php
│   │   │       └── Admin/
│   │   │           ├── AdminAuthController.php
│   │   │           ├── AdminUserController.php
│   │   │           ├── AdminKycController.php
│   │   │           ├── AdminTransactionController.php
│   │   │           └── AdminReportController.php
│   │   ├── Requests/                # Form Request validation classes
│   │   └── Middleware/              # Custom middleware
│   ├── Models/                      # Eloquent models
│   ├── Services/                    # Business logic
│   │   ├── AuthService.php
│   │   ├── WalletService.php
│   │   ├── TransactionService.php
│   │   ├── QrService.php
│   │   ├── KycService.php
│   │   ├── NotificationService.php
│   │   └── BillService.php
│   ├── Jobs/                        # Queue jobs
│   ├── Events/                      # Domain events
│   ├── Listeners/                   # Event listeners
│   └── Exceptions/                  # Custom exceptions
├── database/
│   ├── migrations/
│   ├── seeders/
│   └── factories/
├── routes/
│   └── api.php
├── config/
├── .env.example
└── composer.json
```

## Admin Panel (React)

```
admin/
├── src/
│   ├── api/                         # Axios instances, endpoint functions
│   │   ├── client.ts
│   │   ├── auth.ts
│   │   ├── users.ts
│   │   ├── transactions.ts
│   │   └── kyc.ts
│   ├── components/                  # Shared UI components
│   │   ├── layout/
│   │   │   ├── AdminLayout.tsx
│   │   │   ├── Sidebar.tsx
│   │   │   └── TopBar.tsx
│   │   ├── ui/                      # shadcn/ui components
│   │   └── common/
│   ├── pages/                       # Page components
│   │   ├── DashboardPage.tsx
│   │   ├── UserListPage.tsx
│   │   ├── UserDetailPage.tsx
│   │   ├── TransactionListPage.tsx
│   │   ├── KycQueuePage.tsx
│   │   └── ...
│   ├── hooks/                       # Custom React hooks
│   ├── context/                     # React context providers
│   ├── utils/                       # Utility functions
│   ├── types/                       # TypeScript type definitions
│   ├── App.tsx
│   └── main.tsx
├── public/
├── index.html
├── package.json
├── tsconfig.json
├── tailwind.config.js
├── vite.config.ts
└── .env.example
```
