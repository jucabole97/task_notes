import '../../task_notes.dart';

class GetItemsUseCase {
  final ItemRepository repository;
  GetItemsUseCase(this.repository);

  Future<List<Item>> execute() async => await repository.getAllItems();
}
