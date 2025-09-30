import 'package:flutter_test/flutter_test.dart';
import 'package:task_notes_app/task_notes.dart';

void main() {
  group('FCMService', () {
    test('Siempre devuelve la misma instancia (singleton)', () {
      final s1 = FCMService();
      final s2 = FCMService();

      expect(identical(s1, s2), isTrue);
    });

    test('token es null al inicio', () {
      final service = FCMService();
      expect(service.token, isNull);
    });

    test('setToken guarda y devuelve el valor', () {
      final service = FCMService();

      service.setToken('abc123');
      expect(service.token, 'abc123');
    });
  });
}
