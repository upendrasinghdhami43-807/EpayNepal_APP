# EpayNepal Backend Plan (Laravel 12)

## 1. Module Breakdown
- Auth: register, OTP verify/resend, login/logout, password reset, transaction PIN.
- User: profile, photo, devices.
- Wallet: balance, top-up, withdraw.
- Transactions: send-money, history, detail, receipt.
- QR: my-code, resolve, pay.
- Bills: mobile/electricity/internet/water/cable/government/education/traffic.
- KYC: submit, upload docs, upload selfie, status, admin review.
- Merchant: register, list, merchant QR.
- Notifications: list/read/read-all + push dispatch.
- Support: ticket create/list/detail/reply.
- Admin: auth, users, KYC queue, tx monitoring, reports, settings.

## 2. Layered Architecture
- Controllers: thin HTTP adapters only.
- Form Requests: request validation per endpoint.
- Services: business logic and orchestration.
- Repositories: persistence abstraction for key entities.
- Jobs: non-blocking external side effects (SMS/email/push).
- Events/Listeners: audit + notification hooks after financial ops.

## 3. Controller Design
- `AuthController`: register/login/logout/otp/pin/password.
- `UserController`: get/update profile, device registration.
- `WalletController`: balance/top-up/withdraw.
- `TransactionController`: send/history/detail/receipt.
- `QrController`: my-code/resolve/pay.
- `KycController`: submit/upload/status.
- `NotificationController`: list/read/read-all.
- `BillController`: all utility payments.
- `MerchantController`: merchant onboarding and QR.
- `SupportController`: ticket flow.
- `AdminController`: admin auth + operational endpoints.

## 4. Service Design
- `AuthService`: user auth + OTP + PIN hashing + token issuance.
- `WalletService`: credit/debit/read balance with DB transaction + lock.
- `TransactionService`: transfer, listing, details.
- `QrService`: generate/resolve/charge QR payloads.
- `KycService`: upload path handling and status lifecycle.
- `NotificationService`: persistence + queue dispatch helpers.
- `BillService`: standardized bill-pay operation wrappers.
- `MerchantService`: register merchant + QR issuance.
- `SupportService`: ticket message lifecycle.
- `ReportService`: KPIs and summaries.
- `SettingService`: read/write app settings.

## 5. Repository Plan
- `UserRepository`, `WalletRepository`, `TransactionRepository`, `KycRepository`, `NotificationRepository`.
- Keep interfaces in `app/Repositories/Contracts`.
- Use Eloquent implementation in `app/Repositories`.

## 6. Middleware Plan
- `SanitizeInputMiddleware`: trims input strings and strips dangerous control chars.
- `RequestLogMiddleware`: logs request ID, user ID, path, timing.
- `EnsureTransactionPinMiddleware`: verifies `transaction_pin` in sensitive routes.
- Built-in rate limiting: `throttle:auth` and `throttle:api`.

## 7. Validation Strategy
- Every write endpoint uses Form Request classes.
- Money fields validated as numeric/min and standardized to decimal(15,2).
- Phone validation pattern for Nepal carriers.
- File upload rules for MIME and max size.

## 8. Events + Listeners
- `TransactionCompleted` event after successful monetary operations.
- `LogFinancialTransaction` listener writes `transaction_logs` and `audit_logs`.
- `SendTransactionNotification` listener pushes notification via queued job.

## 9. Jobs + Queues
- `SendOtpSmsJob` for OTP SMS provider.
- `SendPushNotificationJob` for FCM.
- `SendEmailNotificationJob` for fallback/alerts.
- Queue connection defaults to database for easy local setup.

## 10. API Endpoint Organization
- Prefix: `/api/v1`.
- Public routes: auth register/login/otp/forgot/reset.
- Authenticated user routes: wallet/transaction/qr/kyc/notifications/etc.
- Admin routes: `/api/v1/admin/*` protected by sanctum + ability checks.

## 11. Security Baseline in Implementation
- Sanctum token auth.
- Password + PIN hashed separately.
- Financial operations wrapped in DB transactions with row locking.
- Audit logs written for sensitive operations.
- Request throttling for auth/OTP endpoints.

## 12. Delivery Notes
- Environment lacks PHP XML/DOM extensions, so artisan script hooks are skipped.
- Core runtime code, migrations, and seeders are implemented via direct file scaffolding.
- Once XML/DOM extensions are installed, run normal artisan workflows and tests.
