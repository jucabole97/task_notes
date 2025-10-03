import '../../task_notes.dart';

class ItemRepositoryImpl implements ItemRepository {
  final GetService _getService;
  final GetByIdService _getByIdService;
  final PostService _postService;

  ItemRepositoryImpl(this._getService, this._getByIdService, this._postService);

  @override
  Future<Item> addItem(Item item) async {
    final response = await _postService.post(
      ApiConfig.itemUrl,
      ItemMapper.toJson(item),
    );

    if (response is Map<String, dynamic>) {
      return ItemMapper.fromJson(response);
    }

    return EmptyItem();
  }

  @override
  Future<List<Item>> getAllItems() async {
    final items =
        await _getService.get(ApiConfig.itemUrl, isList: true)
            as List<Map<String, dynamic>>;

    return items.map((json) => ItemMapper.fromJson(json)).toList();
  }

  @override
  Future<Item> getById(String id) async {
    final item = await _getByIdService.getById(ApiConfig.itemUrl, id);
    if (item is Map<String, dynamic>) {
      return ItemMapper.fromJson(item);
    }

    return EmptyItem();
  }
}
