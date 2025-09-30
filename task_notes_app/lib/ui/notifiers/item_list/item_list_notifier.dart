import 'package:flutter/material.dart';

import '../../../task_notes.dart';

class ItemListNotifier extends ChangeNotifier {
  final ItemsPresenter presenter;
  ItemListState _state = const ItemListInitial();
  ItemListState get state => _state;

  ItemListNotifier({required this.presenter});

  List<Item> _items = [];
  List<Item> get items => _items;

  Future<void> loadItems({Item? item}) async {
    _state = ItemListLoading();
    notifyListeners();

    if (item != null) {
      _items.add(item);
      _state = ItemListLoaded(_items);
      notifyListeners();
      return;
    }

    try {
      _items = await presenter.loadItems();
      _state = ItemListLoaded(_items);
    } catch (e) {
      _state = ItemListError(e.toString());
    }
    notifyListeners();
  }

  Future<void> addItem({
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
    try {
      await presenter.addItem(item);
      await loadItems(item: item);
    } catch (e) {
      notifyListeners();
    }
  }
}
