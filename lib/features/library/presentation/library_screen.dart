import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import 'package:medialib/core/database/app_database.dart';
import 'package:medialib/core/router/routes.dart';
import 'package:medialib/core/widgets/media_list_tile.dart';
import 'package:medialib/core/widgets/view_layout.dart';
import 'package:medialib/features/library/presentation/library_providers.dart';
import 'package:medialib/features/library/presentation/widgets/library_toolbar.dart';
import 'package:medialib/features/library/presentation/widgets/media_card.dart';

/// Browse and manage the unified media library.
class LibraryScreen extends ConsumerWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(libraryFilterProvider);
    final items = ref.watch(libraryItemsProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 16),
        const LibraryToolbar(),
        const SizedBox(height: 16),
        Expanded(
          child: items.when(
            data: (items) => items.isEmpty
                ? _EmptyLibrary(filtered: filter.hasFilters)
                : switch (filter.layout) {
                    ViewLayout.grid => _LibraryGrid(items: items),
                    ViewLayout.list => _LibraryList(items: items),
                  },
            loading: () => const Center(child: FCircularProgress()),
            error: (error, stackTrace) => _ErrorState(error: error),
          ),
        ),
      ],
    );
  }
}

class _LibraryGrid extends StatelessWidget {
  const _LibraryGrid({required this.items});

  final List<MediaItem> items;

  @override
  Widget build(BuildContext context) => GridView.builder(
    padding: const EdgeInsets.only(top: 4, bottom: 24),
    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: 220,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      mainAxisExtent: 280,
    ),
    itemCount: items.length,
    itemBuilder: (context, index) {
      final item = items[index];
      return MediaCard(
        item: item,
        onTap: () => context.push(AppRoutes.editorWithId(item.id)),
      );
    },
  );
}

class _LibraryList extends StatelessWidget {
  const _LibraryList({required this.items});

  final List<MediaItem> items;

  @override
  Widget build(BuildContext context) => ListView.separated(
    padding: const EdgeInsets.only(top: 4, bottom: 24),
    itemCount: items.length,
    separatorBuilder: (context, index) => const FDivider(),
    itemBuilder: (context, index) {
      final item = items[index];
      return MediaListTile(
        item: item,
        onTap: () => context.push(AppRoutes.editorWithId(item.id)),
      );
    },
  );
}

class _EmptyLibrary extends StatelessWidget {
  const _EmptyLibrary({required this.filtered});

  final bool filtered;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              filtered ? FLucideIcons.search : FLucideIcons.library,
              size: 44,
              color: theme.colors.mutedForeground,
            ),
            const SizedBox(height: 16),
            Text(
              filtered ? 'No matches' : 'Your library is empty',
              textAlign: TextAlign.center,
              style: theme.typography.display.sm.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              filtered
                  ? 'Try a different search term or clear the filters.'
                  : 'Add your first entry to start building your library.',
              textAlign: TextAlign.center,
              style: theme.typography.body.sm.copyWith(
                color: theme.colors.mutedForeground,
              ),
            ),
            if (!filtered) ...[
              const SizedBox(height: 20),
              FButton(
                onPress: () => context.push(AppRoutes.editor),
                prefix: const Icon(FLucideIcons.plus),
                child: const Text('Add entry'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.error});

  final Object error;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(FLucideIcons.circleAlert, size: 44, color: theme.colors.error),
            const SizedBox(height: 16),
            Text(
              'Could not load your library',
              style: theme.typography.display.sm.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '$error',
              textAlign: TextAlign.center,
              style: theme.typography.body.sm.copyWith(
                color: theme.colors.mutedForeground,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
