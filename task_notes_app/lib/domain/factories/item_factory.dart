import 'package:task_notes_app/task_notes.dart';

enum ItemType { task, note }

class ItemFactory {
  static Item create(
    ItemType type,
    int id,
    String title, {
    String? content,
    String? base64Image,
    String? token,
  }) {
    switch (type) {
      case ItemType.task:
        return Task(
          id: id,
          title: title,
          base64Image: base64Image,
          token: token,
        );
      case ItemType.note:
        return Note(id: id, title: title, content: content ?? '', token: token);
    }
  }
}
