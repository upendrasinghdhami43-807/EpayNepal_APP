# EpayNepal — API Reference

> This document will be populated as endpoints are built in Phase 6.

## Base URL

- **Development:** `http://localhost:8000/api/v1`
- **Production:** `https://api.epaynepal.com/api/v1`

## Authentication

All authenticated endpoints require a Bearer token in the Authorization header:
```
Authorization: Bearer {sanctum_token}
```

## Response Format

```json
{
  "success": true,
  "data": { ... },
  "message": "Operation successful"
}
```

## Endpoint Summary

See `architecture/api_routes.md` for the complete endpoint specification.

_Detailed request/response documentation for each endpoint will be added in Phase 6._
