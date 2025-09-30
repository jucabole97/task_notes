import 'package:app_links/app_links.dart';
import 'package:go_router/go_router.dart';
import 'package:task_notes_app/task_notes.dart';

class DeeplinkService {
  final AppLinks appLinks;
  final GoRouter goRouter;

  DeeplinkService({AppLinks? appLinksTest, GoRouter? goRouterTest})
    : appLinks = appLinksTest ?? AppLinks(),
      goRouter = goRouterTest ?? router;

  Future<void> init() async {
    // Escuchar links mientras la app está abierta
    appLinks.uriLinkStream.listen((uri) {
      _handleUri(uri);
    });
  }

  void _handleUri(Uri uri) {
    if (uri.host == 'note' && uri.pathSegments.isNotEmpty) {
      final id = uri.pathSegments.first;
      goRouter.go('/note/$id');
    }
  }
}
