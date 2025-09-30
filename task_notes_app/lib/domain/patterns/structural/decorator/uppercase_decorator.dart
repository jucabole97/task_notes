import 'package:task_notes_app/task_notes.dart';

class UppercaseDecorator extends ItemDecorator {
  UppercaseDecorator(super.wrappee);

  @override
  String render() => super.render().toUpperCase();
}
