# 🏦 EpayNepal — Digital Wallet Platform

<p align="center">
  <strong>A complete digital wallet ecosystem for Nepal</strong><br>
  Mobile App · Backend API · Admin Dashboard
</p>

---

## Overview

**EpayNepal** is a full-stack digital wallet platform designed for students and the general public in Nepal. It enables peer-to-peer money transfers, QR-based merchant payments, utility bill payments, KYC-verified accounts, and administrative operations — all built as a college capstone project demonstrating real fintech software engineering.

## Features

| Category | Capabilities |
|----------|-------------|
| **Wallet** | Top-up, withdraw, balance inquiry, transaction history |
| **Transfers** | P2P send/receive money, request money, bank transfer |
| **QR Payments** | Scan to pay, generate personal/merchant QR codes |
| **Bill Payments** | Electricity, internet, water, mobile recharge, government fees, education fees |
| **Travel** | Airlines, hotels, bus tickets, movies |
| **KYC** | Document upload, selfie verification, status tracking |
| **Security** | OTP login, transaction PIN, biometric auth, device binding |
| **Admin** | User management, KYC review, transaction monitoring, analytics |

## Tech Stack

| Layer | Technology |
|-------|-----------|
| Mobile App | Flutter (Dart), Riverpod, go_router |
| Backend API | Laravel 12, PHP 8.2+, Sanctum |
| Database | PostgreSQL |
| Admin Panel | React + Vite + TypeScript + Tailwind |
| File Storage | Cloudflare R2 / Supabase Storage (local disk in dev) |
| Notifications | Firebase Cloud Messaging |
| OTP/SMS | Sparrow SMS (Nepal) or simulated OTP for demo |

## Repository Structure

```
EpayNepal/
├── lib/                        # Flutter mobile app source
│   ├── app/                    # Router, shell navigation
│   ├── core/                   # Theme, constants, services, widgets
│   └── features/               # Feature modules (auth, home, wallet, etc.)
├── android/                    # Android platform
├── ios/                        # iOS platform
├── backend/                    # Laravel API (Phase 6+)
├── admin/                      # React admin panel (Phase 4+)
├── database/                   # SQL dumps, ER diagrams
├── docs/                       # Installation, deployment, API reference
├── progress/                   # Phase tracking, daily logs, bugs
├── architecture/               # System design, API design, ER diagrams
├── stitch_esewa_jetpack_wallet_app/  # Stitch design exports
├── SRS.md                      # Software Requirements Specification
├── ROADMAP.md                  # 18-phase development roadmap
└── PROJECT_RULES.md            # Coding standards & conventions
```

## Getting Started

### Prerequisites

- Flutter SDK (stable channel, ≥3.12)
- Dart SDK (included with Flutter)
- Android Studio or Xcode (for platform targets)
- Git

### Run the Mobile App

```bash
flutter pub get
flutter run
```

### Useful Commands

```bash
flutter analyze       # Static analysis
flutter test          # Run tests
flutter build apk     # Build Android APK
```

> **Note:** The backend (Laravel) and admin panel (React) are developed in later phases. See `docs/INSTALLATION.md` for full setup instructions.

## Development Roadmap

| Phase | Name | Status |
|-------|------|--------|
| 0 | Project Foundation & Planning | 🟩 Complete |
| 1 | Software Architecture & System Design | 🟩 Complete |
| 2 | UI/UX Design | 🟩 Complete |
| 3 | Flutter Mobile UI | 🟨 In Progress |
| 4 | Admin Dashboard UI | ⬜ Not Started |
| 5 | Backend Planning | ⬜ Not Started |
| 6 | Laravel Backend Development | ⬜ Not Started |
| 7 | Database Design | ⬜ Not Started |
| 8 | Authentication & Security | ⬜ Not Started |
| 9 | File Storage & External Services | ⬜ Not Started |
| 10 | Integration | ⬜ Not Started |
| 11 | API Testing | ⬜ Not Started |
| 12 | Flutter Integration | ⬜ Not Started |
| 13 | Admin Integration | ⬜ Not Started |
| 14 | Testing & QA | ⬜ Not Started |
| 15 | Optimization | ⬜ Not Started |
| 16 | Deployment | ⬜ Not Started |
| 17 | Documentation & Final Presentation | ⬜ Not Started |

See `progress/overall_progress.md` for detailed completion percentages.

## Target Users

- **Students** in Nepal looking for a convenient digital payment solution
- **General public** who want to send money, pay bills, and pay merchants via QR
- **Merchants** who want to accept digital payments

## User Roles

| Role | Access Level |
|------|-------------|
| Guest | View app info, register |
| User | Basic wallet operations (limited amounts) |
| Verified User | Full wallet operations (KYC verified) |
| Merchant | Accept payments, generate merchant QR |
| Support Agent | Handle support tickets |
| KYC Officer | Review/approve KYC submissions |
| Admin | Full system management |
| Super Admin | System configuration, role management |

## Documentation

- [Installation Guide](docs/INSTALLATION.md)
- [Running the Project](docs/RUN_PROJECT.md)
- [API Reference](docs/API_REFERENCE.md)
- [Testing Guide](docs/TESTING.md)
- [Deployment Guide](docs/DEPLOYMENT.md)
- [Software Requirements Specification](SRS.md)
- [Development Roadmap](ROADMAP.md)
- [Project Rules & Standards](PROJECT_RULES.md)

## Architecture

See the `architecture/` directory for:
- [System Design](architecture/system_design.md)
- [API Design](architecture/api_design.md)
- [API Routes](architecture/api_routes.md)
- [ER Diagram](architecture/er_diagram.md)
- [Database Tables](architecture/database_tables.md)
- [Security Architecture](architecture/security.md)
- [Workflow Diagrams](architecture/workflow.md)
- [Design System](architecture/design_system.md)

## License

This project is a college capstone project and is not licensed for commercial use.

## Author

**Upendra Singh Dhami**
College Capstone Project — EpayNepal Digital Wallet Platform
