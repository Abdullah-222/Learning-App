# Secure Learning App – Project Specification

## Overview

This is a simple cross-platform Flutter application (Android / iOS / macOS) focused on teaching basic code vulnerability concepts.

The app includes:

- User authentication (Firebase Email/Password)
- Home page
- Learn page (7 topics with quizzes)
- Settings page (theme, font size, language)
- Two placeholder pages for future use

The app must be clean, simple, and beginner-friendly.

Backend is Firebase (Auth + Firestore).
Local preferences are stored using SharedPreferences.

No advanced features.

---

## Tech Stack

Frontend:
- Flutter (Dart)

Backend:
- Firebase Authentication
- Cloud Firestore

Local Storage:
- SharedPreferences

IDE:
- VS Code

---

## App Navigation

If user NOT logged in:
- Login Screen
- Register Screen

If logged in:
Bottom Navigation Bar with:

1. Home
2. Learn
3. Settings
4. Placeholder Page 1
5. Placeholder Page 2

---

## Authentication

Using Firebase Authentication (Email + Password).

Screens:

### Register Screen
Fields:
- Email
- Password
- Confirm Password

Validation:
- Email format
- Password min 6 chars
- Passwords match

On success:
- Create Firebase user
- Create Firestore user document
- Navigate to main app

---

### Login Screen

Fields:
- Email
- Password

On success:
- Navigate to main app

---

## Firestore Structure

users/{uid}
{
  email: string,
  createdAt: timestamp
}

progress/{uid}
{
  buffer_overflow: number,
  memory_leak: number,
  pointer_misuse: number,
  integer_overflow: number,
  null_pointer: number,
  input_validation: number,
  unsafe_functions: number
}

Each value represents completed questions (0–5).

---

## Home Page

Purpose:
Simple dashboard.

Contains:

- Welcome banner ("Welcome back")
- Button to Learn page
- Quick Access (recent topic)
- Tip box

No complex logic.

---

## Learn Page

Educational section.

Contains exactly 7 topics:

1. Buffer Overflow
2. Memory Leak
3. Pointer Misuse
4. Integer Overflow
5. Null Pointer Dereference
6. Input Validation Errors
7. Unsafe Function Usage

Each topic card includes:

- Title
- Short description
- Progress bar
- Watch Videos button (YouTube link)
- Start Exercises button

---

### Questions

Each topic has exactly 5 multiple choice questions.

Each question includes:

- Question text
- 4 options
- Correct index
- Explanation

After answering:

- Show correct/incorrect
- Show explanation
- Update progress bar
- Save progress to Firestore

Users can:

- Resume later
- Restart topic

---

## Settings Page

Stored locally using SharedPreferences.

Includes:

### Theme
- Light
- Dark
- System

Applies instantly.

---

### Font Size
Slider:
- Small
- Medium
- Large

Affects entire app text scale.

---

### Language
Dropdown:
- English
- Arabic (optional)

UI text only.

---

### Reset Settings

Clears SharedPreferences.

Does NOT delete Firestore progress.

---

## Placeholders

Two empty pages with simple text:
"Coming Soon"

---

## UI Requirements

- Clean Material UI
- Simple cards
- Minimal colors
- Loading indicators
- Error messages
- Responsive layout

No biometrics.
No push notifications.

---
okay 
## Goals

- Simple
- Editable
- Beginner-friendly
- Production structured

