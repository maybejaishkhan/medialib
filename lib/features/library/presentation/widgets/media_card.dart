import 'package:forui/forui.dart';
import 'package:material_ui/material_ui.dart';

import 'package:medialib/core/database/app_database.dart';
import 'package:medialib/core/widgets/media_status_badge.dart';
import 'package:medialib/core/widgets/media_type_icon.dart';

/// A grid card summarising a library entry.
class MediaCard extends StatelessWidget {
  const MediaCard({super.key, required this.item, required this.onTap});

  final MediaItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return FTappable(
      onPress: onTap,
      child: FCard(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ColoredBox(
                color: theme.colors.muted,
                child: Center(
                  child: Icon(
                    mediaTypeIcon(item.mediaType),
                    size: 40,
                    color: theme.colors.mutedForeground,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.typography.body.md.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (item.creators case final creators?) ...[
                    const SizedBox(height: 2),
                    Text(
                      creators,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.typography.body.xs.copyWith(
                        color: theme.colors.mutedForeground,
                      ),
                    ),
                  ],
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Flexible(child: MediaStatusBadge(status: item.status)),
                      const Spacer(),
                      if (progressLabel(item) case final label?)
                        Text(
                          label,
                          style: theme.typography.body.xs.copyWith(
                            color: theme.colors.mutedForeground,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The progress text for an entry, or null if there is no progress to show.
String? progressLabel(MediaItem item) {
  if (item.totalProgress != null) {
    return '${item.progress}/${item.totalProgress}';
  }
  if (item.progress > 0) {
    return '${item.progress}';
  }
  return null;
}
