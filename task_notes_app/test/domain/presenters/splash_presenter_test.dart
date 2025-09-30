import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task_notes_app/task_notes.dart';

import '../../mocks/mocks.dart';

void main() {
  late MockGetPushTokenUsecase usecase;
  late SplashPresenter presenter;

  setUp(() {
    usecase = MockGetPushTokenUsecase();

    presenter = SplashPresenter(usecase);
  });

  test('fetchToken', () async {
    when(() => usecase.execute()).thenAnswer((_) async => Future<void>.value());

    await presenter.fetchToken();

    verify(() => usecase.execute()).called(1);
  });
}
