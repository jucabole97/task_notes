import 'package:task_notes_app/lab/patterns/patterns.dart';

class LoggingDecorator extends ItemDecorator {
  LoggingDecorator(super.wrappee);

  @override
  String render() {
    final result = super.render();
    print('Log: render() ejecutado -> $result');

    return result;
  }
}
