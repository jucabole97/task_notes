import 'package:flutter/material.dart';
import 'package:task_notes_app/task_notes.dart';

class ItemDetailNotifier extends ChangeNotifier {
  final ItemDetailPresenter _presenter;
  ItemDetailState _state = const ItemDetailInitial();
  ItemDetailState get state => _state;

  ItemDetailNotifier(this._presenter);

  Future<void> getItemById(String id) async {
    _setState(ItemDetailLoading());
    try {
      final item = await _presenter.getItemById(id) ?? EmptyItem();
      _setState(ItemDetailLoaded(item));
    } catch (e) {
      _setState(ItemDetailError(e.toString()));
    }
  }

  void _setState(ItemDetailState newState) {
    _state = newState;
    notifyListeners();
  }
}
