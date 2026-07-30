# EpayNepal — Workflow Diagrams

## 1. User Registration & Verification

```mermaid
sequenceDiagram
    participant U as User (Flutter)
    participant A as Laravel API
    participant DB as PostgreSQL
    participant SMS as Sparrow SMS

    U->>A: POST /auth/register {phone, name, password}
    A->>A: Validate (FormRequest)
    A->>DB: Check phone uniqueness
    A->>DB: INSERT user (status=active, kyc_level=none)
    A->>DB: CREATE wallet (balance=0)
    A->>DB: INSERT otp_code (hashed, expires 5min)
    A-->>SMS: Send OTP via SMS
    A->>U: 201 {success: true, message: "OTP sent"}

    U->>A: POST /auth/verify-otp {phone, otp}
    A->>DB: Verify OTP hash, check expiry, check attempts
    alt OTP Valid
        A->>DB: UPDATE user.phone_verified_at
        A->>DB: Mark OTP as used
        A->>U: 200 {success: true, message: "Phone verified"}
    else OTP Invalid
        A->>DB: INCREMENT otp attempts
        A->>U: 400 {error: OTP_INVALID}
    end
```

## 2. Login Flow

```mermaid
sequenceDiagram
    participant U as User (Flutter)
    participant A as Laravel API
    participant DB as PostgreSQL

    U->>A: POST /auth/login {phone, password, device_id}
    A->>A: Rate limit check
    A->>DB: Find user by phone
    A->>A: Verify password hash
    alt Account Frozen
        A->>U: 403 {error: ACCOUNT_FROZEN}
    else Password Correct
        A->>DB: Create Sanctum token
        A->>DB: Upsert device record
        A->>U: 200 {token, user, wallet}
    else Password Wrong
        A->>U: 401 {error: UNAUTHORIZED}
    end
```

## 3. Send Money (P2P Transfer)

```mermaid
sequenceDiagram
    participant U as Sender (Flutter)
    participant A as Laravel API
    participant WS as WalletService
    participant DB as PostgreSQL
    participant Q as Job Queue

    U->>A: POST /wallet/send-money {receiver_phone, amount, pin, note}
    A->>A: FormRequest validation
    A->>A: Verify transaction PIN
    A->>DB: Find receiver by phone
    A->>WS: sendMoney(sender, receiver, amount)
    WS->>DB: BEGIN TRANSACTION
    WS->>DB: Lock sender wallet (FOR UPDATE)
    WS->>DB: Lock receiver wallet (FOR UPDATE)
    WS->>WS: Check balance >= amount + fee
    WS->>DB: Debit sender wallet
    WS->>DB: Credit receiver wallet
    WS->>DB: INSERT transaction (status=completed)
    WS->>DB: INSERT transaction_log (sender, debit)
    WS->>DB: INSERT transaction_log (receiver, credit)
    WS->>DB: COMMIT
    WS->>A: Return transaction
    A->>U: 200 {success: true, data: transaction}
    A-->>Q: Dispatch notifications (async)
    Q-->>DB: INSERT notification for sender
    Q-->>DB: INSERT notification for receiver
    Q-->>FCM: Push notification to both
```

## 4. QR Payment Flow

```mermaid
sequenceDiagram
    participant U as Payer (Flutter)
    participant CAM as Camera (mobile_scanner)
    participant A as Laravel API
    participant WS as WalletService

    U->>CAM: Open QR scanner
    CAM->>U: Detect QR code payload
    U->>A: POST /qr/resolve {qr_payload}
    A->>A: Parse QR (merchant_id or user_id + amount)
    A->>U: 200 {merchant_name, amount, details}
    U->>U: Show confirmation screen
    U->>A: POST /qr/pay {qr_payload, amount, pin}
    A->>A: Verify PIN
    A->>WS: processQRPayment(payer, merchant, amount)
    WS->>WS: Same locking flow as P2P
    A->>U: 200 {success: true, data: transaction}
```

## 5. KYC Submission & Review

```mermaid
sequenceDiagram
    participant U as User (Flutter)
    participant A as Laravel API
    participant R2 as Cloudflare R2
    participant AD as Admin (React)

    U->>A: POST /kyc/upload-document {citizenship_front}
    A->>A: Validate file type/size
    A->>R2: Upload file
    R2->>A: Return URL
    A->>U: 200 {url}

    U->>A: POST /kyc/upload-document {citizenship_back}
    A->>R2: Upload file
    A->>U: 200 {url}

    U->>A: POST /kyc/upload-selfie {selfie}
    A->>R2: Upload file
    A->>U: 200 {url}

    U->>A: POST /kyc/submit {name, dob, address, document_urls}
    A->>DB: INSERT kyc_request (status=pending)
    A->>U: 200 {status: pending}

    Note over AD: Admin reviews KYC queue
    AD->>A: GET /admin/kyc (queue)
    AD->>A: GET /admin/kyc/{id} (detail + signed doc URLs)
    AD->>A: PUT /admin/kyc/{id}/approve
    A->>DB: UPDATE kyc_request.status = approved
    A->>DB: UPDATE user.kyc_level = verified
    A->>DB: UPDATE user.balance_limit, transfer_limit
    A-->>Q: Notify user (KYC approved)
```

## 6. Notification Delivery

```mermaid
graph TB
    EVENT["Event Triggered<br>(transaction, KYC update, etc.)"]
    LISTENER["Event Listener"]
    JOB["Notification Job<br>(queued)"]
    DB["Save to notifications table"]
    FCM["Firebase Cloud Messaging"]
    DEVICE["User's Device"]

    EVENT --> LISTENER
    LISTENER --> JOB
    JOB --> DB
    JOB --> FCM
    FCM --> DEVICE
```

## 7. Bill Payment Flow

```mermaid
sequenceDiagram
    participant U as User (Flutter)
    participant A as Laravel API
    participant WS as WalletService
    participant BP as BillProvider (Mock)

    U->>A: POST /bills/electricity {account_number, amount, pin}
    A->>A: Validate + verify PIN
    A->>BP: Verify account (mock: always valid)
    A->>WS: debitWallet(user, amount + fee)
    WS->>DB: Lock wallet, debit, log
    A->>DB: INSERT transaction (type=BILL)
    A->>DB: INSERT bill_payment record
    A->>U: 200 {success: true, data: transaction}
```
