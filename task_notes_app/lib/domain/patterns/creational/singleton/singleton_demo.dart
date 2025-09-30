import 'package:flutter/material.dart';

import '../../../../task_notes.dart';

class SingletonDemo extends StatelessWidget {
  const SingletonDemo({super.key});

  @override
  Widget build(BuildContext context) {
    final config1 = ItemSingleton();
    final config2 = ItemSingleton();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('¿Es la misma instancia? ${identical(config1, config2)}'),
        Text('API URL: ${config1.apiBaseUrl}'),
      ],
    );
  }
}
