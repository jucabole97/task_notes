import 'package:flutter/material.dart';
import 'package:task_notes_app/task_notes.dart';

class ItemDetailNotifier extends ChangeNotifier {
  final ItemDetailPresenter presenter;
  ItemDetailState _state = const ItemDetailInitial();
  ItemDetailState get state => _state;

  ItemDetailNotifier(this.presenter);

  Future<void> getItemById(String id) async {
    _state = ItemDetailLoading();
    notifyListeners();

    try {
      final item = await presenter.getItemById(id) ?? EmptyItem();
      _state = ItemDetailLoaded(item);
    } catch (e) {
      _state = ItemDetailError(e.toString());
    }
    notifyListeners();
  }
}
