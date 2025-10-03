import 'package:task_notes_app/lab/patterns/structural/decorator/item_component.dart';

class BaseItem implements ItemComponent {
  final String title;
  BaseItem(this.title);

  @override
  String render() => 'Item: $title';
}
