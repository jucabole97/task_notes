import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task_notes_app/task_notes.dart';

class MockFirebaseMessaging extends Mock implements FirebaseMessaging {
  final _controller = StreamController<RemoteMessage>.broadcast();

  void addMessage(RemoteMessage message) => _controller.add(message);

  @override
  Future<NotificationSettings> requestPermission({
    bool alert = true,
    bool announcement = false,
    bool badge = true,
    bool carPlay = false,
    bool criticalAlert = false,
    bool providesAppNotificationSettings = false,
    bool provisional = false,
    bool sound = true,
  }) async {
    return const NotificationSettings(
      alert: AppleNotificationSetting.enabled,
      announcement: AppleNotificationSetting.notSupported,
      authorizationStatus: AuthorizationStatus.authorized,
      badge: AppleNotificationSetting.enabled,
      carPlay: AppleNotificationSetting.notSupported,
      lockScreen: AppleNotificationSetting.enabled,
      notificationCenter: AppleNotificationSetting.enabled,
      showPreviews: AppleShowPreviewSetting.always,
      timeSensitive: AppleNotificationSetting.notSupported,
      criticalAlert: AppleNotificationSetting.notSupported,
      sound: AppleNotificationSetting.enabled,
      providesAppNotificationSettings: AppleNotificationSetting.disabled,
    );
  }

  @override
  Future<RemoteMessage?> getInitialMessage() async => null;
}

class MockLocalNotifications extends Mock
    implements FlutterLocalNotificationsPlugin {}

class MockAndroidLocalNotifications extends Mock
    implements AndroidFlutterLocalNotificationsPlugin {}

class MockGoRouter extends Mock implements GoRouter {}

class MockGetItemByIdUsecase extends Mock implements GetItemByIdUsecase {}

class MockAddItemUseCase extends Mock implements AddItemUseCase {}

class MockGetItemsUseCase extends Mock implements GetItemsUseCase {}

class MockGetPushTokenUsecase extends Mock implements GetPushTokenUsecase {}

class MockItemRepository extends Mock implements ItemRepository {}

class MockPushTokenRepository extends Mock implements PushTokenRepository {}

class FakeAndroidNotificationChannel extends Fake
    implements AndroidNotificationChannel {}

class FakeInitializationSettings extends Fake
    implements InitializationSettings {}

class FakeNotificationDetails extends Fake implements NotificationDetails {}

class TestableNotificationService extends NotificationService {
  final StreamController<RemoteMessage> _onMessageController;
  final StreamController<RemoteMessage> _onMessageOpenedAppController;

  TestableNotificationService({
    required FirebaseMessaging messaging,
    required FlutterLocalNotificationsPlugin localNotifications,
    required GoRouter goRouter,
    required StreamController<RemoteMessage> onMessageController,
    required StreamController<RemoteMessage> onMessageOpenedAppController,
  }) : _onMessageController = onMessageController,
       _onMessageOpenedAppController = onMessageOpenedAppController,
       super(
         messaging: messaging,
         localNotifications: localNotifications,
         goRouter: goRouter,
       );

  @override
  Stream<RemoteMessage> get onMessage => _onMessageController.stream;

  @override
  Stream<RemoteMessage> get onMessageOpenedApp =>
      _onMessageOpenedAppController.stream;
}

class MockHttpClient extends Mock implements HttpClient {}

class MockHttpClientRequest extends Mock implements HttpClientRequest {}

class MockHttpClientResponse extends Mock implements HttpClientResponse {}

class MockHttpHeaders extends Mock implements HttpHeaders {}

class MockGetService extends Mock implements GetService {}

class MockGetByIdService extends Mock implements GetByIdService {}

class MockPostService extends Mock implements PostService {}

class MockPutService extends Mock implements PutService {}

class MockDeleteService extends Mock implements DeleteService {}

class MockFCMService extends Mock implements FCMService {}

class MockItemDetailPresenter extends Mock implements ItemDetailPresenter {}

class MockItemsPresenter extends Mock implements ItemsPresenter {}

class MockSplashPresenter extends Mock implements SplashPresenter {}
