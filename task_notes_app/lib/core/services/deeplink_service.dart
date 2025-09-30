import 'package:app_links/app_links.dart';
import 'package:task_notes_app/task_notes.dart';

class DeeplinkService {
  late final AppLinks _appLinks;

  Future<void> init() async {
    _appLinks = AppLinks();

    // Escuchar links mientras la app está abierta
    _appLinks.uriLinkStream.listen((uri) {
      _handleUri(uri);
    });
  }

  void _handleUri(Uri uri) {
    if (uri.host == 'note' && uri.pathSegments.isNotEmpty) {
      final id = uri.pathSegments.first;
      router.go('/note/$id');
    }
  }
}
