# EpayNepal — System Design

## 1. High-Level Architecture

```mermaid
graph TB
    subgraph "Client Layer"
        MA["📱 Flutter Mobile App<br>(Android / iOS)"]
        AD["💻 React Admin Dashboard<br>(Web Browser)"]
    end

    subgraph "API Gateway"
        API["🔌 Laravel API<br>api.epaynepal.com<br>/api/v1/*"]
    end

    subgraph "Service Layer"
        AS["Auth Service"]
        WS["Wallet Service"]
        TS["Transaction Service"]
        QS["QR Service"]
        KS["KYC Service"]
        NS["Notification Service"]
        BS["Bill Service"]
        MS["Merchant Service"]
    end

    subgraph "Data Layer"
        DB[("PostgreSQL<br>Primary Database")]
        CACHE[("Redis<br>Cache & Queues")]
        STORAGE["☁️ Cloudflare R2<br>File Storage"]
    end

    subgraph "External Services"
        FCM["Firebase FCM<br>Push Notifications"]
        SMS["Sparrow SMS<br>OTP Provider"]
    end

    MA -->|HTTPS + Sanctum Token| API
    AD -->|HTTPS + Sanctum Token| API

    API --> AS & WS & TS & QS & KS & NS & BS & MS

    AS & WS & TS & QS & KS & NS & BS & MS --> DB
    AS & WS --> CACHE
    KS --> STORAGE

    NS --> FCM
    AS --> SMS
```

## 2. Low-Level Component Architecture

### Mobile App (Flutter)

```mermaid
graph TB
    subgraph "Presentation Layer"
        SC["Screens"]
        WG["Widgets"]
    end

    subgraph "State Management"
        PR["Riverpod Providers"]
        NT["State Notifiers"]
    end

    subgraph "Domain Layer"
        SV["Services"]
        MD["Models"]
    end

    subgraph "Data Layer"
        AC["API Client (Dio)"]
        HV["Hive Local DB"]
        SS["Secure Storage"]
    end

    SC --> PR
    SC --> WG
    PR --> NT
    NT --> SV
    SV --> AC & HV
    SV --> MD
    AC -->|HTTP| REMOTE["Laravel API"]
    SS -->|Auth Tokens| AC
```

### Backend (Laravel)

```mermaid
graph TB
    subgraph "HTTP Layer"
        MW["Middleware<br>(Auth, RateLimit, CORS)"]
        CT["Controllers<br>(thin, validation only)"]
        FR["Form Requests<br>(validation rules)"]
    end

    subgraph "Business Logic"
        SV["Services<br>(WalletService, etc.)"]
        EV["Events & Listeners"]
        JB["Jobs & Queues"]
    end

    subgraph "Data Access"
        EL["Eloquent Models"]
        DB[("PostgreSQL")]
    end

    MW --> CT
    CT --> FR
    CT --> SV
    SV --> EL
    SV --> EV
    EV --> JB
    EL --> DB
    JB -->|Async| SMS["SMS"] & FCM["Push"] & EMAIL["Email"]
```

## 3. Data Flow: Send Money (P2P)

```mermaid
sequenceDiagram
    participant U as Flutter App
    participant A as Laravel API
    participant W as WalletService
    participant D as PostgreSQL

    U->>A: POST /api/v1/wallet/send-money<br>{receiver_phone, amount, pin}
    A->>A: Validate (FormRequest)
    A->>A: Verify transaction PIN
    A->>W: sendMoney(sender, receiver, amount)
    W->>D: BEGIN TRANSACTION
    W->>D: SELECT wallets WHERE user_id=sender FOR UPDATE
    W->>D: SELECT wallets WHERE user_id=receiver FOR UPDATE
    W->>D: Check sender.balance >= amount
    alt Insufficient Balance
        W->>D: ROLLBACK
        W->>A: throw InsufficientBalanceException
        A->>U: 400 {success: false, error: INSUFFICIENT_BALANCE}
    else Sufficient Balance
        W->>D: UPDATE sender.balance -= amount
        W->>D: UPDATE receiver.balance += amount
        W->>D: INSERT INTO transactions (type=P2P, ...)
        W->>D: INSERT INTO transaction_logs (...)
        W->>D: COMMIT
        W->>A: return Transaction
        A->>U: 200 {success: true, data: {transaction}}
    end
    A-->>A: Dispatch NotifyUserJob (async)
```

## 4. Deployment Architecture

```mermaid
graph LR
    subgraph "Production"
        LB["Nginx<br>Reverse Proxy + SSL"]
        APP["Laravel App<br>(PHP-FPM)"]
        ADMIN["React Admin<br>(Static Files)"]
        DB[("PostgreSQL")]
        REDIS[("Redis")]
        R2["Cloudflare R2"]
    end

    USER["📱 Mobile User"] -->|HTTPS| LB
    BROWSER["💻 Admin User"] -->|HTTPS| LB
    LB -->|/api/*| APP
    LB -->|/admin/*| ADMIN
    APP --> DB & REDIS & R2
```
