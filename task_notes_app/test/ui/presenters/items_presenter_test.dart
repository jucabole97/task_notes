import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task_notes_app/task_notes.dart';

import '../../mocks/mocks.dart';

void main() {
  late MockAddItemUseCase addItemUseCase;
  late MockGetItemsUseCase getItemsUseCase;
  late ItemsPresenter presenter;

  setUp(() {
    addItemUseCase = MockAddItemUseCase();
    getItemsUseCase = MockGetItemsUseCase();

    presenter = ItemsPresenter(
      addItemUseCase: addItemUseCase,
      getItemsUseCase: getItemsUseCase,
    );
  });

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

  group('loadItems', () {
    test('loadItems returns a list of Item', () async {
      when(() => getItemsUseCase.execute()).thenAnswer((_) async => itemList);

      final items = await presenter.loadItems();

      expect(items.length, 4);
    });

    test('loadItems returns a empty', () async {
      when(() => getItemsUseCase.execute()).thenAnswer((_) async => []);

      final items = await presenter.loadItems();

      expect(items.isEmpty, isTrue);
    });
  });

  test('addItem', () async {
    when(
      () => addItemUseCase.execute(itemList.first),
    ).thenAnswer((_) async => Future<void>.value());

    await presenter.addItem(itemList.first);

    verify(() => addItemUseCase.execute(itemList.first)).called(1);
  });
}
