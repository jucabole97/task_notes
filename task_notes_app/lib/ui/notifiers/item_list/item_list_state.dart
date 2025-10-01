import '../../../domain/entities/item.dart';

sealed class ItemListState {
  const ItemListState();
}

class ItemListInitial extends ItemListState {
  const ItemListInitial();
}

class ItemListLoading extends ItemListState {
  const ItemListLoading();
}

class ItemListLoaded extends ItemListState {
  final List<Item> items;
  const ItemListLoaded(this.items);
}

class ItemListError extends ItemListState {
  final String message;
  const ItemListError(this.message);
}
