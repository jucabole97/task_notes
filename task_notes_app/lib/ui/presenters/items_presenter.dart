import '../../task_notes.dart';

class ItemsPresenter {
  final AddItemUseCase addItemUseCase;
  final GetItemsUseCase getItemsUseCase;

  ItemsPresenter({required this.addItemUseCase, required this.getItemsUseCase});

  Future<List<Item>> loadItems() async {
    return await getItemsUseCase.execute();
  }

  Future<Item> addItem({
    required String title,
    ItemType type = ItemType.note,
    String? content,
    String? base64Image,
  }) async {
    final id = DateTime.now().millisecondsSinceEpoch;
    final item = ItemFactory.create(
      type,
      id,
      title,
      content: content,
      base64Image: base64Image,
      token: FCMService().token,
    );
    return await addItemUseCase.execute(item);
  }
}
