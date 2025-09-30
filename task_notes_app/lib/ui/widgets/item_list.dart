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

    return ListView.builder(
      itemCount: notifier.items.length,
      itemBuilder: (_, i) {
        final item = notifier.items[i];
        return ListTile(
          leading: Icon(item is Task ? Icons.check_box_outlined : Icons.note),
          title: Text(item.title),
          subtitle: item is Note ? Text(item.content) : null,
          onTap: () => _showDetail(context, item),
        );
      },
    );
  }

  void _showDetail(BuildContext context, Item item) {
    showModalBottomSheet(
      context: context,
      builder: (_) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              item.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            if (item is Note) Text(item.content),
            if (item is Task && item.base64Image != null) ...[
              const SizedBox(height: 16),
              Image.memory(
                base64Decode(item.base64Image!),
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
