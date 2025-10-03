// Modelo simple
import 'dart:isolate';

class Note {
  final String id;
  final String title;
  final String content;

  Note({required this.id, required this.title, required this.content});

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'content': content,
  };
}

// Worker que corre en el isolate
void syncWorker(SendPort sendPort) async {
  final receivePort = ReceivePort();
  // Enviar el puerto de escucha al main isolate
  sendPort.send(receivePort.sendPort);

  await for (final message in receivePort) {
    if (message is Map<String, dynamic>) {
      // Simular proceso pesado (ej. sincronizar con Firestore)
      await Future.delayed(const Duration(seconds: 1));
      sendPort.send("Nota ${message['id']} procesada en isolate");
    }
  }
}

// Función para lanzar el isolate y devolver el SendPort del worker
Future<SendPort> startSyncIsolate(Function(dynamic) onMessage) async {
  final receivePort = ReceivePort();

  // Lanzar isolate
  await Isolate.spawn(syncWorker, receivePort.sendPort);

  // Esperar el primer mensaje (el SendPort del worker)
  final workerSendPort = await receivePort.first as SendPort;

  // Escuchar mensajes del worker
  receivePort.listen(onMessage);

  return workerSendPort;
}
