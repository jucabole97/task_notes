import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task_notes_app/domain/domain.dart';

import '../../mocks/mocks.dart';

void main() {
  late MockPushTokenRepository mockRepository;
  late GetPushTokenUsecase useCase;

  setUp(() {
    mockRepository = MockPushTokenRepository();

    useCase = GetPushTokenUsecase(mockRepository);
  });

  test('getToken', () async {
    when(mockRepository.getToken).thenAnswer((_) async => Future<void>.value());

    await useCase.execute();

    verify(() => mockRepository.getToken()).called(1);
  });
}
