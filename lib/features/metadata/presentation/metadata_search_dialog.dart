import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:material_ui/material_ui.dart';

import 'package:medialib/core/database/enums.dart';
import 'package:medialib/features/metadata/domain/media_metadata.dart';
import 'package:medialib/features/metadata/presentation/metadata_providers.dart';
import 'package:medialib/features/metadata/presentation/widgets/metadata_result_tile.dart';

/// Opens a dialog for searching external metadata providers.
///
/// Returns the result the user picked, or null if the dialog was dismissed.
Future<MetadataSearchResult?> showMetadataSearchDialog(
  BuildContext context, {
  required MediaType type,
  String initialQuery = '',
}) => showFDialog<MetadataSearchResult>(
  context: context,
  builder: (context, style, animation) => FDialog(
    animation: animation,
    builder: (context, style) =>
        _MetadataSearchBody(type: type, initialQuery: initialQuery),
  ),
);

class _MetadataSearchBody extends ConsumerStatefulWidget {
  const _MetadataSearchBody({required this.type, required this.initialQuery});

  final MediaType type;
  final String initialQuery;

  @override
  ConsumerState<_MetadataSearchBody> createState() =>
      _MetadataSearchBodyState();
}

class _MetadataSearchBodyState extends ConsumerState<_MetadataSearchBody> {
  late final TextEditingController _controller;
  Future<List<MetadataSearchResult>>? _search;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialQuery);
    if (widget.initialQuery.trim().isNotEmpty) {
      _runSearch();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _runSearch() {
    final query = _controller.text.trim();
    if (query.isEmpty) return;
    setState(() {
      _search = ref
          .read(metadataServiceProvider)
          .search(query, type: widget.type);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final providers = ref
        .read(metadataServiceProvider)
        .providersFor(widget.type);

    return SizedBox(
      width: 520,
      height: 460,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 12,
        children: [
          Text(
            'Find metadata',
            style: theme.typography.display.xs.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            providers.isEmpty
                ? 'No metadata source is available for ${widget.type.label} yet.'
                : 'Sources: ${providers.map((p) => p.name).join(', ')}',
            style: theme.typography.body.xs.copyWith(
              color: theme.colors.mutedForeground,
            ),
          ),
          if (providers.isNotEmpty)
            Row(
              spacing: 8,
              children: [
                Expanded(
                  child: FTextField(
                    control: FTextFieldControl.managed(controller: _controller),
                    hint: 'Title or creator',
                    autofocus: true,
                    onSubmit: (_) => _runSearch(),
                  ),
                ),
                FButton(onPress: _runSearch, child: const Text('Search')),
              ],
            ),
          const FDivider(),
          Expanded(child: _results(theme, providers.isNotEmpty)),
        ],
      ),
    );
  }

  Widget _results(FThemeData theme, bool hasProviders) {
    if (!hasProviders) {
      return Center(
        child: Icon(
          FLucideIcons.search,
          size: 40,
          color: theme.colors.mutedForeground,
        ),
      );
    }
    final search = _search;
    if (search == null) {
      return Center(
        child: Text(
          'Enter a title and press Search.',
          style: theme.typography.body.sm.copyWith(
            color: theme.colors.mutedForeground,
          ),
        ),
      );
    }
    return FutureBuilder<List<MetadataSearchResult>>(
      future: search,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: FCircularProgress());
        }
        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Search failed: ${snapshot.error}',
              textAlign: TextAlign.center,
              style: theme.typography.body.sm.copyWith(
                color: theme.colors.error,
              ),
            ),
          );
        }
        final results = snapshot.data ?? const [];
        if (results.isEmpty) {
          return Center(
            child: Text(
              'No matches found.',
              style: theme.typography.body.sm.copyWith(
                color: theme.colors.mutedForeground,
              ),
            ),
          );
        }
        return ListView.separated(
          itemCount: results.length,
          separatorBuilder: (context, index) => const FDivider(),
          itemBuilder: (context, index) {
            final result = results[index];
            return MetadataResultTile(
              result: result,
              onTap: () => Navigator.of(context).pop(result),
            );
          },
        );
      },
    );
  }
}
