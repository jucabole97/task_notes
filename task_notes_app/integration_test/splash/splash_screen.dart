import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:task_notes_app/task_notes.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  group('SplashScreen', () {
    testWidgets('Splash muestra loader y luego navega a /home', (tester) async {
      await tester.pumpAndSettle();

      expect(find.byType(RiveLoader), findsOneWidget);
      await tester.pumpAndSettle();

      expect(find.byType(HomeScreen), findsOneWidget);
    });
  });
}
