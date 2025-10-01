import 'package:flutter_test/flutter_test.dart';
import 'package:task_notes_app/main_dev.dart' as app;

class AppHelper {
  static Future<void> initApp(WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
  }
}
