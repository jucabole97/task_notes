import 'package:task_notes_app/task_notes.dart';

class Task extends Item {
  final String? base64Image;

  Task({
    required super.id,
    required super.title,
    this.base64Image,
    super.token,
    super.createdAt,
  });

  @override
  String summary() => 'Task: $title';
}
