# Boska — Barber Shop Booking App 💈

A Flutter mobile application that lets customers browse and book barber services online, with a dedicated admin dashboard for managing appointments in real time.

---

## Features

**Customer Side**
- Google Sign-In authentication
- Email & password sign-up / login with forgot-password flow
- Onboarding screen for first-time users
- Browse available barber services (Classic Shaving, Hair Washing, Hair Cutting, Beard Trimming, Facials, Kids Haircut)
- Pick a date and time, then book a service with one tap
- Booking confirmation via Firestore

**Admin Side**
- Separate admin login screen
- Real-time booking dashboard showing today's appointments (name, service, date, time, profile photo)
- Mark a booking as **Done** to remove it from the queue

---

## Tech Stack

| Layer | Technology |
|---|---|
| Framework | Flutter (Dart) |
| State Management | BLoC / Cubit (`flutter_bloc`) |
| Backend | Firebase (Auth + Firestore) |
| Auth Providers | Email/Password, Google Sign-In |
| Local Storage | `shared_preferences` |
| Functional Programming | `dartz` |
| Navigation | Custom router extension |

---

## Project Structure

```
lib/
├── main.dart                  # App entry point, BLoC providers, theme
├── bloc_observer.dart         # Global BLoC event observer
├── firebase_options.dart      # Firebase platform config (auto-generated)
├── core/
│   ├── helper/                # Extensions (navigation, etc.)
│   ├── router/                # Route definitions
│   ├── storage/
│   │   ├── database/          # Firestore CRUD (DatabaseMethods)
│   │   └── preference/        # SharedPreferences helper
│   └── widget/                # Shared UI widgets (common button, etc.)
└── feature/
    ├── splash/                # Splash screen
    ├── onboarding/            # First-launch onboarding
    ├── auth/
    │   ├── login/             # User login (email + Google)
    │   ├── sign_up/           # User registration
    │   ├── forgot_password/   # Password reset
    │   ├── admin_login/       # Admin-only login
    │   └── first_login/       # Auth state checker cubit
    ├── home/                  # Service listing screen
    ├── service/               # Service detail + booking screen
    └── dashboard/             # Admin bookings dashboard
```

---

## Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) ≥ 3.5.3
- Dart SDK ^3.5.3
- A Firebase project with **Authentication** and **Cloud Firestore** enabled

### 1 — Clone the repository

```bash
git clone https://github.com/YoussefElqursh/Boska.git
cd Boska
```

### 2 — Connect Firebase

1. Create a Firebase project at [console.firebase.google.com](https://console.firebase.google.com).
2. Enable **Email/Password** and **Google** sign-in providers under *Authentication → Sign-in method*.
3. Create a **Cloud Firestore** database.
4. Run the FlutterFire CLI to generate `firebase_options.dart`:

```bash
dart pub global activate flutterfire_cli
flutterfire configure
```

### 3 — Install dependencies

```bash
flutter pub get
```

### 4 — Run the app

```bash
# Debug on a connected device or emulator
flutter run

# Release build for Android
flutter build apk --release

# Release build for iOS
flutter build ios --release
```

---

## Firestore Data Model

### Collection: `Services`

Each document represents a single booking:

| Field | Type | Description |
|---|---|---|
| `User Name` | String | Customer's display name |
| `User Email` | String | Customer's email address |
| `User Image` | String | URL of customer's profile photo |
| `Service Name` | String | e.g. "Classic Shaving" |
| `Service Price` | Number | Price of the service |
| `Service Description` | String | Optional description |
| `Service Image` | String | Asset path for the service image |
| `Service Date` | String | Formatted as `d/M/yyyy` |
| `Service Time` | String | Formatted as `h:mm AM/PM` |

---

## Available Services

| Service | Icon |
|---|---|
| Classic Shaving | ✂️ |
| Hair Washing | 💧 |
| Hair Cutting | ✂️ |
| Beard Trimming | 🪒 |
| Facials | 🧖 |
| Kids Haircut | 👦 |

---

## Screenshots

> _Screenshots coming soon._

---

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you'd like to change.

---

## License

This project is open-source. See [LICENSE](LICENSE) for details.
