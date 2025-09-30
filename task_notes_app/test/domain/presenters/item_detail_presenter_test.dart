import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task_notes_app/domain/domain.dart';

import '../../mocks/mocks.dart';

void main() {
  late MockGetItemByIdUsecase useCase;
  late ItemDetailPresenter presenter;

  setUp(() {
    useCase = MockGetItemByIdUsecase();
    presenter = ItemDetailPresenter(useCase);
  });

  test('getItemById return Item object', () async {
    when(
      () => useCase.execute('1'),
    ).thenAnswer((_) async => Task(id: 1, title: 'Title'));

    final item = await presenter.getItemById('1');

    expect(item, isA<Task>());
    expect(item?.id, 1);
  });

  test('getItemById return null when has error', () async {
    when(() => useCase.execute('2')).thenAnswer((_) async => null);

    final item = await presenter.getItemById('2');

    expect(item, isNull);
  });
}
