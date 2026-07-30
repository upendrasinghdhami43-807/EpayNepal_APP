# EpayNepal — Database Tables Specification

All money columns use `decimal(15,2)`. All tables have `id` (bigint PK, auto-increment).

---

## 1. users

| Column | Type | Constraints | Notes |
|--------|------|------------|-------|
| id | bigint | PK, auto | |
| phone | varchar(15) | UNIQUE, NOT NULL | Primary identifier |
| email | varchar(255) | NULLABLE, UNIQUE | |
| name | varchar(100) | NOT NULL | |
| password_hash | varchar(255) | NOT NULL | bcrypt/argon2 |
| pin_hash | varchar(255) | NULLABLE | Transaction PIN, separate hash |
| profile_photo_url | varchar(500) | NULLABLE | R2/Supabase URL |
| status | enum | NOT NULL, DEFAULT 'active' | active, frozen, suspended |
| kyc_level | enum | NOT NULL, DEFAULT 'none' | none, pending, verified |
| balance_limit | decimal(15,2) | DEFAULT 25000.00 | Increases after KYC |
| transfer_limit | decimal(15,2) | DEFAULT 10000.00 | Increases after KYC |
| phone_verified_at | timestamp | NULLABLE | |
| email_verified_at | timestamp | NULLABLE | |
| created_at | timestamp | NOT NULL | |
| updated_at | timestamp | NOT NULL | |
| deleted_at | timestamp | NULLABLE | Soft delete |

**Indexes:** phone, email, status, kyc_level, created_at

---

## 2. wallets

| Column | Type | Constraints |
|--------|------|------------|
| id | bigint | PK |
| user_id | bigint | FK → users.id, UNIQUE |
| balance | decimal(15,2) | NOT NULL, DEFAULT 0.00 |
| currency | varchar(3) | NOT NULL, DEFAULT 'NPR' |
| is_active | boolean | NOT NULL, DEFAULT true |
| created_at | timestamp | |
| updated_at | timestamp | |

**Indexes:** user_id (unique)

---

## 3. transactions

| Column | Type | Constraints |
|--------|------|------------|
| id | bigint | PK |
| reference_id | varchar(30) | UNIQUE, NOT NULL |
| sender_wallet_id | bigint | FK → wallets.id, NULLABLE |
| receiver_wallet_id | bigint | FK → wallets.id, NULLABLE |
| type | enum | NOT NULL | P2P, TOP_UP, WITHDRAW, QR_PAY, BILL, RECHARGE |
| amount | decimal(15,2) | NOT NULL |
| fee | decimal(15,2) | DEFAULT 0.00 |
| status | enum | NOT NULL | pending, completed, failed, reversed |
| description | varchar(255) | NULLABLE |
| metadata | json | NULLABLE |
| created_at | timestamp | |
| updated_at | timestamp | |

**Indexes:** reference_id, sender_wallet_id, receiver_wallet_id, type, status, created_at

---

## 4. transaction_logs

| Column | Type | Constraints |
|--------|------|------------|
| id | bigint | PK |
| transaction_id | bigint | FK → transactions.id |
| wallet_id | bigint | FK → wallets.id |
| action | enum | credit, debit |
| amount | decimal(15,2) | NOT NULL |
| balance_before | decimal(15,2) | NOT NULL |
| balance_after | decimal(15,2) | NOT NULL |
| created_at | timestamp | |

**Indexes:** transaction_id, wallet_id, created_at

---

## 5. beneficiaries

| Column | Type | Constraints |
|--------|------|------------|
| id | bigint | PK |
| user_id | bigint | FK → users.id |
| name | varchar(100) | NOT NULL |
| phone | varchar(15) | NULLABLE |
| bank_account | varchar(30) | NULLABLE |
| type | enum | user, bank |
| created_at | timestamp | |
| updated_at | timestamp | |

**Indexes:** user_id

---

## 6. devices

| Column | Type | Constraints |
|--------|------|------------|
| id | bigint | PK |
| user_id | bigint | FK → users.id |
| device_name | varchar(100) | |
| device_id | varchar(255) | UNIQUE |
| fcm_token | varchar(500) | NULLABLE |
| platform | enum | android, ios |
| is_active | boolean | DEFAULT true |
| last_active_at | timestamp | NULLABLE |
| created_at | timestamp | |
| updated_at | timestamp | |

**Indexes:** user_id, device_id

---

## 7–21 (remaining tables follow the same pattern as defined in er_diagram.md)

See `architecture/er_diagram.md` for complete column definitions of:
- sessions, notifications, otp_codes, kyc_requests, merchants, merchant_qr
- support_tickets, support_messages, admin_users, roles, permissions
- audit_logs, app_settings, payment_requests, recharge_history, bill_payments
