import 'package:flutter/material.dart';

import '../../../task_notes.dart';

class ItemListNotifier extends ChangeNotifier {
  final ItemsPresenter _presenter;
  ItemListState _state = const ItemListInitial();
  ItemListState get state => _state;

  ItemListNotifier(this._presenter);

  List<Item> _items = [];
  List<Item> get items => _items;

  Future<void> loadItems() async {
    _setState(ItemListLoading());

    try {
      _items = await _presenter.loadItems();
      _setState(ItemListLoaded(_items));
    } catch (e) {
      _setState(ItemListError(e.toString()));
    }
  }

  Future<void> addItem({
    required String title,
    ItemType type = ItemType.note,
    String? content,
    String? base64Image,
  }) async {
    _setState(ItemListLoading());
    try {
      final item = await _presenter.addItem(
        title: title,
        type: type,
        content: content,
        base64Image: base64Image,
      );
      if (item is! EmptyItem) {
        _items.add(item);
        _setState(ItemListLoaded(_items));
        return;
      }
    } catch (e) {
      _setState(ItemListError(e.toString()));
    }
  }

  void _setState(ItemListState newState) {
    _state = newState;
    notifyListeners();
  }
}
