import '../../task_notes.dart';

class ItemsPresenter {
  final AddItemUseCase addItemUseCase;
  final GetItemsUseCase getItemsUseCase;

  ItemsPresenter({required this.addItemUseCase, required this.getItemsUseCase});

  Future<List<Item>> loadItems() async {
    return await getItemsUseCase.execute();
  }

  Future<void> addItem(Item item) async {
    await addItemUseCase.execute(item);
  }
}
