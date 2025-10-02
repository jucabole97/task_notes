import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:task_notes_app/app.dart';
import 'package:task_notes_app/core/di/di.dart';
import 'package:task_notes_app/core/services/notification_service.dart';

Future<void> mainCommon({bool useFake = false}) async {
  await _initialize(useFake: useFake);

  runApp(App());
}

Future<void> _initialize({bool useFake = false}) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationService().init();
  await dotenv.load(fileName: ".env");
  await setupDependencies(useFake: useFake);
}
