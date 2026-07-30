# Phase 6: Laravel Backend Development

**Framework/Tools used:** Laravel 12, PHP 8.2+, Sanctum
**Folder:** `backend/`
**Status:** 0% complete (0/30 tasks)
**Last updated:** July 30, 2026

---

## Full Task Checklist

### Setup
- [ ] Laravel 12 project created in backend/ → false
- [ ] Sanctum installed & configured → false
- [ ] app/Services/, app/Http/Requests/, app/Http/Controllers/Api/ structure → false
- [ ] .env.example complete → false

### Auth Module
- [ ] Register (phone + password) → false
- [ ] OTP generation & verification → false
- [ ] Login (Sanctum token) → false
- [ ] Logout (token revoke) → false
- [ ] Forgot/reset password → false
- [ ] Transaction PIN set/verify → false
- [ ] Rate limiting on auth endpoints → false

### User Module
- [ ] Profile get/update → false
- [ ] Device registration (FCM) → false

### Wallet Module
- [ ] WalletService with DB::transaction() + lockForUpdate() → false
- [ ] Get wallet balance endpoint → false
- [ ] Top-up endpoint → false
- [ ] Withdraw endpoint → false

### Transaction Module
- [ ] Send money (P2P) endpoint → false
- [ ] Transaction history endpoint → false
- [ ] Transaction detail endpoint → false

### QR Module
- [ ] Generate QR payload → false
- [ ] Resolve QR endpoint → false
- [ ] Confirm QR payment → false

### Other Modules
- [ ] Bill payment endpoints (mock) → false
- [ ] KYC upload/status/review endpoints → false
- [ ] Merchant registration/QR → false
- [ ] Notification storage/retrieval → false
- [ ] Admin auth & management endpoints → false

### Cross-cutting
- [ ] Consistent JSON response format → false
- [ ] Centralized exception handler → false
