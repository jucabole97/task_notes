import 'package:task_notes_app/task_notes.dart';

class PushTokenRepositoryMock implements PushTokenRepository {
  @override
  Future<void> getToken() {
    return Future.delayed(const Duration(milliseconds: 300), () {
      FCMService().setToken('wefewf97097wefwe9709wfw7f079');
    });
  }
}
