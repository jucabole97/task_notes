import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task_notes_app/task_notes.dart';

import '../../mocks/mocks.dart';

void main() {
  late MockSplashPresenter mockPresenter;
  late SplashNotifier notifier;
  late List<SplashState> emittedStates;

  setUp(() {
    mockPresenter = MockSplashPresenter();
    notifier = SplashNotifier(mockPresenter);
    emittedStates = [];

    notifier.addListener(() {
      emittedStates.add(notifier.state);
    });
  });

  test('initial state SplashStateLoading', () {
    expect(notifier.state, isA<SplashLoading>());
  });

  test('flujo exitoso fetchToken: Loaded', () async {
    when(
      () => mockPresenter.fetchToken(),
    ).thenAnswer((_) async => Future<void>.value());

    await notifier.fetchToken();

    expect(emittedStates.last, isA<SplashLoaded>());
  });

  test('flujo fetchToken con error: Error', () async {
    when(() => mockPresenter.fetchToken()).thenThrow(Exception('Error'));

    await notifier.fetchToken();

    expect(emittedStates.last, isA<SplashError>());

    final error = emittedStates.last as SplashError;

    expect(error.message, contains('Error'));
  });
}
