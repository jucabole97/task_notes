import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task_notes_app/task_notes.dart';

import '../../main_mock.dart';
import '../finders.dart';

void main() {
  testWidgets('validate show HomeScreen', (tester) async {
    await MainMock.pumpApp(tester, initialLocation: '/home');

    await tester.pumpAndSettle();

    expect(find.byType(HomeScreen), findsOneWidget);
    expect(find.byType(ListTile), findsWidgets);
  });

  testWidgets('validate show bottomSheet to create a note', (tester) async {
    await MainMock.pumpApp(tester, initialLocation: '/home');

    await tester.pumpAndSettle();

    await tester.tap(Finders.homeFloatingButton);

    await tester.pump();
    await tester.tap(Finders.homeNoteButton);
    await tester.pump();

    expect(Finders.addNoteBottomSheetTitle, findsOneWidget);
  });

  testWidgets('validate show bottomSheet to create a task', (tester) async {
    await MainMock.pumpApp(tester, initialLocation: '/home');

    await tester.pumpAndSettle();

    await tester.tap(Finders.homeFloatingButton);

    await tester.pump();
    await tester.tap(Finders.homeTaskButton);
    await tester.pump();

    expect(Finders.addTaskBottomSheetTitle, findsOneWidget);
  });

  testWidgets('validate show modal to upload image', (tester) async {
    await MainMock.pumpApp(tester, initialLocation: '/home');
    await tester.pumpAndSettle();

    await tester.tap(Finders.homeFloatingButton);
    await tester.pumpAndSettle();

    await tester.tap(Finders.homeTaskButton);
    await tester.pumpAndSettle();

    expect(Finders.addTaskBottomSheetTitle, findsOneWidget);

    await tester.ensureVisible(Finders.addItemImageButton);
    await tester.tap(Finders.addItemImageButton);
    await tester.pumpAndSettle();

    expect(Finders.addItemTitleImageModal, findsOneWidget);
  });

  testWidgets('create task and show item list', (tester) async {
    await MainMock.pumpApp(tester, initialLocation: '/home');
    await tester.pumpAndSettle();

    await tester.tap(Finders.homeFloatingButton);
    await tester.pumpAndSettle();

    await tester.tap(Finders.homeTaskButton);
    await tester.pumpAndSettle();

    expect(Finders.addTaskBottomSheetTitle, findsOneWidget);

    await tester.enterText(Finders.addItemTitleTextfield, 'Tarea 1');
    await tester.pumpAndSettle();

    await tester.ensureVisible(Finders.addItemSaveButton);
    await tester.tap(Finders.addItemSaveButton);
    await tester.pumpAndSettle();

    expect(find.byType(HomeScreen), findsOneWidget);
    expect(find.text('Tarea 1'), findsOneWidget);
  });

  testWidgets('create note and show item list', (tester) async {
    await MainMock.pumpApp(tester, initialLocation: '/home');
    await tester.pumpAndSettle();

    await tester.tap(Finders.homeFloatingButton);
    await tester.pumpAndSettle();

    await tester.tap(Finders.homeNoteButton);
    await tester.pumpAndSettle();

    expect(Finders.addNoteBottomSheetTitle, findsOneWidget);

    await tester.enterText(Finders.addItemTitleTextfield, 'Nota 1');
    await tester.pump();

    await tester.enterText(Finders.addItemContentTextfield, 'Content 1');
    await tester.pumpAndSettle();

    await tester.ensureVisible(Finders.addItemSaveButton);
    await tester.tap(Finders.addItemSaveButton);
    await tester.pumpAndSettle();

    expect(find.byType(HomeScreen), findsOneWidget);
    expect(find.text('Nota 1'), findsOneWidget);
  });
}
