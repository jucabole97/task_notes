import 'package:task_notes_app/task_notes.dart';

class BaseItem implements ItemComponent {
  final String title;
  BaseItem(this.title);

  @override
  String render() => 'Item: $title';
}
