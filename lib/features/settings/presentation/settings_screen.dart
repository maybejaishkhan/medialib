import 'dart:io';

import 'package:file_selector/file_selector.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:material_ui/material_ui.dart';

import 'package:medialib/core/database/database_providers.dart';
import 'package:medialib/core/settings/settings_keys.dart';
import 'package:medialib/core/settings/settings_providers.dart';
import 'package:medialib/core/theme/theme_controller.dart';
import 'package:medialib/features/metadata/presentation/metadata_providers.dart';
import 'package:medialib/features/settings/presentation/settings_providers.dart';
import 'package:medialib/features/transfer/presentation/import_mode_dialog.dart';
import 'package:medialib/features/transfer/presentation/transfer_providers.dart';

/// Application settings: appearance, metadata sources, and local data.
class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final _tmdbKey = TextEditingController();
  String _tmdbKeyValue = '';
  bool _keyEdited = false;
  bool _saved = false;
  bool _transferBusy = false;
  String? _transferMessage;

  @override
  void initState() {
    super.initState();
    final existing = ref.read(appSettingsProvider)[SettingsKeys.tmdbApiKey];
    if (existing != null) {
      _tmdbKeyValue = existing;
      _tmdbKey.text = existing;
    }
  }

  @override
  void dispose() {
    _tmdbKey.dispose();
    super.dispose();
  }

  Future<void> _saveTmdbKey() async {
    final value = _tmdbKeyValue.trim();
    await ref
        .read(appSettingsProvider.notifier)
        .set(SettingsKeys.tmdbApiKey, value);
    if (mounted) setState(() => _saved = true);
  }

  Future<void> _exportLibrary() async {
    setState(() {
      _transferBusy = true;
      _transferMessage = null;
    });
    try {
      final json = await ref
          .read(libraryTransferServiceProvider)
          .exportToJson();
      final location = await getSaveLocation(
        suggestedName: 'medialib-export.json',
        acceptedTypeGroups: const [
          XTypeGroup(label: 'JSON', extensions: ['json']),
        ],
      );
      if (location == null) return;
      await File(location.path).writeAsString(json);
      if (mounted) {
        setState(() => _transferMessage = 'Exported to ${location.path}');
      }
    } catch (error) {
      if (mounted) setState(() => _transferMessage = 'Export failed: $error');
    } finally {
      if (mounted) setState(() => _transferBusy = false);
    }
  }

  Future<void> _importLibrary() async {
    final file = await openFile(
      acceptedTypeGroups: const [
        XTypeGroup(label: 'JSON', extensions: ['json']),
      ],
    );
    if (file == null || !mounted) return;

    final mode = await showImportModeDialog(context);
    if (mode == null || !mounted) return;

    setState(() {
      _transferBusy = true;
      _transferMessage = null;
    });
    try {
      final summary = await ref
          .read(libraryTransferServiceProvider)
          .importFromJson(
            await file.readAsString(),
            replace: mode == ImportMode.replace,
          );
      if (mounted) {
        setState(
          () => _transferMessage =
              'Imported ${summary.mediaItems} entries and '
              '${summary.historyEntries} history events.',
        );
      }
    } catch (error) {
      if (mounted) setState(() => _transferMessage = 'Import failed: $error');
    } finally {
      if (mounted) setState(() => _transferBusy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Seed the field once the persisted settings finish loading.
    ref.listen(appSettingsProvider, (previous, next) {
      final key = next[SettingsKeys.tmdbApiKey];
      if (!_keyEdited && key != null && key != _tmdbKeyValue) {
        setState(() {
          _tmdbKeyValue = key;
          _tmdbKey.text = key;
        });
      }
    });

    final themeMode = ref.watch(themeControllerProvider);
    final registry = ref.watch(metadataRegistryProvider);

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 720),
        child: ListView(
          padding: const EdgeInsets.only(top: 16, bottom: 24),
          children: [
            _Section(
              title: 'Appearance',
              child: FSelect<ThemeMode>(
                key: ValueKey(themeMode),
                items: const {
                  'Follow system': ThemeMode.system,
                  'Light': ThemeMode.light,
                  'Dark': ThemeMode.dark,
                },
                control: FSelectControl.managed(
                  initial: themeMode,
                  onChange: (value) {
                    if (value != null) {
                      ref.read(themeControllerProvider.notifier).setMode(value);
                    }
                  },
                ),
                label: const Text('Theme'),
              ),
            ),
            const SizedBox(height: 20),
            _Section(
              title: 'Metadata sources',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 12,
                children: [
                  for (final provider in registry.all)
                    Row(
                      spacing: 8,
                      children: [
                        Icon(
                          FLucideIcons.circleCheck,
                          size: 16,
                          color: context.theme.colors.primary,
                        ),
                        Expanded(
                          child: Text(
                            '${provider.name} · '
                            '${provider.supportedTypes.map((t) => t.pluralLabel).join(', ')}',
                            style: context.theme.typography.body.sm,
                          ),
                        ),
                      ],
                    ),
                  if (registry.byId('tmdb') == null)
                    Text(
                      'Add a TMDB API key to enrich movies and TV.',
                      style: context.theme.typography.body.xs.copyWith(
                        color: context.theme.colors.mutedForeground,
                      ),
                    ),
                  Row(
                    spacing: 8,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: FTextField(
                          control: FTextFieldControl.managed(
                            controller: _tmdbKey,
                            onChange: (value) {
                              _keyEdited = true;
                              _saved = false;
                              _tmdbKeyValue = value.text;
                            },
                          ),
                          label: const Text('TMDB API key'),
                          hint: 'Paste your TMDB API key',
                        ),
                      ),
                      FButton(onPress: _saveTmdbKey, child: const Text('Save')),
                      if (_saved)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            'Saved',
                            style: context.theme.typography.body.xs.copyWith(
                              color: context.theme.colors.primary,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _Section(
              title: 'Local data',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 12,
                children: [
                  _InfoRow(
                    label: 'Database',
                    value: 'medialib (SQLite, on this device)',
                  ),
                  _InfoRow(
                    label: 'Cached metadata',
                    value: ref
                        .watch(cachedMetadataCountProvider)
                        .when(
                          data: (count) =>
                              '$count record${count == 1 ? '' : 's'}',
                          loading: () => '…',
                          error: (error, stackTrace) => 'unavailable',
                        ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: FButton(
                      variant: FButtonVariant.outline,
                      onPress: () =>
                          ref.read(metadataRepositoryProvider).clearAll(),
                      prefix: const Icon(FLucideIcons.trash2),
                      child: const Text('Clear metadata cache'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _Section(
              title: 'Import / export',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 12,
                children: [
                  Text(
                    'Export your whole library to an open JSON file, or import '
                    'one that was exported earlier.',
                    style: context.theme.typography.body.sm.copyWith(
                      color: context.theme.colors.mutedForeground,
                    ),
                  ),
                  Row(
                    spacing: 8,
                    children: [
                      FButton(
                        onPress: _transferBusy ? null : _exportLibrary,
                        prefix: const Icon(FLucideIcons.upload),
                        child: const Text('Export library'),
                      ),
                      FButton(
                        variant: FButtonVariant.outline,
                        onPress: _transferBusy ? null : _importLibrary,
                        prefix: const Icon(FLucideIcons.download),
                        child: const Text('Import library'),
                      ),
                    ],
                  ),
                  if (_transferMessage case final message?)
                    Text(
                      message,
                      style: context.theme.typography.body.xs.copyWith(
                        color: context.theme.colors.mutedForeground,
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _Section(
              title: 'About',
              child: Text(
                'MediaLib 1.0.0 · a local-first personal media library. Your '
                'library lives on this device; external services are only used '
                'to enrich entries with metadata.',
                style: context.theme.typography.body.sm.copyWith(
                  color: context.theme.colors.mutedForeground,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 8,
      children: [
        Text(
          title,
          style: context.theme.typography.display.xs.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        FCard(
          child: Padding(padding: const EdgeInsets.all(16), child: child),
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        SizedBox(
          width: 140,
          child: Text(
            label,
            style: context.theme.typography.body.sm.copyWith(
              color: context.theme.colors.mutedForeground,
            ),
          ),
        ),
        Expanded(child: Text(value, style: context.theme.typography.body.sm)),
      ],
    );
  }
}
