# EpayNepal — Software Requirements Specification (SRS)

**Version:** 1.0  
**Date:** July 30, 2026  
**Author:** Upendra Singh Dhami  
**Project Type:** College Capstone Project

---

## 1. Project Vision & Problem Statement

### Problem
In Nepal, digital payment adoption is growing but many users — especially students — face fragmented payment experiences. Multiple apps are needed for different services, and existing solutions often lack intuitive UX or comprehensive bill payment coverage.

### Vision
**EpayNepal** is a unified digital wallet platform that enables users to manage their finances, transfer money peer-to-peer, pay merchants via QR codes, settle utility bills, and complete KYC verification — all from a single mobile app. An admin panel provides operational oversight including user management, KYC review, and transaction monitoring.

### Scope
- Mobile wallet app (Flutter) for end users
- RESTful API backend (Laravel) for all business logic
- Admin dashboard (React) for operations team
- PostgreSQL database for persistent storage
- Integration with Nepali payment/SMS providers

---

## 2. Target Users & Use Cases

### Primary Users
| User Segment | Description |
|-------------|-------------|
| Students | College students needing affordable, fast digital payments |
| General Public | Nepali citizens wanting convenient mobile wallet services |
| Merchants | Small/medium businesses accepting digital payments |
| Administrators | Operations team managing the platform |

### Key Use Cases
1. **UC-01:** User registers with phone number and verifies via OTP
2. **UC-02:** User logs in with password + optional biometric
3. **UC-03:** User tops up wallet from linked bank account
4. **UC-04:** User sends money to another user (P2P transfer)
5. **UC-05:** User scans merchant QR code and pays
6. **UC-06:** User pays electricity/internet/water bill
7. **UC-07:** User recharges mobile phone
8. **UC-08:** User submits KYC documents for verification
9. **UC-09:** Admin reviews and approves/rejects KYC submission
10. **UC-10:** Admin monitors transactions and flags suspicious activity
11. **UC-11:** User receives push notification for transaction updates
12. **UC-12:** User generates personal QR for receiving payments

---

## 3. Functional Requirements

### 3.1 Authentication & User Management
| ID | Requirement |
|----|------------|
| FR-01 | Phone number registration with OTP verification |
| FR-02 | Password-based login with Sanctum token |
| FR-03 | Transaction PIN (separate from password) |
| FR-04 | Biometric authentication (fingerprint/face) |
| FR-05 | Forgot/reset password flow |
| FR-06 | Device registration and management |
| FR-07 | Session management with token expiry |

### 3.2 Wallet Operations
| ID | Requirement |
|----|------------|
| FR-08 | View wallet balance |
| FR-09 | Top-up wallet from bank account |
| FR-10 | Withdraw to bank account |
| FR-11 | P2P money transfer (send/receive) |
| FR-12 | Request money from another user |
| FR-13 | Transaction history with filters |
| FR-14 | Transaction receipt/detail view |

### 3.3 QR Payments
| ID | Requirement |
|----|------------|
| FR-15 | Scan QR code to initiate payment |
| FR-16 | Generate personal payment QR |
| FR-17 | Merchant QR code generation |
| FR-18 | QR payment confirmation with PIN |

### 3.4 Bill Payments & Services
| ID | Requirement |
|----|------------|
| FR-19 | Mobile recharge (prepaid/postpaid) |
| FR-20 | Electricity bill payment (NEA) |
| FR-21 | Internet bill payment |
| FR-22 | Water bill payment |
| FR-23 | Cable TV bill payment |
| FR-24 | Government payment |
| FR-25 | Education fee payment |
| FR-26 | Traffic fine payment |

### 3.5 KYC Verification
| ID | Requirement |
|----|------------|
| FR-27 | Upload citizenship document (front/back) |
| FR-28 | Selfie capture for identity verification |
| FR-29 | Address details submission |
| FR-30 | KYC status tracking (pending/approved/rejected) |

### 3.6 Banking
| ID | Requirement |
|----|------------|
| FR-31 | View linked bank accounts |
| FR-32 | Link new bank account |
| FR-33 | Transfer to bank account |

### 3.7 Notifications
| ID | Requirement |
|----|------------|
| FR-34 | Push notifications via FCM |
| FR-35 | In-app notification center |
| FR-36 | SMS notifications for critical events |

### 3.8 Support
| ID | Requirement |
|----|------------|
| FR-37 | FAQ section |
| FR-38 | Contact us form |
| FR-39 | Support ticket creation and tracking |
| FR-40 | Live chat UI |

### 3.9 Admin Panel
| ID | Requirement |
|----|------------|
| FR-41 | Admin authentication (separate guard) |
| FR-42 | Dashboard with KPI cards |
| FR-43 | User list with search/filter/pagination |
| FR-44 | KYC review queue with approve/reject |
| FR-45 | Transaction monitoring with export |
| FR-46 | Merchant management |
| FR-47 | Support ticket management |
| FR-48 | Push notification broadcasting |
| FR-49 | Reports & analytics with charts |
| FR-50 | Audit logs |
| FR-51 | Role & permission management |
| FR-52 | App configuration settings |

---

## 4. Non-Functional Requirements

| ID | Category | Requirement |
|----|----------|------------|
| NFR-01 | Performance | API response time < 500ms for 95th percentile |
| NFR-02 | Performance | App launch to home screen < 3 seconds |
| NFR-03 | Security | All passwords hashed (bcrypt/argon2) |
| NFR-04 | Security | HTTPS for all API communication |
| NFR-05 | Security | Rate limiting on sensitive endpoints |
| NFR-06 | Security | Input validation on client AND server |
| NFR-07 | Reliability | Money operations use DB transactions with row locking |
| NFR-08 | Reliability | No double-spend on concurrent transfers |
| NFR-09 | Scalability | Database indexed on frequently-queried columns |
| NFR-10 | Usability | Support English and Nepali languages |
| NFR-11 | Usability | Light and dark mode support |
| NFR-12 | Usability | Responsive across phone screen sizes |
| NFR-13 | Maintainability | SOLID principles, small single-responsibility files |
| NFR-14 | Testability | Unit tests for wallet service, integration tests for key flows |

---

## 5. User Roles & Permissions

| Role | Permissions |
|------|-----------|
| **Guest** | View app info, register |
| **User** | Basic wallet (limited to NPR 25,000 balance, NPR 10,000/transfer) |
| **Verified User** | Full wallet (NPR 100,000 balance, NPR 50,000/transfer after KYC) |
| **Merchant** | Accept payments, merchant QR, settlement reports |
| **Support Agent** | View/reply support tickets, view user info (read-only) |
| **KYC Officer** | Review KYC queue, approve/reject with reason |
| **Admin** | All operations except system config |
| **Super Admin** | System configuration, role management, fee rules |

---

## 6. Feature List (Complete)

### Mobile App Features
1. Splash screen with auto-auth check
2. Multi-step onboarding flow
3. Phone registration with OTP
4. Login with password
5. Create/verify transaction PIN
6. Biometric setup
7. Home dashboard with balance, quick actions, recent transactions
8. Wallet overview with balance history
9. Top-up from bank
10. Withdraw to bank
11. Send money (P2P)
12. Receive money (QR display)
13. Request money
14. QR scan camera
15. QR payment confirmation
16. Mobile recharge
17. Electricity bill
18. Internet bill
19. Water bill
20. Cable TV bill
21. Government payment
22. Education fee
23. Traffic fine
24. Flight booking
25. KYC document upload
26. KYC selfie
27. KYC status tracking
28. Transaction history with filters
29. Transaction detail/receipt
30. Profile management
31. Security settings
32. App settings (theme, language)
33. Notification center
34. Support/FAQ
35. Contact us
36. Dark mode

### Admin Panel Features
1. Admin login
2. Dashboard with KPIs
3. User management (list, detail, freeze/unfreeze)
4. Wallet management (view/adjust with audit)
5. Transaction monitoring (list, detail, export)
6. KYC review queue
7. Merchant management
8. Support tickets
9. Notification broadcasting
10. Banner/promo management
11. Reports & analytics
12. Audit logs
13. Roles & permissions
14. App settings/config
15. System health dashboard

---

## 7. Tech Stack Rationale

| Choice | Rationale |
|--------|----------|
| **Flutter** | Single codebase for Android/iOS, rich widget system, strong typing with Dart |
| **Riverpod** | Compile-safe, testable, no BuildContext dependency for state |
| **go_router** | Declarative routing, deep link support, type-safe parameters |
| **Laravel 12** | Mature PHP framework, excellent ORM, built-in auth (Sanctum), queue system |
| **PostgreSQL** | ACID compliance critical for financial transactions, row-level locking support |
| **React + Vite** | Fast DX, TypeScript support, rich ecosystem for admin dashboards |
| **Tailwind CSS** | Rapid UI development for admin panel, consistent design tokens |
| **Cloudflare R2** | S3-compatible, no egress fees, good for KYC document storage |
| **Firebase FCM** | Free push notifications, cross-platform, reliable delivery |

---

## 8. Success Criteria

1. All 18 phases completed with 100% checklist items verified
2. Full user journey works end-to-end: register → verify → top up → send money → pay merchant
3. Admin can review KYC, monitor transactions, manage users
4. No critical/high severity bugs in `progress/bugs.md`
5. Race-condition test proves no double-spend on concurrent transfers
6. Documentation complete enough for someone to clone and run from `docs/` alone
7. Project presentable for college defense/demo

---

## 9. Risk Analysis

| Risk | Impact | Probability | Mitigation |
|------|--------|------------|-----------|
| Database race conditions | Critical | Medium | Row-level locking, comprehensive tests |
| Scope creep | High | High | Strict phase-by-phase execution, defer to improvements.md |
| SMS provider integration issues | Medium | Medium | Simulated OTP for demo mode |
| File storage complexity | Medium | Low | Local disk in dev, R2 in production |
| Cross-platform Flutter bugs | Medium | Medium | Test on multiple devices, responsive design |
| Time constraints | High | Medium | Focus on critical path features first |

---

## 10. Constraints

- College capstone project timeline
- No real banking API integration (mock providers)
- SMS via Sparrow SMS or simulated
- Single developer (with AI assistance)
- Budget: minimal (free tier services where possible)
