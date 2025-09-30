import 'package:flutter_test/flutter_test.dart';
import 'package:task_notes_app/task_notes.dart';

void main() {
  group('ItemFactory', () {
    test('crea un Task cuando type es ItemType.task', () {
      final item = ItemFactory.create(
        ItemType.task,
        1,
        'Tarea 1',
        base64Image: 'abc123',
        token: 'tok123',
      );

      expect(item, isA<Task>());
      final task = item as Task;
      expect(task.id, 1);
      expect(task.title, 'Tarea 1');
      expect(task.base64Image, 'abc123');
      expect(task.token, 'tok123');
    });

    test('crea un Note cuando type es ItemType.note', () {
      final item = ItemFactory.create(
        ItemType.note,
        2,
        'Nota 1',
        content: 'Contenido de prueba',
        token: 'tok123',
      );

      expect(item, isA<Note>());
      final task = item as Note;
      expect(task.id, 2);
      expect(task.title, 'Nota 1');
      expect(task.content, 'Contenido de prueba');
      expect(task.token, 'tok123');
    });

    test('crea un Note con content vacío si no se pasa', () {
      final item = ItemFactory.create(ItemType.note, 3, 'Nota sin contenido');

      expect(item, isA<Note>());
      final note = item as Note;
      expect(note.content, '');
    });
  });
}
