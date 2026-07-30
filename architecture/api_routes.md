# EpayNepal — API Routes

All routes prefixed with `/api/v1/`.  
🔒 = Requires Bearer token | 🔑 = Requires admin auth | 📌 = Requires PIN

---

## Authentication

| Method | Route | Description | Auth |
|--------|-------|------------|------|
| POST | `/auth/register` | Register with phone + password | — |
| POST | `/auth/verify-otp` | Verify phone OTP | — |
| POST | `/auth/resend-otp` | Resend OTP code | — |
| POST | `/auth/login` | Login, get Sanctum token | — |
| POST | `/auth/logout` | Revoke token | 🔒 |
| POST | `/auth/forgot-password` | Request password reset OTP | — |
| POST | `/auth/reset-password` | Reset password with OTP | — |
| POST | `/auth/set-pin` | Set transaction PIN | 🔒 |
| POST | `/auth/verify-pin` | Verify transaction PIN | 🔒 |
| POST | `/auth/change-password` | Change login password | 🔒 |
| POST | `/auth/change-pin` | Change transaction PIN | 🔒📌 |

## User Profile

| Method | Route | Description | Auth |
|--------|-------|------------|------|
| GET | `/user/profile` | Get current user profile | 🔒 |
| PUT | `/user/profile` | Update profile info | 🔒 |
| POST | `/user/profile-photo` | Upload profile photo | 🔒 |
| GET | `/user/devices` | List registered devices | 🔒 |
| POST | `/user/devices` | Register new device (FCM token) | 🔒 |
| DELETE | `/user/devices/{id}` | Remove device | 🔒 |

## Wallet

| Method | Route | Description | Auth |
|--------|-------|------------|------|
| GET | `/wallet/balance` | Get wallet balance | 🔒 |
| POST | `/wallet/top-up` | Add money to wallet | 🔒📌 |
| POST | `/wallet/withdraw` | Withdraw to bank | 🔒📌 |
| POST | `/wallet/send-money` | P2P transfer | 🔒📌 |
| POST | `/wallet/request-money` | Request money from user | 🔒 |
| GET | `/wallet/requests` | List pending money requests | 🔒 |
| POST | `/wallet/requests/{id}/accept` | Accept money request | 🔒📌 |
| POST | `/wallet/requests/{id}/reject` | Reject money request | 🔒 |

## Transactions

| Method | Route | Description | Auth |
|--------|-------|------------|------|
| GET | `/transactions` | List transactions (paginated, filterable) | 🔒 |
| GET | `/transactions/{id}` | Transaction detail | 🔒 |
| GET | `/transactions/{id}/receipt` | Download receipt PDF | 🔒 |

## QR Payments

| Method | Route | Description | Auth |
|--------|-------|------------|------|
| GET | `/qr/my-code` | Get personal payment QR payload | 🔒 |
| POST | `/qr/resolve` | Resolve scanned QR to payment info | 🔒 |
| POST | `/qr/pay` | Confirm QR payment | 🔒📌 |

## Bill Payments

| Method | Route | Description | Auth |
|--------|-------|------------|------|
| POST | `/bills/mobile-recharge` | Mobile recharge | 🔒📌 |
| POST | `/bills/electricity` | Pay electricity bill | 🔒📌 |
| POST | `/bills/internet` | Pay internet bill | 🔒📌 |
| POST | `/bills/water` | Pay water bill | 🔒📌 |
| POST | `/bills/cable-tv` | Pay cable TV bill | 🔒📌 |
| POST | `/bills/government` | Government payment | 🔒📌 |
| POST | `/bills/education` | Education fee payment | 🔒📌 |
| POST | `/bills/traffic-fine` | Traffic fine payment | 🔒📌 |

## KYC

| Method | Route | Description | Auth |
|--------|-------|------------|------|
| GET | `/kyc/status` | Get KYC status | 🔒 |
| POST | `/kyc/submit` | Submit KYC documents | 🔒 |
| POST | `/kyc/upload-document` | Upload citizenship photo | 🔒 |
| POST | `/kyc/upload-selfie` | Upload selfie | 🔒 |

## Banking

| Method | Route | Description | Auth |
|--------|-------|------------|------|
| GET | `/banks` | List linked bank accounts | 🔒 |
| POST | `/banks/link` | Link new bank account | 🔒 |
| DELETE | `/banks/{id}` | Unlink bank account | 🔒 |
| POST | `/banks/transfer` | Transfer to bank | 🔒📌 |

## Merchants

| Method | Route | Description | Auth |
|--------|-------|------------|------|
| GET | `/merchants/{id}` | Get merchant info | 🔒 |
| GET | `/merchants/{id}/qr` | Get merchant QR | 🔒 |

## Notifications

| Method | Route | Description | Auth |
|--------|-------|------------|------|
| GET | `/notifications` | List notifications | 🔒 |
| PUT | `/notifications/{id}/read` | Mark as read | 🔒 |
| PUT | `/notifications/read-all` | Mark all as read | 🔒 |

## Support

| Method | Route | Description | Auth |
|--------|-------|------------|------|
| GET | `/support/faq` | Get FAQ list | — |
| POST | `/support/tickets` | Create support ticket | 🔒 |
| GET | `/support/tickets` | List user's tickets | 🔒 |
| GET | `/support/tickets/{id}` | Ticket detail with messages | 🔒 |
| POST | `/support/tickets/{id}/reply` | Reply to ticket | 🔒 |

---

## Admin Routes

All prefixed with `/api/v1/admin/`. Requires admin auth (🔑).

| Method | Route | Description |
|--------|-------|------------|
| POST | `/admin/auth/login` | Admin login |
| POST | `/admin/auth/logout` | Admin logout |
| GET | `/admin/dashboard` | Dashboard KPIs |
| GET | `/admin/users` | User list (search, filter, paginate) |
| GET | `/admin/users/{id}` | User detail |
| PUT | `/admin/users/{id}/freeze` | Freeze account |
| PUT | `/admin/users/{id}/unfreeze` | Unfreeze account |
| GET | `/admin/wallets/{userId}` | View user wallet |
| POST | `/admin/wallets/{userId}/adjust` | Adjust balance (audit logged) |
| GET | `/admin/transactions` | All transactions (filter, export) |
| GET | `/admin/transactions/{id}` | Transaction detail |
| GET | `/admin/kyc` | KYC review queue |
| GET | `/admin/kyc/{id}` | KYC detail with documents |
| PUT | `/admin/kyc/{id}/approve` | Approve KYC |
| PUT | `/admin/kyc/{id}/reject` | Reject KYC with reason |
| GET | `/admin/merchants` | Merchant list |
| POST | `/admin/merchants` | Add merchant |
| PUT | `/admin/merchants/{id}` | Edit merchant |
| GET | `/admin/support/tickets` | All support tickets |
| POST | `/admin/support/tickets/{id}/reply` | Reply to ticket |
| POST | `/admin/notifications/send` | Send push to users/segments |
| GET | `/admin/reports/daily` | Daily report |
| GET | `/admin/reports/transactions` | Transaction analytics |
| GET | `/admin/reports/users` | User growth analytics |
| GET | `/admin/audit-logs` | Audit log list |
| GET | `/admin/roles` | Role list |
| POST | `/admin/roles` | Create role |
| PUT | `/admin/roles/{id}` | Update role |
| GET | `/admin/settings` | App settings |
| PUT | `/admin/settings` | Update settings |

**Total: ~70 endpoints**
