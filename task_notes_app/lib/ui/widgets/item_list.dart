import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_notes_app/task_notes.dart';

class ItemsList extends StatelessWidget {
  const ItemsList({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<ItemListNotifier>();

    if (notifier.state is ItemListLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (notifier.state is ItemListError) {
      return Center(
        child: Text('Error: ${(notifier.state as ItemListError).message}'),
      );
    }
    if (notifier.items.isEmpty) {
      return const Center(child: Text('No items yet'));
    }

    return Padding(
      padding: const EdgeInsets.all(8),
      child: ListView.separated(
        itemCount: notifier.items.length,
        itemBuilder: (_, i) {
          final item = notifier.items[i];

          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: item is Task
                        ? Colors.indigo[400]
                        : Colors.amber[700],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        item is Task ? Icons.check_box_outlined : Icons.note,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          item is Task ? 'Tarea' : 'Nota',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      if (item is Task && item.base64Image != null) ...[
                        const SizedBox(width: 8),
                        IconButton(
                          onPressed: () => _showDetail(context, item),
                          icon: Icon(Icons.attach_file),
                        ),
                      ],
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    item.title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                if (item is Note)
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 8,
                      right: 8,
                      bottom: 8,
                    ),
                    child: Text(item.content),
                  ),
              ],
            ),
          );
        },
        separatorBuilder: (_, index) {
          double height = 8;
          if (index == (notifier.items.length - 1)) height = 32;
          return SizedBox(height: height);
        },
      ),
    );
  }

  void _showDetail(BuildContext context, Item item) {
    final task = item as Task;
    showModalBottomSheet(
      context: context,
      builder: (_) => Padding(
        padding: const EdgeInsets.all(16),
        child: Image.memory(
          base64Decode(task.base64Image!),
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
