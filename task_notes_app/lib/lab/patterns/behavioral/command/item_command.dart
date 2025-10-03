abstract class Command {
  void execute();
}

class AddTaskCommand implements Command {
  final String task;
  AddTaskCommand(this.task);

  @override
  void execute() {
    print('Ejecutando AddTask: $task');
  }
}

class RemoveTaskCommand implements Command {
  final String task;
  RemoveTaskCommand(this.task);

  @override
  void execute() {
    print('Ejecutando RemoveTask: $task');
  }
}

class CommandInvoker {
  final List<Command> _queue = [];

  void addCommand(Command command) {
    _queue.add(command);
  }

  void run() {
    for (final command in _queue) {
      command.execute();
    }

    _queue.clear();
  }
}
