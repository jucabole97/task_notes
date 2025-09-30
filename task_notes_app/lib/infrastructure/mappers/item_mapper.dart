import '../../task_notes.dart';

class ItemMapper {
  static Map<String, dynamic> toJson(Item item) {
    if (item is Task) {
      return {
        'type': 'task',
        'id': item.id,
        'title': item.title,
        'image': item.base64Image,
        'token': item.token,
      };
    } else if (item is Note) {
      return {
        'type': 'note',
        'id': item.id,
        'title': item.title,
        'content': item.content,
        'token': item.token,
      };
    }
    throw Exception("Tipo de item desconocido: $item");
  }

  static Item fromJson(Map<String, dynamic> json) {
    switch (json['type']) {
      case 'task':
        return Task(
          id: json['id'],
          title: json['title'],
          base64Image: json['image'],
          token: json['token'],
        );
      case 'note':
        return Note(
          id: json['id'],
          title: json['title'],
          content: json['content'],
          token: json['token'],
        );
      default:
        return EmptyItem();
    }
  }
}
