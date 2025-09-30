import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:task_notes_app/app.dart';
import 'package:task_notes_app/config/di/di.dart';
import 'package:task_notes_app/core/services/notification_service.dart';

void main() async {
  await _initialize();

  runApp(App());
}

Future<void> _initialize() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationService().init();
  await dotenv.load(fileName: ".env");
  setupDependencies();
}
