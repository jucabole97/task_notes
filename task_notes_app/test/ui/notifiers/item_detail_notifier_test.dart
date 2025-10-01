import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task_notes_app/task_notes.dart';

import '../../mocks/mocks.dart';

void main() {
  late MockItemDetailPresenter mockPresenter;
  late ItemDetailNotifier notifier;
  late List<ItemDetailState> emittedStates;

  setUp(() {
    mockPresenter = MockItemDetailPresenter();
    notifier = ItemDetailNotifier(mockPresenter);
    emittedStates = [];

    notifier.addListener(() {
      emittedStates.add(notifier.state);
    });
  });

  group('ItemDetailNotifier', () {
    test('estado inicial es ItemDetailInitial', () {
      expect(notifier.state, isA<ItemDetailInitial>());
    });

    test('flujo exitoso: Initial -> Loading -> Loaded', () async {
      final note = Note(id: 1, title: 'title', content: 'content');
      when(() => mockPresenter.getItemById('1')).thenAnswer((_) async => note);

      await notifier.getItemById('1');

      expect(emittedStates.first, isA<ItemDetailLoading>());
      expect(emittedStates.last, isA<ItemDetailLoaded>());

      final item = emittedStates.last as ItemDetailLoaded;
      expect(item.item, note);
    });

    test('flujo con null: devuelve EmptyItem', () async {
      when(() => mockPresenter.getItemById('2')).thenAnswer((_) async => null);

      await notifier.getItemById('2');

      expect(emittedStates[0], isA<ItemDetailLoading>());
      expect(emittedStates.last, isA<ItemDetailLoaded>());

      final loaded = emittedStates.last as ItemDetailLoaded;
      expect(loaded.item, isA<EmptyItem>());
    });

    test('flujo con error: Initial → Loading → Error', () async {
      when(() => mockPresenter.getItemById('3')).thenThrow(Exception('fallo'));

      await notifier.getItemById('3');

      expect(emittedStates[0], isA<ItemDetailLoading>());
      expect(emittedStates.last, isA<ItemDetailError>());

      final error = emittedStates.last as ItemDetailError;
      expect(error.message, contains('fallo'));
    });
  });
}
