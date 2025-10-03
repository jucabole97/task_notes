import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:task_notes_app/task_notes.dart';

class MainMock {
  static Future<void> pumpApp(
    WidgetTester tester, {
    String initialLocation = '/',
    Widget? loader,
    bool isDarkMode = false,
    Widget? element,
  }) async {
    await setupDependencies(useFake: true);
    if (element != null) {
      await tester.pumpWidget(
        MaterialApp(
          theme: isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme,
          home: Scaffold(body: element),
        ),
      );
      await tester.pumpAndSettle();
      return;
    }

    await tester.pumpWidget(
      MaterialApp.router(
        routerConfig: _getGoRouter(initialLocation, loader),
        theme: isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme,
      ),
    );
    await tester.pumpAndSettle();
  }

  static GoRouter _getGoRouter(String initialLocation, Widget? loader) {
    return GoRouter(
      initialLocation: initialLocation,
      routes: [
        GoRoute(
          path: '/',
          builder: (_, __) => ChangeNotifierProvider(
            create: (_) => SplashNotifier(sl())..fetchToken(),
            child: SplashScreen(loader: loader),
          ),
        ),
        GoRoute(
          path: '/home',
          builder: (_, __) => ChangeNotifierProvider(
            create: (_) => ItemListNotifier(sl())..loadItems(),
            child: const HomeScreen(),
          ),
        ),
        GoRoute(
          path: '/patterns-lab',
          builder: (_, __) => const PatternsLabScreen(),
        ),
        GoRoute(
          path: '/note/:id',
          builder: (_, state) {
            final id = state.pathParameters['id']!;
            return ChangeNotifierProvider(
              create: (_) => ItemDetailNotifier(sl())..getItemById(id),
              child: const ItemDetailScreen(isDeeplink: true),
            );
          },
        ),
      ],
      redirect: (context, state) {
        final uri = state.uri;
        if (uri.scheme == 'task-notes-app' && uri.host == 'note') {
          final id = uri.pathSegments.isNotEmpty
              ? uri.pathSegments.first
              : null;
          if (id != null) return '/note/$id';
        }
        return null;
      },
      errorPageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const Scaffold(body: Text('404')),
      ),
    );
  }
}
