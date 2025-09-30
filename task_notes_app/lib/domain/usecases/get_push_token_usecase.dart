import 'package:task_notes_app/domain/repositories/push_token_repository.dart';

class GetPushTokenUsecase {
  final PushTokenRepository _repository;

  GetPushTokenUsecase(this._repository);

  Future<void> execute() async {
    return await _repository.getToken();
  }
}
