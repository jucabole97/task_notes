import 'package:flutter/material.dart';
import 'package:task_notes_app/lab/patterns/behavioral/command/item_command.dart';

class CommandDemo extends StatelessWidget {
  const CommandDemo({super.key});

  @override
  Widget build(BuildContext context) {
    final invoker = CommandInvoker();
    invoker.addCommand(AddTaskCommand('Estudiar patrones'));
    invoker.addCommand(RemoveTaskCommand('Tarea vieja'));
    invoker.run();

    return const Center(child: Text('Revisa consola: comandos ejecutados ✅'));
  }
}
