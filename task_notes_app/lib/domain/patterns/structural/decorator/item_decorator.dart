import 'package:task_notes_app/task_notes.dart';

abstract class ItemDecorator implements ItemComponent {
  final ItemComponent wrappee;

  ItemDecorator(this.wrappee);

  @override
  String render() => wrappee.render();
}
