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
  final List<Item> item;
  const ItemListLoaded(this.item);
}

class ItemListError extends ItemListState {
  final String message;
  const ItemListError(this.message);
}
