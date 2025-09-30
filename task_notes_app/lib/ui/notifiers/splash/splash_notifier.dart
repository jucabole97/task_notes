import 'package:flutter/material.dart';
import 'package:task_notes_app/task_notes.dart';

class SplashNotifier extends ChangeNotifier {
  final SplashPresenter presenter;
  SplashState _state = const SplashLoading();
  SplashState get state => _state;

  SplashNotifier(this.presenter);

  Future<void> fetchToken() async {
    try {
      await presenter.fetchToken();
      await Future.delayed(const Duration(seconds: 2));
      _state = const SplashLoaded();
    } catch (e) {
      _state = SplashError(e.toString());
    }
    notifyListeners();
  }
}
