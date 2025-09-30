import 'package:flutter_test/flutter_test.dart';
import 'package:task_notes_app/task_notes.dart';

void main() {
  group('ItemMapper.toJson', () {
    test('convierte Task a JSON', () {
      final task = Task(
        id: 1,
        title: 'Tarea',
        base64Image: 'img123',
        token: 'tok',
      );
      final json = ItemMapper.toJson(task);

      expect(json, {
        'type': 'task',
        'id': 1,
        'title': 'Tarea',
        'image': 'img123',
        'token': 'tok',
      });
    });

    test('convierte Note a JSON', () {
      final note = Note(
        id: 2,
        title: 'Nota',
        content: 'Contenido',
        token: 'tok2',
      );
      final json = ItemMapper.toJson(note);

      expect(json, {
        'type': 'note',
        'id': 2,
        'title': 'Nota',
        'content': 'Contenido',
        'token': 'tok2',
      });
    });

    test('lanza excepción si recibe tipo desconocido', () {
      final empty = EmptyItem();
      expect(() => ItemMapper.toJson(empty), throwsA(isA<Exception>()));
    });
  });

  group('ItemMapper.fromJson', () {
    test('convierte JSON de tipo task a Task', () {
      final json = {
        'type': 'task',
        'id': 1,
        'title': 'Tarea',
        'image': 'img123',
        'token': 'tok',
      };

      final item = ItemMapper.fromJson(json);

      expect(item, isA<Task>());
      final task = item as Task;
      expect(task.id, 1);
      expect(task.title, 'Tarea');
      expect(task.base64Image, 'img123');
      expect(task.token, 'tok');
    });

    test('convierte JSON de tipo note a Note', () {
      final json = {
        'type': 'note',
        'id': 2,
        'title': 'Nota',
        'content': 'Contenido',
        'token': 'tok2',
      };

      final item = ItemMapper.fromJson(json);

      expect(item, isA<Note>());
      final note = item as Note;
      expect(note.id, 2);
      expect(note.title, 'Nota');
      expect(note.content, 'Contenido');
      expect(note.token, 'tok2');
    });

    test('devuelve EmptyItem si el type es desconocido', () {
      final json = {'type': 'otro', 'id': 3, 'title': 'Desconocido'};

      final item = ItemMapper.fromJson(json);

      expect(item, isA<EmptyItem>());
    });
  });
}
