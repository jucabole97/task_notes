import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_notes_app/task_notes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Task & Notes')),
      body: const ItemsList(),
      floatingActionButton: Builder(
        builder: (context) {
          return FabMenu(
            onAddNote: () => _showAddItemSheet(context, ItemType.note),
            onAddTask: () => _showAddItemSheet(context, ItemType.task),
          );
        },
      ),
    );
  }

  void _showAddItemSheet(BuildContext context, ItemType type) {
    final notifier = context.read<ItemListNotifier>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return ChangeNotifierProvider.value(
          value: notifier,
          child: AddItemSheet(type: type),
        );
      },
    );
  }
}
