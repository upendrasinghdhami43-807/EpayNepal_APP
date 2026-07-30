# EpayNepal — API Design

## 1. Principles

- **RESTful** — Resources as nouns, HTTP methods as verbs
- **Versioned** — All routes under `/api/v1/`
- **Authenticated** — Laravel Sanctum Bearer tokens
- **Consistent** — Standard JSON response format on every endpoint
- **Paginated** — All list endpoints support `?page=N&per_page=M`

## 2. Base URL

| Environment | URL |
|------------|-----|
| Development | `http://localhost:8000/api/v1` |
| Production | `https://api.epaynepal.com/api/v1` |

## 3. Authentication

### Token Lifecycle

1. **Register** → `POST /auth/register` → returns user (no token yet)
2. **Verify OTP** → `POST /auth/verify-otp` → confirms phone ownership
3. **Login** → `POST /auth/login` → returns Sanctum Bearer token
4. **Use token** → `Authorization: Bearer {token}` on all authenticated requests
5. **Logout** → `POST /auth/logout` → revokes current token
6. **Token expiry** → Configurable (default: 30 days)

### Transaction PIN
Separate from login password. Required for:
- Send money
- Withdraw
- QR payment confirmation
- Changing security settings

Verified via `POST /auth/verify-pin` or inline in the transaction request body.

## 4. Response Format

### Success
```json
{
  "success": true,
  "data": { ... },
  "message": "Operation completed successfully",
  "meta": {
    "current_page": 1,
    "per_page": 20,
    "total": 150,
    "last_page": 8
  }
}
```

### Error
```json
{
  "success": false,
  "error": {
    "code": "INSUFFICIENT_BALANCE",
    "message": "Your wallet balance is insufficient for this transaction",
    "details": {}
  }
}
```

### Error Codes
| Code | HTTP Status | Meaning |
|------|-----------|---------|
| `VALIDATION_ERROR` | 422 | Input validation failed |
| `UNAUTHORIZED` | 401 | Missing or invalid token |
| `FORBIDDEN` | 403 | Insufficient permissions |
| `NOT_FOUND` | 404 | Resource not found |
| `INSUFFICIENT_BALANCE` | 400 | Wallet balance too low |
| `INVALID_PIN` | 400 | Transaction PIN incorrect |
| `OTP_EXPIRED` | 400 | OTP code has expired |
| `OTP_INVALID` | 400 | OTP code is incorrect |
| `ACCOUNT_FROZEN` | 403 | Account has been frozen |
| `RATE_LIMITED` | 429 | Too many requests |
| `KYC_REQUIRED` | 403 | KYC verification needed |
| `DUPLICATE_TRANSACTION` | 409 | Transaction already processed |
| `SERVER_ERROR` | 500 | Internal server error |

## 5. Rate Limiting

| Endpoint Group | Limit | Window |
|---------------|-------|--------|
| Auth (login/register) | 5 requests | per minute |
| OTP requests | 3 requests | per 5 minutes |
| Money transfers | 10 requests | per minute |
| General API | 60 requests | per minute |

## 6. Pagination

All list endpoints accept:
- `page` — Page number (default: 1)
- `per_page` — Items per page (default: 20, max: 100)

Response includes `meta` object with pagination info.

## 7. Filtering & Sorting

List endpoints support:
- `?status=completed` — Filter by status
- `?type=P2P` — Filter by type
- `?from=2026-01-01&to=2026-12-31` — Date range
- `?sort=created_at&order=desc` — Sorting
- `?search=keyword` — Full-text search where applicable

## 8. File Uploads

- Max file size: 5MB
- Allowed types: `image/jpeg`, `image/png`, `application/pdf`
- Upload via `multipart/form-data`
- Files stored in Cloudflare R2 (production) or local disk (development)
- Access via signed URLs with 1-hour expiry
