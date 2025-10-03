// Modelo simple de ejemplo
import 'dart:convert';

import 'package:flutter/foundation.dart';

class Note {
  final String id;
  final String title;
  final String content;

  Note({required this.id, required this.title, required this.content});

  factory Note.fromJson(Map<String, dynamic> json) =>
      Note(id: json['id'], title: json['title'], content: json['content']);
}

// Función top-level para usar con compute
List<Note> parseNotes(String jsonString) {
  final List<dynamic> data = jsonDecode(jsonString);
  return data.map((e) => Note.fromJson(e)).toList();
}

// Función que simula parsing pesado
Future<List<Note>> runParsingLab() async {
  // Simulamos un JSON gigante
  final fakeJson = jsonEncode(
    List.generate(
      10000,
      (i) => {
        'id': '$i',
        'title': 'Nota $i',
        'content': 'Contenido de la nota $i',
      },
    ),
  );

  // Parseo en isolate
  final notes = await compute(parseNotes, fakeJson);
  return notes;
}
