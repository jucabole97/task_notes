import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/mocks.dart';

void main() {
  late MockLocalNotifications mockLocalNotifications;
  late MockGoRouter mockRouter;
  late StreamController<RemoteMessage> onMessageController;
  late StreamController<RemoteMessage> onMessageOpenedAppController;
  late MockFirebaseMessaging mockFirebaseMessaging;
  late TestableNotificationService service;

  setUpAll(() {
    registerFallbackValue(FakeNotificationDetails());
    registerFallbackValue(FakeInitializationSettings());
    registerFallbackValue(FakeAndroidNotificationChannel());
  });

  setUp(() {
    mockLocalNotifications = MockLocalNotifications();
    mockRouter = MockGoRouter();
    onMessageController = StreamController<RemoteMessage>.broadcast();
    onMessageOpenedAppController = StreamController<RemoteMessage>.broadcast();
    mockFirebaseMessaging = MockFirebaseMessaging();

    when(
      () => mockLocalNotifications.show(
        any(),
        any(),
        any(),
        any(),
        payload: any(named: 'payload'),
      ),
    ).thenAnswer((_) async {});

    when(
      () => mockLocalNotifications
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >(),
    ).thenReturn(null);

    when(
      () => mockLocalNotifications.initialize(
        any(),
        onDidReceiveNotificationResponse: any(
          named: 'onDidReceiveNotificationResponse',
        ),
      ),
    ).thenAnswer((_) async => true);

    service = TestableNotificationService(
      messaging: mockFirebaseMessaging,
      localNotifications: mockLocalNotifications,
      goRouter: mockRouter,
      onMessageController: onMessageController,
      onMessageOpenedAppController: onMessageOpenedAppController,
    );
  });

  tearDown(() {
    onMessageController.close();
    onMessageOpenedAppController.close();
  });

  test(
    'muestra notificación local cuando llega un mensaje con notification',
    () async {
      await service.init();

      final message = RemoteMessage(
        notification: const RemoteNotification(title: 'Hola', body: 'Mundo'),
        data: {'deeplink': '/note/123'},
      );

      onMessageController.add(message);
      await Future.delayed(Duration.zero);

      verify(
        () => mockLocalNotifications.show(
          any(that: isA<int>()),
          'Hola',
          'Mundo',
          any(that: isA<NotificationDetails>()),
          payload: '/note/123',
        ),
      ).called(1);
    },
  );

  test(
    'init solicita permisos, crea canal e inicializa notificaciones',
    () async {
      final mockAndroidLocal = MockAndroidLocalNotifications();

      when(
        () => mockLocalNotifications
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >(),
      ).thenReturn(mockAndroidLocal);

      when(
        () => mockAndroidLocal.createNotificationChannel(any()),
      ).thenAnswer((_) async {});

      when(
        () => mockLocalNotifications.initialize(
          any(),
          onDidReceiveNotificationResponse: any(
            named: 'onDidReceiveNotificationResponse',
          ),
        ),
      ).thenAnswer((_) async => true);

      await service.init();

      verify(
        () => mockLocalNotifications
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >(),
      ).called(1);

      verify(() => mockAndroidLocal.createNotificationChannel(any())).called(1);

      verify(
        () => mockLocalNotifications.initialize(
          any(),
          onDidReceiveNotificationResponse: any(
            named: 'onDidReceiveNotificationResponse',
          ),
        ),
      ).called(1);
    },
  );
}
