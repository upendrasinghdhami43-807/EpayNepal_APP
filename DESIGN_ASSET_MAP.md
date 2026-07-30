# DESIGN ASSET MAP — EpayNepal

> Maps every Stitch design export to its Flutter screen implementation.  
> **Last updated:** July 30, 2026

## Legend
- ✅ Stitch export exists AND Flutter screen implemented
- 🎨 Stitch export exists, Flutter screen NOT yet implemented
- 🔧 Flutter screen exists, NO Stitch export (custom design needed)
- ❌ Neither exists (needs both design and implementation)

---

## Onboarding & Auth

| Stitch Folder | Flutter Screen | Status |
|--------------|---------------|--------|
| `splash_screen` | `onboarding/splash_screen.dart` | ✅ |
| `welcome` | `onboarding/welcome_screen.dart` | ✅ |
| `onboarding` | `onboarding/onboarding_flow_screen.dart` | ✅ |
| `onboarding_flow` | `onboarding/onboarding_flow_screen.dart` | ✅ |
| `authentication_hub` | `auth/auth_hub_screen.dart` | ✅ |
| `login` | `auth/login_screen.dart` | ✅ |
| `register` | `auth/register_screen.dart` | ✅ |
| `otp_verification` | `auth/otp_screen.dart` | ✅ |
| `create_mpin` | `auth/create_mpin_screen.dart` | ✅ |
| `devices_credentials` | `auth/devices_credentials_screen.dart` | ✅ |
| — | Forgot password screen | ❌ |
| — | Create password screen | ❌ |
| — | Confirm PIN screen | ❌ |
| — | Biometric setup screen | ❌ |

## Core / Dashboard

| Stitch Folder | Flutter Screen | Status |
|--------------|---------------|--------|
| `home` | `home/home_screen.dart` | ✅ |
| `home_master_dark` | Dark mode variant | 🎨 |
| `emerald_wallet_1` | Wallet card variant 1 | ✅ |
| `emerald_wallet_2` | Wallet card variant 2 | ✅ |
| `wallet_dashboard_master` | Finance overview | ✅ |
| `my_calendar` | Calendar screen | 🎨 |
| — | Notifications screen | ❌ |

## Money Movement

| Stitch Folder | Flutter Screen | Status |
|--------------|---------------|--------|
| `load_money` | `load_money/load_money_screen.dart` | ✅ |
| `bank_accounts` | `bank/bank_accounts_screen.dart` | ✅ |
| `bank_transfer` | `bank/bank_transfer_screen.dart` | ✅ |
| `remittance` | `remittance/remittance_screen.dart` | ✅ |
| `confirm_payment` | `payment/confirm_payment_screen.dart` | ✅ |
| `payment_details` | `payment/payment_details_screen.dart` | ✅ |
| `payment_success` | `payment/payment_success_screen.dart` | ✅ |
| `payment_success_failure` | Success/failure variant | 🎨 |
| — | Send money screen | ❌ |
| — | Receive money screen | ❌ |
| — | Request money screen | ❌ |
| — | Withdraw screen | ❌ |
| — | Wallet overview screen | ❌ |

## Bill & Service Payments

| Stitch Folder | Flutter Screen | Status |
|--------------|---------------|--------|
| `topup_data_packs` | `utility/mobile_topup_screen.dart` | ✅ |
| `topup_data_packs_dark` | Dark variant | 🎨 |
| `internet_bill_payment` | `utility/internet_bill_screen.dart` | ✅ |
| `internet_bill_payment_dark` | Dark variant | 🎨 |
| `electricity_bill_payment` | `utility/electricity_bill_screen.dart` | ✅ |
| `electricity_bill_payment_dark` | Dark variant | 🎨 |
| `government_payments` | `utility/government_payment_screen.dart` | ✅ |
| `government_payments_dark` | Dark variant | 🎨 |
| `education_fee_payment` | `utility/education_fee_screen.dart` | ✅ |
| `education_fee_payment_dark` | Dark variant | 🎨 |
| `traffic_fine_payment` | Not implemented | 🎨 |
| `traffic_fine_payment_dark` | Dark variant | 🎨 |
| `airline_ticketing` | `travel/flight_booking_screen.dart` | ✅ |
| `airline_ticketing_dark` | Dark variant | 🎨 |
| `events_shows` | Not implemented | 🎨 |
| `travel_ticketing` | `travel/travel_hub_screen.dart` | ✅ |
| `utility_payments` | `utility/utility_payments_screen.dart` | ✅ |
| — | Water bill screen | ❌ |
| — | Cable TV screen | ❌ |

## KYC

| Stitch Folder | Flutter Screen | Status |
|--------------|---------------|--------|
| `kyc_dashboard` | `kyc/kyc_dashboard_screen.dart` | ✅ |
| `kyc_personal_info` | `kyc/kyc_personal_info_screen.dart` | ✅ |
| `kyc_document_upload` | Not implemented | 🎨 |
| `kyc_form` | Mapped to KYC update | ✅ |
| `kyc_form_dark` | Dark variant | 🎨 |
| `link_bank_account` | Mapped to bank link | ✅ |
| `link_bank_account_dark` | Dark variant | 🎨 |
| — | Selfie capture screen | ❌ |
| — | KYC status screen | ❌ |

## History & Statements

| Stitch Folder | Flutter Screen | Status |
|--------------|---------------|--------|
| `statement` | `history/statement_screen.dart` | ✅ |
| `statement_dark` | Dark variant | 🎨 |
| `transaction_details` | `history/transaction_details_screen.dart` | ✅ |
| `transaction_details_dark` | Dark variant | 🎨 |

## Support & Settings

| Stitch Folder | Flutter Screen | Status |
|--------------|---------------|--------|
| `support` | `support/support_screen.dart` | ✅ |
| `support_dark` | Dark variant | 🎨 |
| `more_menu_full` | `more/more_screen.dart` | ✅ |
| `more_menu_full_dark` | Dark variant | 🎨 |
| `report_a_problem` | Not implemented | 🎨 |
| `report_a_problem_dark` | Dark variant | 🎨 |
| `test_demo_settings` | `demo_settings/test_demo_settings_screen.dart` | ✅ |
| — | Profile screen | ❌ |
| — | Security settings screen | ❌ |
| — | App settings screen | ❌ |
| — | Language selection screen | ❌ |
| — | FAQ screen | ❌ |
| — | Contact us screen | ❌ |
| — | Live chat screen | ❌ |

## QR

| Stitch Folder | Flutter Screen | Status |
|--------------|---------------|--------|
| `scan_qr` | `qr/qr_scanner_screen.dart` | ✅ |
| `qr_settings` | Not implemented | 🎨 |
| — | QR generate screen | ❌ |
| — | Merchant payment confirm | ❌ |

## System Screens (No Stitch exports)

| Screen | Status |
|--------|--------|
| Generic loading state | ❌ |
| Generic error state | ❌ |
| Empty state | ❌ |
| Offline / no internet | ❌ |
| Maintenance mode | ❌ |

---

## Gap Analysis Summary

| Category | ✅ Done | 🎨 Design Only | 🔧 Code Only | ❌ Missing |
|----------|--------|---------------|-------------|-----------|
| Onboarding/Auth | 10 | 0 | 0 | 4 |
| Core/Dashboard | 5 | 2 | 0 | 1 |
| Money Movement | 7 | 1 | 0 | 5 |
| Bills/Services | 9 | 10 | 0 | 2 |
| KYC | 4 | 3 | 0 | 2 |
| History | 2 | 2 | 0 | 0 |
| Support/Settings | 3 | 4 | 0 | 7 |
| QR | 1 | 1 | 0 | 2 |
| System | 0 | 0 | 0 | 5 |
| **Total** | **41** | **23** | **0** | **28** |

**41 screens implemented**, **23 dark mode/variant designs available**, **28 screens need design + implementation** for Phase 3 completion.
