import 'package:flutter/material.dart';

import '../../../../task_notes.dart';

class FactoryDemo extends StatelessWidget {
  const FactoryDemo({super.key});

  @override
  Widget build(BuildContext context) {
    final items = <Item>[
      ItemFactory.create(ItemType.task, 2, 'Comprar pan'),
      ItemFactory.create(
        ItemType.note,
        1,
        'Nota rápida',
        content: 'Hola mundo',
      ),
    ];

    return ListView(
      children: items
          .map(
            (e) => ListTile(title: Text(e.title), subtitle: Text(e.summary())),
          )
          .toList(),
    );
  }
}
