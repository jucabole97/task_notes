import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task_notes_app/task_notes.dart';

import '../../mocks/mocks.dart';

void main() {
  late MockItemRepository mockRepository;
  late AddItemUseCase useCase;

  setUp(() {
    mockRepository = MockItemRepository();

    useCase = AddItemUseCase(mockRepository);

    registerFallbackValue(EmptyItem());
  });

  group('AddItemUseCase', () {
    test('lanza ArgumentError si el título está vacío', () async {
      final emptyNote = Note(id: 1, title: '   ', content: 'contenido');

      expect(() => useCase.execute(emptyNote), throwsA(isA<ArgumentError>()));

      verifyNever(() => mockRepository.addItem(any()));
    });

    test('llama a repository.addItem si el título es válido', () async {
      final note = Note(id: 2, title: 'Mi nota', content: 'contenido');

      when(() => mockRepository.addItem(note)).thenAnswer((_) async {});

      await useCase.execute(note);

      verify(() => mockRepository.addItem(note)).called(1);
    });

    test('pasa el mismo Item recibido al repositorio', () async {
      final note = Note(id: 3, title: 'Otra nota', content: 'contenido');

      when(() => mockRepository.addItem(any())).thenAnswer((_) async {});

      await useCase.execute(note);

      final captured = verify(
        () => mockRepository.addItem(captureAny()),
      ).captured;
      expect(captured.single, same(note));
    });
  });
}
