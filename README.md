# Secure Learning App

A Flutter application designed to teach basic code vulnerability concepts through interactive lessons and quizzes.

## Features

- **Dynamic Theming**: Support for Light and Dark modes.
- **Authentication**: Email/Password login and registration (Mocked for development).
- **Interactive Learning**:
  - 7 C++ Security Topics (Buffer Overflow, Memory Leak, etc.).
  - Interactive quizzes with instant feedback and explanations.
  - Video lesson links.
- **Progress Tracking**: Local persistence of lesson scores.
- **Responsive Design**: Works on Mobile, Tablet, and Desktop (Adaptive UI).

## Tech Stack

- **Framework**: Flutter (Dart)
- **State Management**: Provider
- **Local Storage**: SharedPreferences
- **Backend (Planned)**: Firebase Auth & Firestore

## Development Setup

1. **Clone the repository**:
   ```bash
   git clone <repo-url>
   ```
2. **Install dependencies**:
   ```bash
   flutter pub get
   ```
3. **Run the app**:
   ```bash
   flutter run
   ```

## Test Credentials (Mock)

- **Email**: `test@example.com`
- **Password**: `password123` (Any password > 6 characters will work)

## Project Structure

- `lib/models/`: Data models for Topics and Quizzes.
- `lib/services/`: Mock Authentication and Progress services.
- `lib/controllers/`: ChangeNotifier-based controllers for state management.
- `lib/screens/`: UI implementation for all pages.
- `lib/constants.dart`: Global theme and color definitions.

---
*Created as part of the Secure Learning App Project Specification.*
