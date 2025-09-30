import 'package:flutter/material.dart';

class FabMenu extends StatefulWidget {
  final VoidCallback onAddNote;
  final VoidCallback onAddTask;

  const FabMenu({super.key, required this.onAddNote, required this.onAddTask});

  @override
  State<FabMenu> createState() => _FabMenuState();
}

class _FabMenuState extends State<FabMenu> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (_expanded) ...[
          FloatingActionButton.small(
            heroTag: 'note',
            tooltip: 'Note',
            onPressed: widget.onAddNote,
            child: const Icon(Icons.note_add),
          ),
          const SizedBox(height: 8),
          FloatingActionButton.small(
            heroTag: 'task',
            tooltip: 'Task',
            onPressed: widget.onAddTask,
            child: const Icon(Icons.task),
          ),
          const SizedBox(height: 8),
        ],
        FloatingActionButton(
          onPressed: () => setState(() => _expanded = !_expanded),
          child: Icon(_expanded ? Icons.close : Icons.add),
        ),
      ],
    );
  }
}
