import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:task_notes_app/task_notes.dart';

class SplashScreen extends StatelessWidget {
  final Widget? loader;

  const SplashScreen({super.key, this.loader});

  @override
  Widget build(BuildContext context) {
    return Consumer<SplashNotifier>(
      builder: (context, notifier, _) {
        final state = notifier.state;
        if (state is SplashLoaded) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.go('/home');
          });
        }

        return Scaffold(
          body: Center(
            child: SizedBox(
              width: 150,
              height: 150,
              child: loader ?? RiveLoader(),
            ),
          ),
        );
      },
    );
  }
}
