import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task_notes_app/config/theme/app_theme.dart';

import '../../main_mock.dart';

void main() {
  group('AppTheme', () {
    test('lightTheme usa colores correctos', () {
      final theme = AppTheme.lightTheme;

      expect(theme.brightness, Brightness.light);
      expect(theme.primaryColor, Colors.deepPurple);
      expect(theme.colorScheme.secondary, Colors.amber);

      // CardTheme
      expect(theme.cardTheme.color, Colors.white);
      expect(theme.cardTheme.elevation, 2);
    });

    test('darkTheme usa colores correctos', () {
      final theme = AppTheme.darkTheme;

      expect(theme.brightness, Brightness.dark);
      expect(theme.primaryColor, Colors.deepPurple);
      expect(theme.colorScheme.secondary, Colors.amber);

      // CardTheme
      expect(theme.cardTheme.color, Colors.grey.shade900);
    });
  });

  group('AppTheme widget', () {
    testWidgets('ElevatedButton usa colores del tema', (tester) async {
      await MainMock.pumpApp(
        tester,
        element: ElevatedButton(onPressed: () {}, child: const Text('Test')),
      );

      final material = tester.widget<Material>(
        find.descendant(
          of: find.byType(ElevatedButton),
          matching: find.byType(Material),
        ),
      );

      expect(material.color, Colors.deepPurple);
    });
  });
}
