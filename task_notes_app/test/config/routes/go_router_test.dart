import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task_notes_app/task_notes.dart';

import '../../main_mock.dart';

void main() {
  testWidgets('Navegar a / después navega a HomeScreen', (tester) async {
    await MainMock.pumpApp(
      tester,
      initialLocation: '/',
      loader: CircularProgressIndicator(),
    );

    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    expect(find.byType(HomeScreen), findsOneWidget);
  });

  testWidgets('Navegar a /home muestra HomeScreen', (tester) async {
    await MainMock.pumpApp(tester, initialLocation: '/home');

    await tester.pumpAndSettle();

    expect(find.byType(HomeScreen), findsOneWidget);
  });

  testWidgets('Navegar a /patterns-lab muestra PatternsLabScreen', (
    tester,
  ) async {
    await MainMock.pumpApp(tester, initialLocation: '/patterns-lab');
    await tester.pumpAndSettle();

    expect(find.byType(PatternsLabScreen), findsOneWidget);
  });

  testWidgets('Navegar a /note/1 muestra ItemDetailScreen', (tester) async {
    await MainMock.pumpApp(tester, initialLocation: '/note/1');
    await tester.pumpAndSettle();

    expect(find.byType(ItemDetailScreen), findsOneWidget);
  });

  testWidgets('Redirige task-notes-app://note/1 a /note/1', (tester) async {
    await MainMock.pumpApp(tester, initialLocation: 'task-notes-app://note/1');
    await tester.pumpAndSettle();

    expect(find.byType(ItemDetailScreen), findsOneWidget);
  });

  testWidgets('Ruta inexistente muestra pantalla de error', (tester) async {
    await MainMock.pumpApp(tester, initialLocation: '/default');
    await tester.pumpAndSettle();

    expect(find.text('404'), findsOneWidget);
  });
}
