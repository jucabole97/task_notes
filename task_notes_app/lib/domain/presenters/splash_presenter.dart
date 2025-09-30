import 'package:task_notes_app/domain/usecases/get_push_token_usecase.dart';

class SplashPresenter {
  final GetPushTokenUsecase _getPushTokenUsecase;

  SplashPresenter(this._getPushTokenUsecase);

  Future<void> fetchToken() async {
    return await _getPushTokenUsecase.call();
  }
}
