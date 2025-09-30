abstract class Item {
  final int id;
  final String title;
  final DateTime createdAt;
  final String? token;

  Item({required this.id, required this.title, this.token, DateTime? createdAt})
    : createdAt = createdAt ?? DateTime.now();

  // comportamiento genérico (polimorfismo)
  String summary();
}

class EmptyItem extends Item {
  EmptyItem() : super(id: -1, title: 'No disponible');

  @override
  String summary() => 'Elemento vacío';
}
