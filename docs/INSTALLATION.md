# EpayNepal — Installation Guide

## Prerequisites

| Tool | Version | Purpose |
|------|---------|---------|
| Flutter SDK | ≥ 3.12 (stable) | Mobile app development |
| Dart SDK | Included with Flutter | Language runtime |
| Android Studio | Latest | Android platform tools, emulator |
| Xcode | Latest (macOS only) | iOS platform tools |
| PHP | ≥ 8.2 | Laravel backend |
| Composer | Latest | PHP dependency manager |
| Node.js | ≥ 18 LTS | Admin panel |
| npm | Included with Node.js | Package manager |
| PostgreSQL | ≥ 15 | Database |
| Git | Latest | Version control |

## Mobile App Setup (Flutter)

```bash
# Clone the repository
git clone https://github.com/your-username/EpayNepal.git
cd EpayNepal

# Install Flutter dependencies
flutter pub get

# Verify setup
flutter doctor

# Run on connected device or emulator
flutter run
```

## Backend Setup (Laravel) — Phase 6+

```bash
cd backend

# Install PHP dependencies
composer install

# Copy environment file
cp .env.example .env

# Generate app key
php artisan key:generate

# Run migrations
php artisan migrate

# Seed demo data
php artisan db:seed

# Start development server
php artisan serve
```

## Admin Panel Setup (React) — Phase 4+

```bash
cd admin

# Install dependencies
npm install

# Copy environment file
cp .env.example .env

# Start development server
npm run dev
```

## Database Setup

```bash
# Create PostgreSQL database
createdb epaynepal

# Update backend/.env with database credentials
DB_CONNECTION=pgsql
DB_HOST=127.0.0.1
DB_PORT=5432
DB_DATABASE=epaynepal
DB_USERNAME=your_username
DB_PASSWORD=your_password
```

## Environment Variables

Each project has a `.env.example` file. Copy it to `.env` and fill in the required values before running.
