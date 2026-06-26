# Crypto Send Flow

This project is a Flutter implementation of a crypto asset transfer flow created as part of a coding assignment.

The application demonstrates a complete send transaction journey, starting from wallet selection and ending with a transaction result screen. The backend is mocked to simulate network requests while keeping the architecture modular and easy to extend.

## Features

* Wallet screen displaying available crypto assets
* Recipient selection
* Amount entry with custom numeric keyboard
* Input validation
* Transaction review
* PIN verification (mock PIN: **1234**)
* Mock transaction processing
* Transaction result (Success / Pending / Failed)
* Transaction details screen
* Navigation using GoRouter
* State management using Riverpod

## Project Structure

```
lib/
├── core/
├── features/
│   ├── wallet/
│   ├── recipient/
│   ├── amount/
│   ├── review/
│   ├── pin/
│   └── transaction/
├── providers/
├── shared/
└── main.dart
```

The project follows a feature-first folder structure where each feature owns its presentation and data layer. Shared models, validators and providers are placed outside feature modules to avoid duplication.

## Architecture

Although this project is intentionally lightweight due to the assignment scope, it follows principles inspired by Clean Architecture.

* Feature-first folder organization
* Repository pattern
* Riverpod for state management
* Reusable UI components
* Separation of UI and business logic

Business logic is handled inside Riverpod Notifiers, while screens focus on rendering state and user interactions.

## Tech Stack

* Flutter
* Dart
* Riverpod
* GoRouter
* Equatable

## Running the Project

Clone the repository and install dependencies.

```bash
flutter pub get
```

Run the application.

```bash
flutter run
```
- Flutter: 3.41.5 stable (Dart 3.11.3)
## Demo Flow

Wallet

↓

Recipient

↓

Amount

↓

Review

↓

PIN (1234)

↓

Transaction Result

↓

Transaction Details

## Notes

* The backend is mocked for demonstration purposes.
* Transaction fees are simulated.
* Transaction status (Success, Pending and Failed) is generated using a mock repository.
* No real blockchain or payment gateway is integrated.

Thank you for reviewing the project.
