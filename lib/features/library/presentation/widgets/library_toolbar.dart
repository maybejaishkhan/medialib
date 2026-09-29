import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import 'package:medialib/core/database/enums.dart';
import 'package:medialib/core/router/routes.dart';
import 'package:medialib/core/widgets/view_layout.dart';
import 'package:medialib/features/library/presentation/library_providers.dart';

/// Search, filters, layout toggle, and the "add entry" action.
class LibraryToolbar extends ConsumerStatefulWidget {
  const LibraryToolbar({super.key});

  @override
  ConsumerState<LibraryToolbar> createState() => _LibraryToolbarState();
}

class _LibraryToolbarState extends ConsumerState<LibraryToolbar> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filter = ref.watch(libraryFilterProvider);
    final notifier = ref.read(libraryFilterProvider.notifier);

    final search = FTextField(
      control: FTextFieldControl.managed(
        controller: _searchController,
        onChange: (value) => notifier.setQuery(value.text),
      ),
      hint: 'Search titles and creators',
      clearable: (value) => value.text.isNotEmpty,
    );

    final typeSelect = FSelect<MediaType?>(
      key: ValueKey(filter.mediaType),
      items: {
        'All types': null,
        for (final type in MediaType.values) type.pluralLabel: type,
      },
      control: FSelectControl.managed(
        initial: filter.mediaType,
        onChange: notifier.setMediaType,
      ),
      label: const Text('Type'),
    );

    final statusSelect = FSelect<MediaStatus?>(
      key: ValueKey(filter.status),
      items: {
        'Any status': null,
        for (final status in MediaStatus.values) status.label: status,
      },
      control: FSelectControl.managed(
        initial: filter.status,
        onChange: notifier.setStatus,
      ),
      label: const Text('Status'),
    );

    final clearButton = FButton.icon(
      variant: FButtonVariant.ghost,
      onPress: filter.hasFilters
          ? () {
              _searchController.clear();
              notifier.clear();
            }
          : null,
      child: Icon(FLucideIcons.circleX),
    );

    final layoutButton = FButton.icon(
      variant: FButtonVariant.outline,
      onPress: () => notifier.setLayout(
        filter.layout == ViewLayout.grid ? ViewLayout.list : ViewLayout.grid,
      ),
      child: Icon(
        filter.layout == ViewLayout.grid
            ? FLucideIcons.list
            : FLucideIcons.layoutGrid,
      ),
    );

    final addButton = FButton(
      onPress: () => context.push(AppRoutes.editor),
      prefix: const Icon(FLucideIcons.plus),
      child: const Text('Add'),
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 720) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 12,
            children: [
              Row(
                spacing: 8,
                children: [
                  Expanded(child: search),
                  clearButton,
                ],
              ),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                crossAxisAlignment: WrapCrossAlignment.end,
                children: [
                  SizedBox(width: 160, child: typeSelect),
                  SizedBox(width: 160, child: statusSelect),
                  layoutButton,
                  addButton,
                ],
              ),
            ],
          );
        }

        return Row(
          spacing: 12,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(child: search),
            SizedBox(width: 170, child: typeSelect),
            SizedBox(width: 170, child: statusSelect),
            clearButton,
            layoutButton,
            addButton,
          ],
        );
      },
    );
  }
}
