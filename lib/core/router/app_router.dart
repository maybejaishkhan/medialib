import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:medialib/core/router/routes.dart';
import 'package:medialib/features/history/presentation/history_screen.dart';
import 'package:medialib/features/library/presentation/library_screen.dart';
import 'package:medialib/features/library/presentation/media_editor_screen.dart';
import 'package:medialib/features/metadata/domain/media_metadata.dart';
import 'package:medialib/features/orders/presentation/orders_screen.dart';
import 'package:medialib/features/search/presentation/search_screen.dart';
import 'package:medialib/features/settings/presentation/settings_screen.dart';
import 'package:medialib/features/shell/app_shell.dart';

/// Provides the application's single [GoRouter].
///
/// Navigation is centralized here so that deep links and redirects can be
/// added in one place as the app grows.
final appRouterProvider = Provider<GoRouter>((ref) {
  final router = GoRouter(
    initialLocation: AppRoutes.library,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            AppShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.library,
                builder: (context, state) => const LibraryScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.search,
                builder: (context, state) => const SearchScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.history,
                builder: (context, state) => const HistoryScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.orders,
                builder: (context, state) => const OrdersScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.settings,
                builder: (context, state) => const SettingsScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.editor,
        builder: (context, state) => MediaEditorScreen(
          initialMetadata: state.extra is MetadataSearchResult
              ? state.extra as MetadataSearchResult
              : null,
        ),
      ),
      GoRoute(
        path: '${AppRoutes.editor}/:id',
        builder: (context, state) =>
            MediaEditorScreen(mediaItemId: state.pathParameters['id']),
      ),
    ],
  );

  ref.onDispose(router.dispose);
  return router;
});
