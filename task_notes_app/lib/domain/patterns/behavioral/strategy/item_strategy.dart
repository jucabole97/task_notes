import 'package:flutter/material.dart';

import '../../../../task_notes.dart';

abstract class DisplayStrategy {
  Widget build(List<Item> items);
}

class ListDisplayStrategy implements DisplayStrategy {
  @override
  Widget build(List<Item> items) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (_, i) => ListTile(
        title: Text(items[i].title),
        subtitle: Text(items[i].summary()),
      ),
    );
  }
}

class GridDisplayStrategy implements DisplayStrategy {
  @override
  Widget build(List<Item> items) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: items.length,
      itemBuilder: (_, i) => Card(child: Center(child: Text(items[i].title))),
    );
  }
}
