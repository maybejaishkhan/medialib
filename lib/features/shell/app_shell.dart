import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import 'package:medialib/core/router/navigation.dart';
import 'package:medialib/core/theme/theme_controller.dart';

/// The application shell that hosts the primary navigation.
///
/// On wide screens a sidebar is shown; on narrow (mobile) screens the
/// navigation moves to a bottom bar. Both drive the same [navigationShell], so
/// each tab keeps its own navigation stack.
class AppShell extends ConsumerWidget {
  const AppShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  void _goToBranch(int index) {
    navigationShell.goBranch(
      index,
      // Tapping the active tab resets it to its initial location.
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.sizeOf(context).width;
    final useSidebar = width >= context.theme.breakpoints.md;
    final destination = appDestinations[navigationShell.currentIndex];
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return FScaffold(
      header: FHeader(
        title: Text(destination.label),
        suffixes: [
          FHeaderAction(
            icon: Icon(isDark ? FLucideIcons.sun : FLucideIcons.moon),
            onPress: () => ref
                .read(themeControllerProvider.notifier)
                .toggle(Theme.of(context).brightness),
          ),
        ],
      ),
      sidebar: useSidebar
          ? _AppSidebar(navigationShell: navigationShell)
          : null,
      footer: useSidebar
          ? null
          : FBottomNavigationBar(
              index: navigationShell.currentIndex,
              onChange: _goToBranch,
              children: [
                for (final destination in appDestinations)
                  FBottomNavigationBarItem(
                    icon: Icon(destination.icon),
                    label: Text(destination.label),
                  ),
              ],
            ),
      child: navigationShell,
    );
  }
}

/// The persistent sidebar shown on desktop-sized layouts.
class _AppSidebar extends StatelessWidget {
  const _AppSidebar({required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return FSidebar(
      header: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
        child: Row(
          spacing: 8,
          children: [
            Icon(FLucideIcons.libraryBig, color: theme.colors.primary),
            Text(
              'MediaLib',
              style: theme.typography.display.sm.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      children: [
        FSidebarGroup(
          label: const Text('Browse'),
          children: [
            for (final (index, destination) in appDestinations.indexed)
              FSidebarItem(
                icon: Icon(destination.icon),
                label: Text(destination.label),
                selected: index == navigationShell.currentIndex,
                onPress: () => navigationShell.goBranch(
                  index,
                  initialLocation: index == navigationShell.currentIndex,
                ),
              ),
          ],
        ),
      ],
    );
  }
}
