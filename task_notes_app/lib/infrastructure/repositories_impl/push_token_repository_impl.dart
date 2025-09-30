import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:task_notes_app/core/services/fcm_service.dart';
import 'package:task_notes_app/domain/repositories/push_token_repository.dart';

class PushTokenRepositoryImpl implements PushTokenRepository {
  final FirebaseMessaging _firebaseMessaging;

  PushTokenRepositoryImpl({FirebaseMessaging? firebaseMessaging})
    : _firebaseMessaging = firebaseMessaging ?? FirebaseMessaging.instance;

  @override
  Future<void> getToken() async {
    final token = await _firebaseMessaging.getToken();
    if (token != null) {
      FCMService().setToken(token);
    }
  }
}
