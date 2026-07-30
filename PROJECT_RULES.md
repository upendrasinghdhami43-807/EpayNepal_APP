# EpayNepal — Project Rules & Coding Standards

> These rules apply to every phase, every file, every session. Never deviate.

## 1. General Principles

- **SOLID principles**. Small, single-responsibility files. No 1000-line files.
- Business logic in **Service/Provider/Hook** layer, never in Controllers/Screens/Pages.
- Money operations **MUST** use database transactions with row-level locking.
- No hardcoded secrets — use `.env` files. Provide `.env.example`.
- Comment only where the *why* isn't obvious.

## 2. Flutter (Mobile App)

- **State:** Riverpod only
- **Navigation:** go_router only
- **Network:** Screens → services/ → network. Never direct.
- **Reusable UI** → `widgets/`. One-off → screen file.
- **Files:** snake_case. **Classes:** PascalCase.

## 3. Laravel (Backend API)

- **Controllers:** thin — validate, call Service, return response.
- **Validation:** Form Request classes only.
- **Auth:** Laravel Sanctum.
- **Async:** Jobs/Queues for SMS, email, notifications.
- **ORM:** Eloquent relationships. No raw SQL unless justified.
- **Routes:** kebab-case (`/api/v1/send-money`).

## 4. React (Admin Panel)

- TypeScript strict mode on.
- API calls through `api/` layer (Axios), never inline `fetch`.
- **Components:** PascalCase. **Hooks:** camelCase with `use` prefix.

## 5. Database

- Primary keys, foreign keys, indexes on frequently-queried columns.
- Money columns: `decimal(15,2)`, never float/double.
- Reversible migrations (`down()` implemented).
- Tables: snake_case plural. Columns: snake_case.

## 6. Error Handling

```json
{ "success": true, "data": {...}, "message": "..." }
{ "success": false, "error": { "code": "INSUFFICIENT_BALANCE", "message": "..." } }
```

- Centralized error handler in Flutter and React.
- No raw exceptions shown to users. All logged first.

## 7. Security (Non-Negotiable)

- Passwords: bcrypt/argon2, never plaintext/logged.
- Transaction PIN: separate hash from login password.
- HTTPS in production. Rate limiting on auth/OTP/transfers.
- Input validation on both client AND server.
- File uploads: validate type/size server-side, signed URLs.

## 8. Git Strategy

```
main → always deployable | develop → integration | feature/* → per task
```

Commit format: `[phase-X][component] description`

## 9. Progress Tracking

```
- [ ] Task → false    (not done)
- [x] Task → true     (verified complete)
```

Never mark true in advance. Partial work stays false with a note.
