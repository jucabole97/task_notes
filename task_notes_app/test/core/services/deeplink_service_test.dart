import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task_notes_app/core/services/deeplink_service.dart';

class MockGoRouter extends Mock implements GoRouter {}

class FakeAppLinks extends Fake implements AppLinks {
  final StreamController<Uri> controller = StreamController<Uri>();

  @override
  Stream<Uri> get uriLinkStream => controller.stream;
}

void main() {
  late MockGoRouter mockGoRouter;
  late FakeAppLinks fakeAppLinks;
  late DeeplinkService service;

  setUp(() {
    mockGoRouter = MockGoRouter();
    fakeAppLinks = FakeAppLinks();
    service = DeeplinkService(
      appLinksTest: fakeAppLinks,
      goRouterTest: mockGoRouter,
    );
    service.init();
  });

  tearDown(() {
    fakeAppLinks.controller.close();
  });

  test('navega a /note/:id cuando recibe un deeplink válido', () async {
    fakeAppLinks.controller.add(Uri.parse('task-notes-app://note/123'));

    await Future.delayed(Duration.zero);

    verify(() => mockGoRouter.go('/note/123')).called(1);
  });

  test('ignora URIs que no son de note', () async {
    fakeAppLinks.controller.add(Uri.parse('task-notes-app://other/456'));

    await Future.delayed(Duration.zero);

    verifyNever(() => mockGoRouter.go(any()));
  });
}
