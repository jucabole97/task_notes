import 'package:flutter_test/flutter_test.dart';
import 'package:task_notes_app/task_notes.dart';

void main() {
  group('Task', () {
    test('se inicializa con los valores requeridos', () {
      final task = Task(id: 1, title: 'Mi tarea');

      expect(task.id, 1);
      expect(task.title, 'Mi tarea');
      expect(task.base64Image, isNull);
      expect(task.token, isNull);
      expect(task, isA<Item>()); // polimorfismo
    });

    test('acepta base64Image opcional', () {
      final task = Task(id: 2, title: 'Con imagen', base64Image: 'abc123');
      expect(task.base64Image, 'abc123');
    });

    test('createdAt se asigna automáticamente si no se pasa', () {
      final task = Task(id: 3, title: 'Auto fecha');
      final after = DateTime.now();

      expect(
        task.createdAt.isBefore(after.add(const Duration(seconds: 1))),
        isTrue,
      );
    });

    test('permite pasar createdAt manualmente', () {
      final customDate = DateTime(2020, 1, 1);
      final task = Task(id: 4, title: 'Con fecha', createdAt: customDate);

      expect(task.createdAt, customDate);
    });

    test('summary devuelve el formato esperado', () {
      final task = Task(id: 5, title: 'Resumen');
      expect(task.summary(), 'Task: Resumen');
    });

    test('acepta token opcional', () {
      final task = Task(id: 6, title: 'Con token', token: 'xyz');
      expect(task.token, 'xyz');
    });
  });
}
