import 'package:flutter_test/flutter_test.dart';
import 'package:task_notes_app/task_notes.dart';

void main() {
  test('Presenter carga y agrega items', () async {
    final repo = ItemRepositoryImpl();
    final presenter = ItemsPresenter(repo);

    final items = await presenter.loadItems();
    expect(items.length, 0);

    await presenter.addItem(Task(id: "t2", title: "Task X"));
    final items2 = await presenter.loadItems();
    expect(items2.length, 1);
  });
}
