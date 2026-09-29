import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import 'package:medialib/core/database/enums.dart';
import 'package:medialib/core/router/routes.dart';
import 'package:medialib/core/widgets/view_layout.dart';
import 'package:medialib/features/metadata/domain/media_metadata.dart';
import 'package:medialib/features/metadata/presentation/metadata_providers.dart';
import 'package:medialib/features/metadata/presentation/widgets/metadata_result_card.dart';
import 'package:medialib/features/metadata/presentation/widgets/metadata_result_tile.dart';
import 'package:medialib/features/search/presentation/search_providers.dart';

/// Searches external metadata sources and adds results to the library.
class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(sourceSearchProvider);
    final controller = ref.read(sourceSearchProvider.notifier);
    final providers = ref
        .watch(metadataServiceProvider)
        .providersFor(state.mediaType);

    final typeSelect = FSelect<MediaType>(
      items: {for (final type in MediaType.values) type.pluralLabel: type},
      control: FSelectControl.managed(
        initial: state.mediaType,
        onChange: (value) {
          if (value != null) controller.setMediaType(value);
        },
      ),
      label: const Text('Media type'),
    );

    final sourceSelect = FSelect<String?>(
      key: ValueKey('source-search-${state.mediaType}'),
      items: {
        'All sources': null,
        for (final provider in providers) provider.name: provider.id,
      },
      control: FSelectControl.managed(
        initial: state.sourceId,
        onChange: controller.setSource,
      ),
      label: const Text('Source'),
    );

    final searchField = FTextField(
      key: const ValueKey('source-search-field'),
      control: FTextFieldControl.managed(
        controller: _controller,
        onChange: (value) => controller.setQuery(value.text),
      ),
      hint: 'Search ${state.mediaType.pluralLabel.toLowerCase()}',
      onSubmit: (_) => controller.search(),
      clearable: (value) => value.text.isNotEmpty,
    );

    final searchButton = FButton(
      onPress: state.loading ? null : controller.search,
      prefix: const Icon(FLucideIcons.search),
      child: const Text('Search'),
    );

    final layoutButton = FButton.icon(
      variant: FButtonVariant.outline,
      onPress: () => controller.setLayout(
        state.layout == ViewLayout.grid ? ViewLayout.list : ViewLayout.grid,
      ),
      child: Icon(
        state.layout == ViewLayout.grid
            ? FLucideIcons.list
            : FLucideIcons.layoutGrid,
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 760) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 12,
                children: [
                  searchField,
                  Row(
                    spacing: 12,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(child: typeSelect),
                      Expanded(child: sourceSelect),
                    ],
                  ),
                  Row(spacing: 12, children: [layoutButton, searchButton]),
                ],
              );
            }
            return Row(
              spacing: 12,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(child: searchField),
                SizedBox(width: 180, child: typeSelect),
                SizedBox(width: 200, child: sourceSelect),
                layoutButton,
                searchButton,
              ],
            );
          },
        ),
        const SizedBox(height: 16),
        Expanded(child: _results(context, state, providers.isEmpty)),
      ],
    );
  }

  Widget _results(
    BuildContext context,
    SourceSearchState state,
    bool noProviders,
  ) {
    final theme = context.theme;
    if (state.loading) {
      return const Center(child: FCircularProgress());
    }
    if (state.error case final error?) {
      return Center(
        child: Text(
          error,
          textAlign: TextAlign.center,
          style: theme.typography.body.sm.copyWith(color: theme.colors.error),
        ),
      );
    }
    if (!state.hasSearched) {
      return _SearchPrompt(
        mediaType: state.mediaType,
        noProviders: noProviders,
      );
    }
    if (state.results.isEmpty) {
      return _NoMatches(query: state.query);
    }
    return switch (state.layout) {
      ViewLayout.grid => _ResultsGrid(results: state.results),
      ViewLayout.list => _ResultsList(results: state.results),
    };
  }
}

class _ResultsGrid extends StatelessWidget {
  const _ResultsGrid({required this.results});

  final List<MetadataSearchResult> results;

  @override
  Widget build(BuildContext context) => GridView.builder(
    padding: const EdgeInsets.only(bottom: 24),
    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: 200,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      mainAxisExtent: 260,
    ),
    itemCount: results.length,
    itemBuilder: (context, index) {
      final result = results[index];
      return MetadataResultCard(
        result: result,
        onTap: () => context.push(AppRoutes.editor, extra: result),
      );
    },
  );
}

class _ResultsList extends StatelessWidget {
  const _ResultsList({required this.results});

  final List<MetadataSearchResult> results;

  @override
  Widget build(BuildContext context) => ListView.separated(
    padding: const EdgeInsets.only(bottom: 24),
    itemCount: results.length,
    separatorBuilder: (context, index) => const FDivider(),
    itemBuilder: (context, index) {
      final result = results[index];
      return MetadataResultTile(
        result: result,
        onTap: () => context.push(AppRoutes.editor, extra: result),
      );
    },
  );
}

class _SearchPrompt extends StatelessWidget {
  const _SearchPrompt({required this.mediaType, required this.noProviders});

  final MediaType mediaType;
  final bool noProviders;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 460),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              noProviders ? FLucideIcons.circleAlert : FLucideIcons.telescope,
              size: 44,
              color: theme.colors.mutedForeground,
            ),
            const SizedBox(height: 16),
            Text(
              noProviders
                  ? 'No source for ${mediaType.pluralLabel} yet'
                  : 'Search metadata sources',
              textAlign: TextAlign.center,
              style: theme.typography.display.sm.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              noProviders
                  ? 'Metadata providers for this media type are not available '
                        'yet. Check Settings for provider keys.'
                  : 'Look up ${mediaType.pluralLabel.toLowerCase()} in external '
                        'services and add a match straight to your library.',
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

class _NoMatches extends StatelessWidget {
  const _NoMatches({required this.query});

  final String query;

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
              FLucideIcons.circleAlert,
              size: 44,
              color: theme.colors.mutedForeground,
            ),
            const SizedBox(height: 16),
            Text(
              'No matches for “$query”',
              textAlign: TextAlign.center,
              style: theme.typography.display.sm.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Try a different spelling or another source.',
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
