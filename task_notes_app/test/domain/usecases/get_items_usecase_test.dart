import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task_notes_app/task_notes.dart';

import '../../mocks/mocks.dart';

void main() {
  late MockItemRepository mockRepository;
  late GetItemsUseCase useCase;

  setUp(() {
    mockRepository = MockItemRepository();

    useCase = GetItemsUseCase(mockRepository);
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

  group('GetItemsUseCase', () {
    test('get item list response a valid list', () async {
      when(
        () => mockRepository.getAllItems(),
      ).thenAnswer((_) async => itemList);

      final items = await useCase.execute();

      verify(() => mockRepository.getAllItems()).called(1);

      expect(items.length, equals(4));
    });

    test('get items list response a empty list', () async {
      when(() => mockRepository.getAllItems()).thenAnswer((_) async => []);

      final items = await useCase.execute();

      verify(() => mockRepository.getAllItems()).called(1);

      expect(items.isEmpty, isTrue);
    });
  });
}
