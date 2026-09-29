import 'package:forui/forui.dart';
import 'package:material_ui/material_ui.dart';

import 'package:medialib/core/database/enums.dart';

/// A small coloured badge describing an entry's [MediaStatus].
class MediaStatusBadge extends StatelessWidget {
  const MediaStatusBadge({super.key, required this.status});

  final MediaStatus status;

  @override
  Widget build(BuildContext context) {
    final variant = switch (status) {
      MediaStatus.planned => FBadgeVariant.outline,
      MediaStatus.inProgress => FBadgeVariant.secondary,
      MediaStatus.completed => FBadgeVariant.primary,
      MediaStatus.onHold => FBadgeVariant.outline,
      MediaStatus.dropped => FBadgeVariant.destructive,
    };
    return FBadge(variant: variant, child: Text(status.label));
  }
}
