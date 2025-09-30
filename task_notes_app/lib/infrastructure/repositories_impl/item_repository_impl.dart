import '../../task_notes.dart';

class ItemRepositoryImpl implements ItemRepository {
  final ApiService _apiService;

  ItemRepositoryImpl(this._apiService);

  @override
  Future<void> addItem(Item item) async {
    await _apiService.post(ApiConfig.itemUrl, ItemMapper.toJson(item));
  }

  @override
  Future<List<Item>> getAllItems() async {
    final items =
        await _apiService.get(ApiConfig.itemUrl, isList: true)
            as List<Map<String, dynamic>>;

    return items.map((json) => ItemMapper.fromJson(json)).toList();
  }

  @override
  Future<Item> getById(String id) async {
    final item = await _apiService.get('${ApiConfig.itemUrl}/$id');
    if (item is Map<String, dynamic>) {
      return ItemMapper.fromJson(item);
    }

    return EmptyItem();
  }

  @override
  Future<void> clearAll() async {
    final db = await AppDatabase.instance.database;
    await db.close();
  }
}
