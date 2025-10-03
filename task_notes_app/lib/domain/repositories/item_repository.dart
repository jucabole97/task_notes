import 'package:task_notes_app/task_notes.dart';

abstract class ItemRepository {
  Future<Item> addItem(Item item);
  Future<List<Item>> getAllItems();
  Future<Item> getById(String id);
}
