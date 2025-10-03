import '../../task_notes.dart';

class AddItemUseCase {
  final ItemRepository repository;

  AddItemUseCase(this.repository);

  Future<Item> execute(Item item, {String? base64Image}) async {
    if (item.title.trim().isEmpty) {
      throw ArgumentError('title must not be empty');
    }
    return await repository.addItem(item);
  }
}
