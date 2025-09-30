import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../task_notes.dart';

class ItemDetailScreen extends StatelessWidget {
  const ItemDetailScreen({super.key, this.isDeeplink = false});

  final bool isDeeplink;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ItemDetailNotifier>().state;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Detalle del item'),
          centerTitle: true,
          leading: IconButton(
            onPressed: () =>
                isDeeplink ? context.pushReplacement('/home') : context.pop(),
            icon: Icon(Icons.arrow_back_ios),
          ),
        ),
        body: switch (state) {
          ItemDetailInitial() => const SizedBox.shrink(),
          ItemDetailLoading() => const Center(
            child: CircularProgressIndicator(),
          ),
          ItemDetailLoaded(:final item) => _showBody(item, context),
          ItemDetailError(:final message) => Center(child: Text(message)),
        },
      ),
    );
  }

  Widget _showBody(Item item, BuildContext context) {
    final List<Widget> widgets = [
      Text(
        item.title,
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 16),
    ];

    switch (item) {
      case Note(content: final content):
        widgets.addAll([
          Text(content, style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 16),
        ]);
      case Task(base64Image: final img) when img != null:
        widgets.add(
          Image.memory(
            base64Decode(img),
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        );
      default:
        widgets.add(const SizedBox.shrink());
    }

    return Column(children: widgets);
  }
}
