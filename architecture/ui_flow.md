# EpayNepal — UI Flow (Screen Navigation Map)

## Main Navigation Structure

```mermaid
graph TB
    SPLASH["/ Splash"] --> ONBOARD["Onboarding Flow"]
    SPLASH --> HOME

    ONBOARD --> AUTH_HUB["Auth Hub"]
    AUTH_HUB --> LOGIN["Login"]
    AUTH_HUB --> REGISTER["Register"]

    REGISTER --> OTP["OTP Verification"]
    OTP --> MPIN["Create MPIN"]
    MPIN --> HOME

    LOGIN --> HOME["🏠 Home"]

    subgraph "Bottom Navigation Shell"
        HOME
        STATEMENT["📊 Statement"]
        SUPPORT["🎧 Support"]
        MORE["⚙️ More"]
    end

    HOME --> SCAN_QR["📷 QR Scanner (FAB)"]

    HOME --> LOAD["Load Money"]
    HOME --> SEND["Send Money"]
    HOME --> BANK_TRANSFER["Bank Transfer"]
    HOME --> REMITTANCE["Remittance"]

    HOME --> TOPUP["Mobile Topup"]
    HOME --> ELECTRICITY["Electricity Bill"]
    HOME --> INTERNET["Internet Bill"]
    HOME --> GOVT["Government Payment"]
    HOME --> EDUCATION["Education Fee"]
    HOME --> UTILITY["Utility Overview"]

    HOME --> FLIGHT["Flight Booking"]
    HOME --> TRAVEL["Travel Hub"]

    HOME --> NOTIF["Notifications"]
    HOME --> KYC_DASH["KYC Dashboard"]

    STATEMENT --> TX_DETAIL["Transaction Details"]

    SUPPORT --> FAQ["FAQ"]
    SUPPORT --> CONTACT["Contact Us"]
    SUPPORT --> CHAT["Live Chat"]
    SUPPORT --> TICKETS["Support Tickets"]

    MORE --> PROFILE["Profile"]
    MORE --> SECURITY["Security Settings"]
    MORE --> SETTINGS["App Settings"]
    MORE --> DEVICES["Linked Devices"]
    MORE --> LANGUAGE["Language"]
    MORE --> DEMO["Demo Settings"]

    SCAN_QR --> CONFIRM_PAY["Confirm Payment"]
    CONFIRM_PAY --> PAY_SUCCESS["Payment Success"]

    LOAD --> CONFIRM_PAY
    SEND --> PAY_DETAIL["Payment Details"]
    PAY_DETAIL --> CONFIRM_PAY

    KYC_DASH --> KYC_PERSONAL["KYC Personal Info"]
    KYC_DASH --> KYC_DOC["Document Upload"]
    KYC_DASH --> KYC_SELFIE["Selfie Capture"]
```

## Screen Categories

### Top-Level Routes (outside shell)
| Route | Screen | Purpose |
|-------|--------|---------|
| `/` | Splash | Auto-auth check, redirect |
| `/onboarding` | Onboarding Flow | First-time user intro |
| `/auth` | Auth Hub | Login/Register choice |
| `/login` | Login | Phone + password |
| `/register` | Register | Phone + name + password |
| `/otp` | OTP Verification | 6-digit code entry |
| `/create_mpin` | Create MPIN | Transaction PIN setup |
| `/scan_qr` | QR Scanner | Camera + scan |

### Shell Routes (bottom navigation)
| Route | Tab | Screen |
|-------|-----|--------|
| `/home` | Home | Dashboard |
| `/statement` | Statement | Transaction history |
| `/support` | Support | Help center |
| `/more` | More | Settings & profile |

### Feature Routes (pushed from shell)
| Route | Screen |
|-------|--------|
| `/load_money` | Load wallet |
| `/bank_accounts` | Linked banks |
| `/bank_transfer` | Transfer to bank |
| `/remittance` | Remittance |
| `/payment_details` | Payment form |
| `/confirm_payment` | Confirm & PIN |
| `/payment_success` | Success state |
| `/topup` | Mobile recharge |
| `/electricity` | Electricity bill |
| `/internet` | Internet bill |
| `/govt_payment` | Government payment |
| `/education_fee` | Education fee |
| `/utility` | Utility overview |
| `/flight_booking` | Flight booking |
| `/travel_hub` | Travel overview |
| `/kyc_dashboard` | KYC status |
| `/kyc_personal_info` | KYC form |
| `/transaction_details` | Receipt view |
| `/test_demo_settings` | Demo controls |
