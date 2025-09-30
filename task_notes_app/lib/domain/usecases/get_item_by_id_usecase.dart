import '../../task_notes.dart';

class GetItemByIdUsecase {
  final ItemRepository repository;
  GetItemByIdUsecase(this.repository);

  Future<Item?> execute(String id) => repository.getById(id);
}
