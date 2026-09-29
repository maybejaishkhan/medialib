import 'package:flutter/foundation.dart';
import 'package:forui/forui.dart';

/// Reads an application theme from Forui's built-in neutral palette.
///
/// Forui ships separate variants for touch and desktop (keyboard/mouse)
/// platforms, so callers must indicate which one to use.
FThemeData buildForuiTheme({
  required Brightness brightness,
  required bool touch,
}) {
  final base = brightness == Brightness.dark
      ? FTheme.neutral.dark
      : FTheme.neutral.light;
  return touch ? base.touch : base.desktop;
}

/// Whether [platform] (defaulting to [defaultTargetPlatform]) should use
/// Forui's touch-oriented styling.
bool useTouchLayout([TargetPlatform? platform]) {
  return switch (platform ?? defaultTargetPlatform) {
    TargetPlatform.android ||
    TargetPlatform.iOS ||
    TargetPlatform.fuchsia => true,
    _ => false,
  };
}

/// Maps the current platform to a [FPlatformVariant] so Forui widgets can
/// adapt their styling and interaction model.
FPlatformVariant currentPlatformVariant([TargetPlatform? platform]) {
  if (kIsWeb) {
    return FPlatformVariant.web;
  }
  return switch (platform ?? defaultTargetPlatform) {
    TargetPlatform.android => FPlatformVariant.android,
    TargetPlatform.iOS => FPlatformVariant.iOS,
    TargetPlatform.fuchsia => FPlatformVariant.fuchsia,
    TargetPlatform.windows => FPlatformVariant.windows,
    TargetPlatform.macOS => FPlatformVariant.macOS,
    TargetPlatform.linux => FPlatformVariant.linux,
  };
}
