import 'package:task_notes_app/task_notes.dart';

class Note extends Item {
  final String content;

  Note({
    required super.id,
    required super.title,
    required this.content,
    super.token,
    super.createdAt,
  });

  @override
  String summary() => 'Note: $title - ${content.length} chars';
}
