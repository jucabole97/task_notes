import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task_notes_app/task_notes.dart';

import '../../mocks/mocks.dart';

void main() {
  late MockFirebaseMessaging mockMessaging;
  late MockFCMService mockFCMService;
  late PushTokenRepositoryImpl repository;

  setUp(() {
    mockMessaging = MockFirebaseMessaging();
    mockFCMService = MockFCMService();

    repository = PushTokenRepositoryImpl(firebaseMessaging: mockMessaging);
  });

  group('PushTokenRepositoryImpl.getToken', () {
    test(
      'llama a FCMService.setToken cuando getToken devuelve un token',
      () async {
        when(() => mockMessaging.getToken()).thenAnswer((_) async => 'abc123');
        when(() => mockFCMService.setToken('abc123')).thenReturn(null);

        await repository.getToken();

        verify(() => mockMessaging.getToken()).called(1);
      },
    );

    test(
      'no llama a FCMService.setToken cuando getToken devuelve null',
      () async {
        when(() => mockMessaging.getToken()).thenAnswer((_) async => null);

        await repository.getToken();

        verify(() => mockMessaging.getToken()).called(1);
        verifyNever(() => mockFCMService.setToken(any()));
      },
    );
  });
}
