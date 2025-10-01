# task_notes_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

Para ejecutar deeplink desde terminal:

- adb shell am start -a android.intent.action.VIEW -d "task-notes-app://note/1" com.example.task_notes_app

Para ejecutar test de integración:

- flutter drive --driver integration_test/integration_test_driver.dart --target integration_test/splash/splash_screen.dart --flavor dev -t lib/main_dev.dart -d SM M236B