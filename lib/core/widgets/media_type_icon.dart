import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

import 'package:medialib/core/database/enums.dart';

/// The icon shown for a media type when no cover image is available.
IconData mediaTypeIcon(MediaType type) => switch (type) {
  MediaType.book => FLucideIcons.bookOpen,
  MediaType.comic => FLucideIcons.library,
  MediaType.manga => FLucideIcons.scroll,
  MediaType.anime => FLucideIcons.tv,
  MediaType.movie => FLucideIcons.clapperboard,
  MediaType.tv => FLucideIcons.tv,
  MediaType.game => FLucideIcons.gamepad2,
  MediaType.music => FLucideIcons.music,
};
