import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:material_ui/material_ui.dart';

import 'package:medialib/features/metadata/domain/media_metadata.dart';
import 'package:medialib/features/metadata/presentation/metadata_providers.dart';

/// A grid card for a provider result, showing its thumbnail image.
class MetadataResultCard extends ConsumerWidget {
  const MetadataResultCard({
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
      child: FCard(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(child: _Thumbnail(url: result.thumbnailUrl)),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    result.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.typography.body.sm.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (details.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      details,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.typography.body.xs.copyWith(
                        color: theme.colors.mutedForeground,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Thumbnail extends StatelessWidget {
  const _Thumbnail({required this.url});

  final String? url;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final placeholder = ColoredBox(
      color: theme.colors.muted,
      child: Center(
        child: Icon(
          FLucideIcons.image,
          size: 32,
          color: theme.colors.mutedForeground,
        ),
      ),
    );

    final url = this.url;
    if (url == null || url.isEmpty) return placeholder;
    return Image.network(
      url,
      fit: BoxFit.cover,
      width: double.infinity,
      errorBuilder: (context, error, stackTrace) => placeholder,
      loadingBuilder: (context, child, progress) =>
          progress == null ? child : placeholder,
    );
  }
}
