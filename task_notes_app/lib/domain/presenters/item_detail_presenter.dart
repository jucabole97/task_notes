import 'package:task_notes_app/task_notes.dart';

class ItemDetailPresenter {
  final GetItemByIdUsecase useCase;

  const ItemDetailPresenter(this.useCase);

  Future<Item?> getItemById(String id) async {
    return await useCase.execute(id);
  }
}
