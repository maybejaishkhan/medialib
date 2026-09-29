import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import 'package:medialib/core/database/app_database.dart';
import 'package:medialib/core/router/routes.dart';
import 'package:medialib/features/history/presentation/history_format.dart';
import 'package:medialib/features/history/presentation/history_providers.dart';
import 'package:medialib/features/history/presentation/widgets/history_entry_row.dart';

/// A timeline of everything watched, read, played, and listened to.
class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timeline = ref.watch(historyTimelineProvider);

    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: timeline.when(
        data: (entries) => entries.isEmpty
            ? const _EmptyHistory()
            : _Timeline(entries: entries),
        loading: () => const Center(child: FCircularProgress()),
        error: (error, stackTrace) => _HistoryError(error: error),
      ),
    );
  }
}

class _Timeline extends StatelessWidget {
  const _Timeline({required this.entries});

  final List<(HistoryEntry, MediaItem)> entries;

  @override
  Widget build(BuildContext context) {
    // Entries arrive newest first, so grouping preserves that order.
    final groups = <DateTime, List<(HistoryEntry, MediaItem)>>{};
    for (final record in entries) {
      final day = DateUtils.dateOnly(record.$1.occurredAt);
      groups.putIfAbsent(day, () => []).add(record);
    }
    final days = groups.keys.toList();

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 24),
      itemCount: days.length,
      itemBuilder: (context, index) {
        final day = days[index];
        final dayEntries = groups[day]!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.only(top: index == 0 ? 0 : 20, bottom: 6),
              child: Text(
                dayLabel(day),
                style: context.theme.typography.display.xs.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            for (final record in dayEntries)
              HistoryEntryRow(
                entry: record.$1,
                title: record.$2.title,
                onTap: () => context.push(AppRoutes.editorWithId(record.$2.id)),
              ),
          ],
        );
      },
    );
  }
}

class _EmptyHistory extends StatelessWidget {
  const _EmptyHistory();

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
              FLucideIcons.history,
              size: 44,
              color: theme.colors.mutedForeground,
            ),
            const SizedBox(height: 16),
            Text(
              'No history yet',
              style: theme.typography.display.sm.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Status changes and progress updates will appear here as you use '
              'your library.',
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

class _HistoryError extends StatelessWidget {
  const _HistoryError({required this.error});

  final Object error;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Center(
      child: Text(
        'Could not load history: $error',
        textAlign: TextAlign.center,
        style: theme.typography.body.sm.copyWith(color: theme.colors.error),
      ),
    );
  }
}
