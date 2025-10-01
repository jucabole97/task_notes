import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart' show ChangeNotifierProvider;
import 'package:task_notes_app/task_notes.dart';

import '../../mocks/mocks.dart';

void main() {
  late MockSplashPresenter mockPresenter;
  late SplashNotifier notifier;

  setUp(() {
    mockPresenter = MockSplashPresenter();
    notifier = SplashNotifier(mockPresenter);
  });

  Widget buildTestable(Widget child) {
    final router = GoRouter(
      routes: [
        GoRoute(path: '/', builder: (_, __) => child),
        GoRoute(path: '/home', builder: (_, __) => const Text('HomeScreen')),
      ],
    );

    return ChangeNotifierProvider.value(
      value: notifier,
      child: MaterialApp.router(routerConfig: router),
    );
  }

  testWidgets('muestra loader custom si se pasa', (tester) async {
    await tester.pumpWidget(
      buildTestable(const SplashScreen(loader: CircularProgressIndicator())),
    );
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  // testWidgets('cuando estado es SplashLoaded navega a /home', (tester) async {
  //   await tester.pumpWidget(
  //     buildTestable(const SplashScreen(loader: CircularProgressIndicator())),
  //   );

  //   // Forzamos el estado a SplashLoaded
  //   // notifier.state(SplashLoaded());

  //   await tester.pumpAndSettle(Duration(seconds: 3));

  //   expect(find.text('HomeScreen'), findsOneWidget);
  // });
}
