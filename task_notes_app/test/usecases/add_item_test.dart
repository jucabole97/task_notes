import 'package:flutter_test/flutter_test.dart';
import 'package:task_notes_app/task_notes.dart';

void main() {
  test('Debería añadir un item al repositorio', () async {
    final repo = ItemRepositoryImpl();
    final usecase = AddItemUseCase(repo);

    final task = Task(id: "t1", title: "Test task");
    await usecase.execute(task);

    final items = await repo.getAllItems();
    expect(items.length, 1);
    expect(items.first.title, "Test task");
  });
}
