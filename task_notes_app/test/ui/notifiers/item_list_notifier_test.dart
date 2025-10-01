import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task_notes_app/task_notes.dart';

import '../../mocks/mocks.dart';

void main() {
  late MockItemsPresenter mockPresenter;
  late ItemListNotifier notifier;
  late List<ItemListState> emittedStates;

  setUp(() {
    mockPresenter = MockItemsPresenter();
    notifier = ItemListNotifier(presenter: mockPresenter);
    emittedStates = [];

    notifier.addListener(() {
      emittedStates.add(notifier.state);
    });

    registerFallbackValue(EmptyItem());
  });

  group('ItemListNotifier', () {
    final itemList = [
      Task(id: 1, title: 'Hacer la tarea'),
      Note(
        id: 2,
        title: 'Ir al supermercado',
        content: 'Comprar leche, pan y huevos',
      ),
      Task(id: 3, title: 'Hacer curso de Udemy'),
      Note(id: 4, title: 'Ir al gym', content: 'Debo pagar la mensualidad'),
    ];

    test('estado inicial es ItemListInitial', () {
      expect(notifier.state, isA<ItemListInitial>());
    });

    group('loadItems Tests', () {
      test('flujo exitoso loadItems: Initial -> Loading -> Loaded', () async {
        when(() => mockPresenter.loadItems()).thenAnswer((_) async => itemList);

        await notifier.loadItems();

        expect(emittedStates.first, isA<ItemListLoading>());
        expect(emittedStates.last, isA<ItemListLoaded>());

        final item = emittedStates.last as ItemListLoaded;
        expect(item.items, itemList);
      });

      test('flujo con lista vacía loadItems', () async {
        when(() => mockPresenter.loadItems()).thenAnswer((_) async => []);

        await notifier.loadItems();

        expect(emittedStates[0], isA<ItemListLoading>());
        expect(emittedStates.last, isA<ItemListLoaded>());

        final loaded = emittedStates.last as ItemListLoaded;
        expect(loaded.items, isEmpty);
      });

      test('flujo loadItems con error: Initial → Loading → Error', () async {
        when(() => mockPresenter.loadItems()).thenThrow(Exception('fallo'));

        await notifier.loadItems();

        expect(emittedStates[0], isA<ItemListLoading>());
        expect(emittedStates.last, isA<ItemListError>());

        final error = emittedStates.last as ItemListError;
        expect(error.message, contains('fallo'));
      });
    });

    group('addItem Tests', () {
      test('flujo exitoso addItem: Initial -> Loading -> Loaded', () async {
        final item = Task(id: 10, title: 'Task 1');
        when(
          () => mockPresenter.addItem(any(that: isA<Task>())),
        ).thenAnswer((_) async => Future<void>.value());

        await notifier.addItem(title: item.title, type: ItemType.task);

        expect(emittedStates.first, isA<ItemListLoading>());
        expect(emittedStates.last, isA<ItemListLoaded>());

        final items = emittedStates.last as ItemListLoaded;

        expect(items.items.any((item) => item.title == 'Task 1'), isTrue);
      });

      test('flujo con error en presenter.addItem', () async {
        when(() => mockPresenter.addItem(any())).thenThrow(Exception('fallo'));

        await notifier.addItem(title: 'Falla', type: ItemType.task);

        expect(emittedStates.first, isA<ItemListLoading>());
        expect(emittedStates.last, isA<ItemListError>());

        final error = emittedStates.last as ItemListError;
        expect(error.message, contains('fallo'));
      });
    });
  });
}
