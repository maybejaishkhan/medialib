import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:material_ui/material_ui.dart';

import 'package:medialib/core/router/app_router.dart';
import 'package:medialib/core/theme/app_theme.dart';
import 'package:medialib/core/theme/theme_controller.dart';

/// The root of the MediaLib application.
class MediaLibApp extends ConsumerWidget {
  const MediaLibApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final themeMode = ref.watch(themeControllerProvider);
    final touch = useTouchLayout();
    final platform = currentPlatformVariant();

    return MaterialApp.router(
      title: 'MediaLib',
      debugShowCheckedModeBanner: false,
      theme: buildForuiTheme(
        brightness: Brightness.light,
        touch: touch,
      ).toApproximateMaterialTheme(),
      darkTheme: buildForuiTheme(
        brightness: Brightness.dark,
        touch: touch,
      ).toApproximateMaterialTheme(),
      themeMode: themeMode,
      routerConfig: router,
      localizationsDelegates: FLocalizations.localizationsDelegates,
      supportedLocales: FLocalizations.supportedLocales,
      builder: (context, child) {
        // Resolve the concrete Forui theme from the effective brightness after
        // the Material theme mode has been applied.
        final data = buildForuiTheme(
          brightness: Theme.of(context).brightness,
          touch: touch,
        );
        return FTheme(
          data: data,
          platform: platform,
          child: FToaster(
            child: FTooltipGroup(child: child ?? const SizedBox.shrink()),
          ),
        );
      },
    );
  }
}
