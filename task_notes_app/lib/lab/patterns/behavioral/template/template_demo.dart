import 'package:flutter/material.dart';
import 'package:task_notes_app/lab/patterns/behavioral/template/item_template.dart';

class TemplateDemo extends StatelessWidget {
  const TemplateDemo({super.key});

  @override
  Widget build(BuildContext context) {
    final taskSaver = SaveTask();
    taskSaver.save();

    final noteSaver = SaveNote();
    noteSaver.save();

    return const Center(child: Text("Mira consola: Template ejecutado 📑"));
  }
}
