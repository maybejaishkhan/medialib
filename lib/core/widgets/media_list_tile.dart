import 'package:forui/forui.dart';
import 'package:material_ui/material_ui.dart';

import 'package:medialib/core/database/app_database.dart';
import 'package:medialib/core/widgets/media_status_badge.dart';
import 'package:medialib/core/widgets/media_type_icon.dart';

/// A compact list row summarising a media entry.
class MediaListTile extends StatelessWidget {
  const MediaListTile({super.key, required this.item, required this.onTap});

  final MediaItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final subtitle = [item.mediaType.label, ?item.creators].join(' · ');

    return FTappable(
      onPress: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        child: Row(
          spacing: 12,
          children: [
            SizedBox(
              width: 48,
              height: 48,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: theme.colors.muted,
                  borderRadius: theme.style.borderRadius.md,
                ),
                child: Icon(
                  mediaTypeIcon(item.mediaType),
                  size: 22,
                  color: theme.colors.mutedForeground,
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.typography.body.md.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.typography.body.xs.copyWith(
                      color: theme.colors.mutedForeground,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            MediaStatusBadge(status: item.status),
          ],
        ),
      ),
    );
  }
}
