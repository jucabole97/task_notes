import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:task_notes_app/task_notes.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (_, __) => ChangeNotifierProvider(
        create: (_) => SplashNotifier(sl())..fetchToken(),
        child: SplashScreen(),
      ),
    ),
    GoRoute(
      path: '/home',
      builder: (_, __) => ChangeNotifierProvider(
        create: (_) => ItemListNotifier(sl())..loadItems(),
        child: HomeScreen(),
      ),
    ),
    GoRoute(path: '/patterns-lab', builder: (_, __) => PatternsLabScreen()),
    GoRoute(
      path: '/note/:id',
      builder: (_, state) {
        final id = state.pathParameters['id']!;

        return ChangeNotifierProvider(
          create: (_) => ItemDetailNotifier(sl())..getItemById(id),
          child: ItemDetailScreen(isDeeplink: true),
        );
      },
    ),
  ],
  redirect: (context, state) {
    final uri = state.uri;

    // Si viene con esquema personalizado
    if (uri.scheme == 'task-notes-app' && uri.host == 'note') {
      final id = uri.pathSegments.isNotEmpty ? uri.pathSegments.first : null;
      if (id != null) {
        return '/note/$id'; // redirige a la ruta interna
      }
    }

    return null; // no redirige en otros casos
  },
  errorPageBuilder: (context, state) => MaterialPage(
    key: state.pageKey,
    child: const Scaffold(body: Text('404')),
  ),
);
