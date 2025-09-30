import 'package:flutter_test/flutter_test.dart';
import 'package:task_notes_app/task_notes.dart';

void main() {
  group('Note', () {
    test('se inicializa con los valores requeridos', () {
      final note = Note(id: 1, title: 'Mi nota', content: 'Contenido');

      expect(note.id, 1);
      expect(note.title, 'Mi nota');
      expect(note.content, 'Contenido');
      expect(note.token, isNull);
      expect(note, isA<Item>()); // polimorfismo
    });

    test('createdAt se asigna automáticamente si no se pasa', () {
      final note = Note(id: 2, title: 'Auto fecha', content: 'Texto');
      final after = DateTime.now();

      expect(
        note.createdAt.isBefore(after.add(const Duration(seconds: 1))),
        isTrue,
      );
    });

    test('permite pasar createdAt manualmente', () {
      final customDate = DateTime(2020, 1, 1);
      final note = Note(
        id: 3,
        title: 'Con fecha',
        content: 'Texto',
        createdAt: customDate,
      );

      expect(note.createdAt, customDate);
    });

    test('summary devuelve el formato esperado', () {
      final note = Note(id: 4, title: 'Resumen', content: '12345');
      expect(note.summary(), 'Note: Resumen - 5 chars');
    });

    test('acepta token opcional', () {
      final note = Note(
        id: 5,
        title: 'Con token',
        content: 'abc',
        token: 'xyz',
      );
      expect(note.token, 'xyz');
    });
  });
}
