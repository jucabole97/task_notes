import 'package:flutter/material.dart';
import 'package:task_notes_app/lab/isolate/isolate_demo.dart';

void main() {
  runApp(const LabApp());
}

class LabApp extends StatelessWidget {
  const LabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Isolate Lab',
      home: Scaffold(
        appBar: AppBar(title: const Text('Laboratorio de Isolates')),
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              final notes = await runParsingLab();
              debugPrint('Se parsearon ${notes.length} notas en isolate');
            },
            child: const Text('Ejecutar parsing en isolate'),
          ),
        ),
      ),
    );
  }
}
