import '../../task_notes.dart';

class AddItemUseCase {
  final ItemRepository repository;

  AddItemUseCase(this.repository);

  Future<void> execute(Item item, {String? base64Image}) async {
    if (item.title.trim().isEmpty) {
      throw ArgumentError('title must not be empty');
    }
    await repository.addItem(item);
  }
}
