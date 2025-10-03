import 'package:flutter/material.dart';
import 'package:task_notes_app/lab/patterns/behavioral/strategy/item_strategy.dart';

import '../../../../task_notes.dart';

class StrategyDemo extends StatefulWidget {
  const StrategyDemo({super.key});

  @override
  State<StrategyDemo> createState() => _StrategyDemoState();
}

class _StrategyDemoState extends State<StrategyDemo> {
  late DisplayStrategy _strategy;
  final items = <Item>[
    Task(id: 1, title: 'Hacer ejercicio'),
    Note(id: 2, title: 'Idea app', content: 'Clean Architecture demo'),
    Task(id: 3, title: 'Estudiar patrones'),
  ];

  @override
  void initState() {
    super.initState();
    _strategy = ListDisplayStrategy();
  }

  void _toggle() {
    setState(() {
      _strategy = _strategy is ListDisplayStrategy
          ? GridDisplayStrategy()
          : ListDisplayStrategy();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(onPressed: _toggle, child: const Text("Cambiar vista")),
        Expanded(child: _strategy.build(items)),
      ],
    );
  }
}
