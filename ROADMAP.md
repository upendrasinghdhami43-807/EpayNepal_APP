# EpayNepal — Development Roadmap (18 Phases)

**Version:** 1.0 | **Last Updated:** July 30, 2026

---

## Timeline Overview

| Phase | Name | Duration | Dependencies | Status |
|-------|------|----------|-------------|--------|
| 0 | Project Foundation & Planning | 1 day | None | 🟩 Complete |
| 1 | Software Architecture & System Design | 1 day | Phase 0 | 🟩 Complete |
| 2 | UI/UX Design | 1 day | Phase 1 | 🟩 Complete |
| 3 | Flutter Mobile UI | 5–7 days | Phase 2 | 🟨 In Progress |
| 4 | Admin Dashboard UI | 3–4 days | Phase 2 | ⬜ Not Started |
| 5 | Backend Planning | 1 day | Phase 1 | ⬜ Not Started |
| 6 | Laravel Backend Development | 7–10 days | Phase 5, 7 | ⬜ Not Started |
| 7 | Database Design | 2–3 days | Phase 1 | ⬜ Not Started |
| 8 | Authentication & Security | 3–4 days | Phase 6 | ⬜ Not Started |
| 9 | File Storage & External Services | 2–3 days | Phase 6 | ⬜ Not Started |
| 10 | Integration | 3–4 days | Phase 6, 7 | ⬜ Not Started |
| 11 | API Testing | 2–3 days | Phase 6 | ⬜ Not Started |
| 12 | Flutter Integration | 3–4 days | Phase 10 | ⬜ Not Started |
| 13 | Admin Integration | 2–3 days | Phase 10 | ⬜ Not Started |
| 14 | Testing & QA | 3–4 days | Phase 12, 13 | ⬜ Not Started |
| 15 | Optimization | 2–3 days | Phase 14 | ⬜ Not Started |
| 16 | Deployment | 2–3 days | Phase 15 | ⬜ Not Started |
| 17 | Documentation & Final Presentation | 2–3 days | Phase 16 | ⬜ Not Started |

**Total estimated duration:** 6–8 weeks

---

## Phase Details

### Phase 0 — Project Foundation & Planning
**Purpose:** Define the project before writing code.

**Deliverables:**
- Project Vision & Problem Statement
- Functional & Non-Functional Requirements
- User Roles & User Stories
- Feature List
- Tech Stack Selection & Rationale
- Folder Structure & Git Strategy
- Risk Analysis & Success Criteria

**Output:** `README.md`, `SRS.md`, `ROADMAP.md`, `PROJECT_RULES.md`

---

### Phase 1 — Software Architecture & System Design
**Purpose:** Design the complete system before building.

**Deliverables:**
- High-Level & Low-Level Architecture
- Mobile / Backend / Database / Admin Architecture
- Authentication, API, Wallet, QR, Notification, KYC Flows
- Deployment Architecture

**Output:** `architecture/system_design.md`, `api_design.md`, `api_routes.md`, `er_diagram.md`, `database_tables.md`, `security.md`, `workflow.md`, `ui_flow.md`, `flutter_navigation.md`, `admin_navigation.md`, `folder_structure.md`

---

### Phase 2 — UI/UX Design
**Purpose:** Define the visual design system and screen inventory.

**Deliverables:**
- Design System (colors, typography, spacing, components)
- Screen Inventory & Gap Analysis
- Stitch Design Asset Mapping

**Output:** `architecture/design_system.md`, updated `DESIGN_ASSET_MAP.md`

---

### Phase 3 — Flutter Mobile UI
**Purpose:** Convert designs into Flutter screens with navigation.

**Deliverables:** All screens built with mock data, go_router navigation, dark mode

---

### Phase 4 — Admin Dashboard UI
**Purpose:** Build React admin panel with mock data.

**Technology:** React + Vite + TypeScript + Tailwind + shadcn/ui

---

### Phase 5 — Backend Planning
**Purpose:** Plan Laravel modules, services, and API structure before coding.

---

### Phase 6 — Laravel Backend Development
**Purpose:** Build all API endpoints with business logic.

---

### Phase 7 — Database Design
**Purpose:** Create PostgreSQL schema with migrations and seeders.

---

### Phase 8 — Authentication & Security
**Purpose:** Implement auth flows, device binding, rate limiting.

---

### Phase 9 — File Storage & External Services
**Purpose:** Integrate Cloudflare R2, Firebase FCM, Sparrow SMS.

---

### Phase 10 — Integration
**Purpose:** Connect Flutter ↔ Laravel ↔ PostgreSQL and Admin ↔ Laravel.

---

### Phase 11 — API Testing
**Purpose:** Postman collection covering every endpoint.

---

### Phase 12 — Flutter Integration
**Purpose:** Replace all mock data with real API calls.

---

### Phase 13 — Admin Integration
**Purpose:** Replace admin mock data with real API calls.

---

### Phase 14 — Testing & QA
**Purpose:** Comprehensive testing across all layers.

---

### Phase 15 — Optimization
**Purpose:** Performance improvements across the stack.

---

### Phase 16 — Deployment
**Purpose:** Deploy to production environments.

---

### Phase 17 — Documentation & Final Presentation
**Purpose:** Complete all documentation and prepare for defense.

---

## Dependency Graph

```
Phase 0 → Phase 1 → Phase 2
                ↓
         Phase 3 (Flutter UI)
         Phase 4 (Admin UI)
         Phase 5 (Backend Plan) → Phase 7 (DB) → Phase 6 (Backend)
                                                       ↓
                                              Phase 8 (Auth/Security)
                                              Phase 9 (Storage/Services)
                                                       ↓
                                              Phase 10 (Integration)
                                                       ↓
                                    Phase 11 (API Test) + Phase 12 (Flutter) + Phase 13 (Admin)
                                                       ↓
                                              Phase 14 (Testing/QA)
                                                       ↓
                                              Phase 15 (Optimization)
                                                       ↓
                                              Phase 16 (Deployment)
                                                       ↓
                                              Phase 17 (Docs/Presentation)
```
