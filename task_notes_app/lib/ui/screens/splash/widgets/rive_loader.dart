import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class RiveLoader extends StatefulWidget {
  const RiveLoader({super.key});

  @override
  State<RiveLoader> createState() => _RiveLoaderState();
}

class _RiveLoaderState extends State<RiveLoader> {
  Artboard? _artboard;
  StateMachineController? _controller;

  @override
  void initState() {
    super.initState();
    rootBundle.load('assets/rive/loading1.riv').then((data) {
      final file = RiveFile.import(data);
      final artboard = file.mainArtboard;

      // Usa el nombre exacto del State Machine
      _controller = StateMachineController.fromArtboard(artboard, 'loading');
      if (_controller != null) {
        artboard.addController(_controller!);
      }

      setState(() => _artboard = artboard);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _artboard == null ? const SizedBox() : Rive(artboard: _artboard!);
  }
}
