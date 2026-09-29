import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:material_ui/material_ui.dart';

import 'package:medialib/features/metadata/domain/media_metadata.dart';
import 'package:medialib/features/metadata/presentation/metadata_providers.dart';

/// A single provider search result: title plus creators/year/source.
class MetadataResultTile extends ConsumerWidget {
  const MetadataResultTile({
    super.key,
    required this.result,
    required this.onTap,
  });

  final MetadataSearchResult result;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final providerName = ref
        .read(metadataServiceProvider)
        .registry
        .byId(result.providerId)
        ?.name;
    final details = [
      ?result.subtitle,
      ?result.year?.toString(),
      ?providerName,
    ].join(' · ');

    return FTappable(
      onPress: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              result.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.typography.body.md.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            if (details.isNotEmpty)
              Text(
                details,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.typography.body.xs.copyWith(
                  color: theme.colors.mutedForeground,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
