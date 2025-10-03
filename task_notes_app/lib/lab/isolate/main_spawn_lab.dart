import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:task_notes_app/lab/isolate/spawn_demo.dart';

void main() {
  runApp(SpawnLabApp());
}

class SpawnLabApp extends StatefulWidget {
  const SpawnLabApp({super.key});

  @override
  State<SpawnLabApp> createState() => _SpawnLabAppState();
}

class _SpawnLabAppState extends State<SpawnLabApp> {
  SendPort? _workerSendPort;
  final List<String> _logs = [];

  @override
  void initState() {
    super.initState();
    _initWorker();
  }

  Future<void> _initWorker() async {
    _workerSendPort = await startSyncIsolate((msg) {
      setState(() {
        _logs.add(msg.toString());
      });
    });
  }

  void _sendNote(int id) {
    _workerSendPort?.send({
      'id': id.toString(),
      'title': 'Nota $id',
      'content': 'Contenido de la nota $id',
    });
    setState(() {
      _logs.add("Nota $id enviada al isolate");
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spawn Lab',
      home: Scaffold(
        appBar: AppBar(title: const Text('Laboratorio Isolate.spawn')),
        body: Column(
          children: [
            ElevatedButton(
              onPressed: () => _sendNote(_logs.length + 1),
              child: const Text('Enviar nota al isolate'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _logs.length,
                itemBuilder: (_, i) => ListTile(title: Text(_logs[i])),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
