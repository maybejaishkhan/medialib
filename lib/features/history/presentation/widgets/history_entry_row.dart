import 'package:forui/forui.dart';
import 'package:material_ui/material_ui.dart';

import 'package:medialib/core/database/app_database.dart';
import 'package:medialib/core/database/enums.dart';
import 'package:medialib/features/history/presentation/history_format.dart';

/// The icon representing a history event.
IconData historyEventIcon(HistoryEventType type) => switch (type) {
  HistoryEventType.started => FLucideIcons.circlePlay,
  HistoryEventType.progressed => FLucideIcons.trendingUp,
  HistoryEventType.completed => FLucideIcons.circleCheck,
  HistoryEventType.paused => FLucideIcons.circlePause,
  HistoryEventType.dropped => FLucideIcons.circleX,
  HistoryEventType.rated => FLucideIcons.star,
  HistoryEventType.noted => FLucideIcons.pencil,
};

/// A short description of what happened in [entry].
String describeHistoryEvent(HistoryEntry entry) => switch (entry.eventType) {
  HistoryEventType.started => 'Started',
  HistoryEventType.progressed =>
    entry.progress != null ? 'Progressed to ${entry.progress}' : 'Progressed',
  HistoryEventType.completed => 'Completed',
  HistoryEventType.paused => 'Paused',
  HistoryEventType.dropped => 'Dropped',
  HistoryEventType.rated =>
    entry.rating != null ? 'Rated ${_formatRating(entry.rating!)}' : 'Rated',
  HistoryEventType.noted =>
    (entry.note?.isNotEmpty ?? false) ? entry.note! : 'Note',
};

/// A single row in the consumption history.
///
/// When [title] is provided it is shown above the event description; the
/// timeline passes the media title, while an entry's own history omits it.
class HistoryEntryRow extends StatelessWidget {
  const HistoryEntryRow({
    super.key,
    required this.entry,
    this.title,
    this.onTap,
    this.showDateTime = false,
  });

  final HistoryEntry entry;
  final String? title;
  final VoidCallback? onTap;
  final bool showDateTime;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final note = entry.eventType != HistoryEventType.noted ? entry.note : null;

    return FTappable(
      onPress: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        child: Row(
          spacing: 12,
          children: [
            SizedBox(
              width: 36,
              height: 36,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: theme.colors.muted,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  historyEventIcon(entry.eventType),
                  size: 17,
                  color: theme.colors.mutedForeground,
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (title case final title?)
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.typography.body.md.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  Text(
                    describeHistoryEvent(entry),
                    style: theme.typography.body.sm.copyWith(
                      color: title == null
                          ? theme.colors.foreground
                          : theme.colors.mutedForeground,
                    ),
                  ),
                  if (note != null && note.isNotEmpty)
                    Text(
                      note,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.typography.body.xs.copyWith(
                        color: theme.colors.mutedForeground,
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(
              showDateTime
                  ? dateTimeLabel(entry.occurredAt)
                  : timeLabel(entry.occurredAt),
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

String _formatRating(double rating) =>
    rating % 1 == 0 ? rating.toInt().toString() : rating.toString();
