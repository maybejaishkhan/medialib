import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Persists and exposes the user's chosen [ThemeMode].
///
/// The value is stored with [SharedPreferencesAsync] so it is available on the
/// next launch. Until the stored value is read, the app follows the system
/// brightness.
class ThemeController extends Notifier<ThemeMode> {
  static const _prefsKey = 'theme_mode';

  @override
  ThemeMode build() {
    // Fire-and-forget load; the provider is refreshed once the value arrives.
    _restore();
    return ThemeMode.system;
  }

  Future<void> _restore() async {
    try {
      final stored = await SharedPreferencesAsync().getString(_prefsKey);
      if (stored == null) return;
      for (final mode in ThemeMode.values) {
        if (mode.name == stored && mode != state) {
          state = mode;
          return;
        }
      }
    } catch (_) {
      // Preferences are unavailable (e.g. in tests); keep the system default.
    }
  }

  /// Sets [mode] and persists it.
  Future<void> setMode(ThemeMode mode) async {
    if (mode == state) return;
    state = mode;
    try {
      await SharedPreferencesAsync().setString(_prefsKey, mode.name);
    } catch (_) {
      // Persisting the preference is best-effort.
    }
  }

  /// Cycles between light and dark, using [currentBrightness] as the starting
  /// point when the mode is [ThemeMode.system].
  Future<void> toggle(Brightness currentBrightness) {
    final next = currentBrightness == Brightness.dark
        ? ThemeMode.light
        : ThemeMode.dark;
    return setMode(next);
  }
}

/// Provides the current [ThemeMode].
final themeControllerProvider = NotifierProvider<ThemeController, ThemeMode>(
  ThemeController.new,
);
