import 'package:flutter/material.dart';
import 'package:task_notes_app/task_notes.dart';

import '../../../lab/patterns/patterns.dart';

enum Pattern { factory, singleton, adapter, template, strategy, decorator }

class PatternsLabScreen extends StatelessWidget {
  const PatternsLabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("🧪 Patrones GoF Lab")),
      body: ListView.builder(
        itemCount: Pattern.values.length,
        itemBuilder: (context, index) {
          final pattern = Pattern.values[index];
          return ListTile(
            title: Text(pattern.name.capitalize()),
            trailing: const Icon(Icons.play_arrow),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PatternDemoScreen(pattern: pattern),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class PatternDemoScreen extends StatelessWidget {
  final Pattern pattern;
  const PatternDemoScreen({super.key, required this.pattern});

  @override
  Widget build(BuildContext context) {
    Widget demo;
    switch (pattern) {
      case Pattern.factory:
        demo = FactoryDemo();
        break;
      case Pattern.singleton:
        demo = SingletonDemo();
        break;
      case Pattern.adapter:
        demo = AdapterDemo();
        break;
      case Pattern.template:
        demo = TemplateDemo();
        break;
      case Pattern.strategy:
        demo = StrategyDemo();
        break;
      case Pattern.decorator:
        demo = DecoratorDemo();
        break;
    }

    return Scaffold(
      appBar: AppBar(title: Text("Demo: $pattern")),
      body: Center(child: demo),
    );
  }
}
