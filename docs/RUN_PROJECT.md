# EpayNepal — Running the Project

## Quick Start

### Mobile App (Flutter)
```bash
# From project root
flutter pub get
flutter run
```

### Backend API (Laravel) — Available from Phase 6
```bash
cd backend
php artisan serve
# API available at http://localhost:8000
```

### Admin Panel (React) — Available from Phase 4
```bash
cd admin
npm run dev
# Panel available at http://localhost:5173
```

## Development Workflow

1. Start the backend server first (Phase 6+)
2. Start the admin panel if needed (Phase 4+)
3. Run the Flutter app on your device/emulator

## Common Commands

| Command | Purpose |
|---------|---------|
| `flutter analyze` | Run static analysis |
| `flutter test` | Run Flutter tests |
| `flutter build apk` | Build Android APK |
| `php artisan test` | Run Laravel tests |
| `npm run build` | Build admin panel |

## Troubleshooting

- **Flutter pub get fails:** Run `flutter clean` then retry
- **Android build fails:** Check `flutter doctor` for missing SDK components
- **Laravel serve fails:** Ensure PHP ≥ 8.2 and all extensions installed
