import '../../../task_notes.dart';

sealed class ItemDetailState {
  const ItemDetailState();
}

class ItemDetailInitial extends ItemDetailState {
  const ItemDetailInitial();
}

class ItemDetailLoading extends ItemDetailState {
  const ItemDetailLoading();
}

class ItemDetailLoaded extends ItemDetailState {
  final Item item;
  const ItemDetailLoaded(this.item);
}

class ItemDetailError extends ItemDetailState {
  final String message;
  const ItemDetailError(this.message);
}
