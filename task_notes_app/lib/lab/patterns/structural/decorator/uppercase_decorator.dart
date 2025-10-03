import 'package:task_notes_app/lab/patterns/patterns.dart';

class UppercaseDecorator extends ItemDecorator {
  UppercaseDecorator(super.wrappee);

  @override
  String render() => super.render().toUpperCase();
}
