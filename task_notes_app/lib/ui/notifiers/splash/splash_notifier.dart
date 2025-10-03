import 'package:flutter/material.dart';
import 'package:task_notes_app/task_notes.dart';

class SplashNotifier extends ChangeNotifier {
  final SplashPresenter _presenter;
  SplashState _state = const SplashLoading();
  SplashState get state => _state;

  SplashNotifier(this._presenter);

  Future<void> fetchToken() async {
    try {
      await _presenter.fetchToken();
      await Future.delayed(const Duration(seconds: 2));
      _setState(SplashLoaded());
    } catch (e) {
      _setState(SplashError(e.toString()));
    }
  }

  void _setState(SplashState newState) {
    _state = newState;
    notifyListeners();
  }
}
