import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task_notes_app/task_notes.dart';

import '../../mocks/mocks.dart';

void main() {
  late MockItemRepository mockRepository;
  late GetItemByIdUsecase useCase;

  setUp(() {
    mockRepository = MockItemRepository();

    useCase = GetItemByIdUsecase(mockRepository);

    registerFallbackValue(EmptyItem());
  });

  group('GetItemByIdUsecase', () {
    test('get item by id response a valid item object', () async {
      final note = Note(id: 2, title: 'Mi nota', content: 'contenido');
      when(() => mockRepository.getById('1')).thenAnswer((_) async => note);

      final item = await useCase.execute('1');

      verify(() => mockRepository.getById('1')).called(1);

      expect(item, isA<Note>());
    });

    test('get item by id response EmptyItem', () async {
      when(
        () => mockRepository.getById('2'),
      ).thenAnswer((_) async => EmptyItem());

      final item = await useCase.execute('2');

      verify(() => mockRepository.getById('2')).called(1);

      expect(item, isA<EmptyItem>());
    });
  });
}
