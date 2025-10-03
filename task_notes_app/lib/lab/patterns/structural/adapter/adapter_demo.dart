import 'package:flutter/material.dart';
import 'package:task_notes_app/lab/patterns/structural/adapter/item_adapter.dart';

class AdapterDemo extends StatelessWidget {
  const AdapterDemo({super.key});

  @override
  Widget build(BuildContext context) {
    final Logger logger = LoggerAdapter(ExternalLogger());
    logger.log('Probando el adapter');

    return const Center(
      child: Text('Mira la consola para ver el log adaptado'),
    );
  }
}
