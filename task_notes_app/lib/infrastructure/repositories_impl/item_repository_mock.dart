import 'package:task_notes_app/domain/domain.dart';

class ItemRepositoryMock implements ItemRepository {
  final List<Item> items;

  ItemRepositoryMock({List<Item>? initialItems})
    : items =
          initialItems ??
          [
            Task(id: 1, title: 'Hacer la tarea'),
            Note(
              id: 2,
              title: 'Ir al supermercado',
              content: 'Comprar leche, pan y huevos',
            ),
            Task(id: 3, title: 'Hacer curso de Udemy'),
            Note(
              id: 4,
              title: 'Ir al gym',
              content: 'Debo pagar la mensualidad',
            ),
          ];

  @override
  Future<Item> addItem(Item item) {
    return Future.delayed(const Duration(milliseconds: 500), () {
      items.add(item);
      return item;
    });
  }

  @override
  Future<List<Item>> getAllItems() {
    return Future.delayed(const Duration(milliseconds: 500), () {
      return List<Item>.from(items);
    });
  }

  @override
  Future<Item> getById(String id) {
    return Future.delayed(const Duration(milliseconds: 500), () {
      final defaultItem = Task(id: 3, title: 'Hacer curso de Udemy');
      return items.firstWhere(
        (item) => item.id.toString() == id,
        orElse: () => defaultItem,
      );
    });
  }
}
