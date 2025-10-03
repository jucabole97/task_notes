import 'package:flutter/material.dart';
import 'package:task_notes_app/lab/patterns/patterns.dart';

class DecoratorDemo extends StatelessWidget {
  const DecoratorDemo({super.key});

  @override
  Widget build(BuildContext context) {
    final base = BaseItem('Mi Item');
    final decorated = UppercaseDecorator(LoggingDecorator(base));

    return Center(child: Text(decorated.render()));
  }
}
