import 'package:drift/drift.dart' show Value;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import 'package:medialib/core/database/app_database.dart';
import 'package:medialib/core/database/database_providers.dart';
import 'package:medialib/core/database/enums.dart';
import 'package:medialib/core/router/routes.dart';
import 'package:medialib/core/widgets/confirm_dialog.dart';
import 'package:medialib/features/history/presentation/history_providers.dart';
import 'package:medialib/features/history/presentation/widgets/history_entry_row.dart';
import 'package:medialib/features/library/presentation/library_providers.dart';
import 'package:medialib/features/metadata/domain/media_metadata.dart';
import 'package:medialib/features/metadata/presentation/metadata_providers.dart';
import 'package:medialib/features/metadata/presentation/metadata_search_dialog.dart';

/// Full-page form for creating or editing a library entry.
///
/// Pass [mediaItemId] to edit an existing entry; leave it null to create one.
class MediaEditorScreen extends ConsumerStatefulWidget {
  const MediaEditorScreen({super.key, this.mediaItemId, this.initialMetadata});

  final String? mediaItemId;

  /// When set, the editor fetches and applies this result on open.
  final MetadataSearchResult? initialMetadata;

  @override
  ConsumerState<MediaEditorScreen> createState() => _MediaEditorScreenState();
}

class _MediaEditorScreenState extends ConsumerState<MediaEditorScreen> {
  final _title = TextEditingController();
  final _originalTitle = TextEditingController();
  final _creators = TextEditingController();
  final _description = TextEditingController();
  final _notes = TextEditingController();
  final _rating = TextEditingController();
  final _progress = TextEditingController();
  final _totalProgress = TextEditingController();
  final _pageCount = TextEditingController();
  final _chapterCount = TextEditingController();
  final _episodeCount = TextEditingController();
  final _runtimeMinutes = TextEditingController();
  final _trackCount = TextEditingController();
  final _platform = TextEditingController();
  final _isbn = TextEditingController();
  final _coverUrl = TextEditingController();
  final _releaseDate = TextEditingController();

  MediaType _mediaType = MediaType.book;
  MediaStatus _status = MediaStatus.planned;
  String? _franchiseId;
  MediaItem? _existing;

  bool _loading = false;
  bool _saving = false;
  bool _fetching = false;
  String? _titleError;
  String? _saveError;

  String? _externalSource;
  String? _externalId;
  MediaMetadata? _pendingMetadata;

  bool get _isEditing => widget.mediaItemId != null;

  @override
  void initState() {
    super.initState();
    if (_isEditing) {
      _load();
    } else if (widget.initialMetadata != null) {
      _loadInitialMetadata();
    }
  }

  @override
  void dispose() {
    for (final controller in [
      _title,
      _originalTitle,
      _creators,
      _description,
      _notes,
      _rating,
      _progress,
      _totalProgress,
      _pageCount,
      _chapterCount,
      _episodeCount,
      _runtimeMinutes,
      _trackCount,
      _platform,
      _isbn,
      _coverUrl,
      _releaseDate,
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    final item = await ref
        .read(mediaRepositoryProvider)
        .findById(widget.mediaItemId!);
    if (!mounted) return;
    if (item != null) {
      _title.text = item.title;
      _originalTitle.text = item.originalTitle ?? '';
      _creators.text = item.creators ?? '';
      _description.text = item.description ?? '';
      _notes.text = item.notes ?? '';
      _rating.text = item.rating?.toString() ?? '';
      _progress.text = item.progress == 0 ? '' : '${item.progress}';
      _totalProgress.text = item.totalProgress?.toString() ?? '';
      _pageCount.text = item.pageCount?.toString() ?? '';
      _chapterCount.text = item.chapterCount?.toString() ?? '';
      _episodeCount.text = item.episodeCount?.toString() ?? '';
      _runtimeMinutes.text = item.runtimeMinutes?.toString() ?? '';
      _trackCount.text = item.trackCount?.toString() ?? '';
      _platform.text = item.platform ?? '';
      _isbn.text = item.isbn ?? '';
      _coverUrl.text = item.coverUrl ?? '';
      _releaseDate.text = item.releaseDate == null
          ? ''
          : _formatDate(item.releaseDate!);
      _externalSource = item.externalSource;
      _externalId = item.externalId;
      _mediaType = item.mediaType;
      _status = item.status;
      _franchiseId = item.franchiseId;
      _existing = item;
    }
    setState(() => _loading = false);
  }

  void _close() {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.library);
    }
  }

  Future<void> _save() async {
    final title = _title.text.trim();
    if (title.isEmpty) {
      setState(() => _titleError = 'Title is required');
      return;
    }

    setState(() {
      _titleError = null;
      _saveError = null;
      _saving = true;
    });

    final repository = ref.read(mediaRepositoryProvider);
    try {
      final progress = _parseInt(_progress.text) ?? 0;
      final metadata = _pendingMetadata;
      if (_existing == null) {
        final id = await repository.create(
          MediaItemsCompanion(
            title: Value(title),
            originalTitle: Value(_nullIfEmpty(_originalTitle.text)),
            mediaType: Value(_mediaType),
            status: Value(_status),
            description: Value(_nullIfEmpty(_description.text)),
            creators: Value(_nullIfEmpty(_creators.text)),
            coverUrl: Value(_nullIfEmpty(_coverUrl.text)),
            releaseDate: Value(DateTime.tryParse(_releaseDate.text.trim())),
            rating: Value(_parseDouble(_rating.text)),
            pageCount: Value(_parseInt(_pageCount.text)),
            chapterCount: Value(_parseInt(_chapterCount.text)),
            episodeCount: Value(_parseInt(_episodeCount.text)),
            runtimeMinutes: Value(_parseInt(_runtimeMinutes.text)),
            trackCount: Value(_parseInt(_trackCount.text)),
            platform: Value(_nullIfEmpty(_platform.text)),
            isbn: Value(_nullIfEmpty(_isbn.text)),
            progress: Value(progress),
            totalProgress: Value(_parseInt(_totalProgress.text)),
            notes: Value(_nullIfEmpty(_notes.text)),
            franchiseId: Value(_franchiseId),
            externalSource: Value(_externalSource),
            externalId: Value(_externalId),
          ),
        );
        if (metadata != null) {
          await ref.read(metadataServiceProvider).cache(id, metadata);
        }
      } else {
        final updated = _existing!.copyWith(
          title: title,
          originalTitle: Value(_nullIfEmpty(_originalTitle.text)),
          mediaType: _mediaType,
          description: Value(_nullIfEmpty(_description.text)),
          creators: Value(_nullIfEmpty(_creators.text)),
          rating: Value(_parseDouble(_rating.text)),
          pageCount: Value(_parseInt(_pageCount.text)),
          chapterCount: Value(_parseInt(_chapterCount.text)),
          episodeCount: Value(_parseInt(_episodeCount.text)),
          runtimeMinutes: Value(_parseInt(_runtimeMinutes.text)),
          trackCount: Value(_parseInt(_trackCount.text)),
          platform: Value(_nullIfEmpty(_platform.text)),
          isbn: Value(_nullIfEmpty(_isbn.text)),
          coverUrl: Value(_nullIfEmpty(_coverUrl.text)),
          releaseDate: Value(DateTime.tryParse(_releaseDate.text.trim())),
          progress: progress,
          totalProgress: Value(_parseInt(_totalProgress.text)),
          notes: Value(_nullIfEmpty(_notes.text)),
          franchiseId: Value(_franchiseId),
          externalSource: Value(_externalSource),
          externalId: Value(_externalId),
        );
        await repository.update(updated);
        if (_status != _existing!.status) {
          await repository.setStatus(updated, _status);
        }
        if (metadata != null) {
          await ref.read(metadataServiceProvider).cache(updated.id, metadata);
        }
      }
      if (mounted) _close();
    } catch (error) {
      if (mounted) setState(() => _saveError = '$error');
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _delete() async {
    final item = _existing;
    if (item == null) return;
    final confirmed = await showConfirmDialog(
      context,
      title: 'Delete entry',
      message: 'Delete "${item.title}"? This cannot be undone.',
      confirmLabel: 'Delete',
      destructive: true,
    );
    if (!confirmed || !mounted) return;
    await ref.read(mediaRepositoryProvider).delete(item.id);
    if (mounted) _close();
  }

  Future<void> _fetchMetadata() async {
    final query = [
      _title.text.trim(),
      _originalTitle.text.trim(),
    ].firstWhere((value) => value.isNotEmpty, orElse: () => '');
    if (query.isEmpty) {
      setState(() => _titleError = 'Enter a title to search for');
      return;
    }

    final result = await showMetadataSearchDialog(
      context,
      type: _mediaType,
      initialQuery: query,
    );
    if (result == null || !mounted) return;

    setState(() {
      _fetching = true;
      _saveError = null;
    });
    try {
      final metadata = await ref.read(metadataServiceProvider).fetch(result);
      if (!mounted) return;
      _applyMetadata(metadata);
    } catch (error) {
      if (mounted) {
        setState(() => _saveError = 'Could not fetch metadata: $error');
      }
    } finally {
      if (mounted) setState(() => _fetching = false);
    }
  }

  Future<void> _loadInitialMetadata() async {
    final result = widget.initialMetadata!;
    setState(() => _fetching = true);
    try {
      final metadata = await ref.read(metadataServiceProvider).fetch(result);
      if (!mounted) return;
      _applyMetadata(metadata);
    } catch (error) {
      if (mounted) {
        setState(() => _saveError = 'Could not fetch metadata: $error');
      }
    } finally {
      if (mounted) setState(() => _fetching = false);
    }
  }

  void _applyMetadata(MediaMetadata metadata) {
    setState(() {
      if (metadata.title case final title? when _title.text.trim().isEmpty) {
        _title.text = title;
      }
      if (metadata.creators case final creators?) _creators.text = creators;
      if (metadata.description case final description?) {
        _description.text = description;
      }
      if (metadata.coverUrl case final coverUrl?) _coverUrl.text = coverUrl;
      if (metadata.releaseDate case final releaseDate?) {
        _releaseDate.text = _formatDate(releaseDate);
      }
      if (metadata.rating case final rating?) {
        _rating.text = rating % 1 == 0
            ? rating.toInt().toString()
            : rating.toStringAsFixed(1);
      }
      if (metadata.pageCount case final pageCount?) {
        _pageCount.text = '$pageCount';
      }
      if (metadata.chapterCount case final chapterCount?) {
        _chapterCount.text = '$chapterCount';
      }
      if (metadata.episodeCount case final episodeCount?) {
        _episodeCount.text = '$episodeCount';
      }
      if (metadata.runtimeMinutes case final runtimeMinutes?) {
        _runtimeMinutes.text = '$runtimeMinutes';
      }
      if (metadata.trackCount case final trackCount?) {
        _trackCount.text = '$trackCount';
      }
      if (metadata.isbn case final isbn?) _isbn.text = isbn;
      _externalSource = metadata.providerId;
      _externalId = metadata.externalId;
      _pendingMetadata = metadata;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader.nested(
        title: Text(_isEditing ? 'Edit entry' : 'New entry'),
        prefixes: [
          FHeaderAction(
            icon: const Icon(FLucideIcons.arrowLeft),
            onPress: _close,
          ),
        ],
        suffixes: [
          FHeaderAction(
            icon: const Icon(FLucideIcons.check),
            onPress: _saving ? null : _save,
          ),
        ],
      ),
      child: _loading
          ? const Center(child: FCircularProgress())
          : Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 720),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: 16,
                    children: [
                      if (_saveError case final error?)
                        DecoratedBox(
                          decoration: BoxDecoration(
                            color: context.theme.colors.destructive.withValues(
                              alpha: 0.08,
                            ),
                            borderRadius: context.theme.style.borderRadius.md,
                            border: Border.all(
                              color: context.theme.colors.destructive
                                  .withValues(alpha: 0.5),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Text(
                              'Could not save: $error',
                              style: context.theme.typography.body.sm.copyWith(
                                color: context.theme.colors.destructive,
                              ),
                            ),
                          ),
                        ),
                      _sectionTitle(context, 'Details'),
                      _text('Title *', _title, error: _titleError),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: FButton(
                          variant: FButtonVariant.outline,
                          onPress: _fetching || _saving ? null : _fetchMetadata,
                          prefix: const Icon(FLucideIcons.sparkles),
                          child: Text(
                            _fetching ? 'Fetching…' : 'Fetch metadata',
                          ),
                        ),
                      ),
                      _text('Original title', _originalTitle),
                      _typeAndStatus(),
                      _text('Creators (comma separated)', _creators),
                      _text('Description', _description, maxLines: 3),
                      _text('Cover image URL', _coverUrl),
                      _text('Release date (YYYY-MM-DD)', _releaseDate),
                      ..._typeSpecificFields(),
                      _sectionTitle(context, 'Progress & rating'),
                      Row(
                        spacing: 16,
                        children: [
                          Expanded(
                            child: _text(
                              'Progress',
                              _progress,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          Expanded(
                            child: _text(
                              'Total progress',
                              _totalProgress,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                      _text(
                        'Rating (0–10)',
                        _rating,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                      ),
                      _sectionTitle(context, 'Organisation'),
                      _franchiseSelect(),
                      _text('Notes', _notes, maxLines: 3),
                      if (_isEditing) ...[
                        _sectionTitle(context, 'History'),
                        _historySection(context),
                      ],
                      if (_isEditing) ...[
                        const SizedBox(height: 8),
                        FButton(
                          variant: FButtonVariant.destructive,
                          onPress: _saving ? null : _delete,
                          prefix: const Icon(FLucideIcons.trash2),
                          child: const Text('Delete entry'),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget _sectionTitle(BuildContext context, String text) => Padding(
    padding: const EdgeInsets.only(top: 8),
    child: Text(
      text,
      style: context.theme.typography.display.xs.copyWith(
        fontWeight: FontWeight.w600,
      ),
    ),
  );

  Widget _text(
    String label,
    TextEditingController controller, {
    int maxLines = 1,
    TextInputType? keyboardType,
    String? error,
  }) => FTextField(
    control: FTextFieldControl.managed(controller: controller),
    label: Text(label),
    maxLines: maxLines,
    keyboardType: keyboardType,
    error: error == null ? null : Text(error),
  );

  Widget _typeAndStatus() {
    return Row(
      spacing: 16,
      children: [
        Expanded(
          child: FSelect<MediaType>(
            items: {for (final type in MediaType.values) type.label: type},
            control: FSelectControl.managed(
              initial: _mediaType,
              onChange: (value) {
                if (value != null) setState(() => _mediaType = value);
              },
            ),
            label: const Text('Media type'),
          ),
        ),
        Expanded(
          child: FSelect<MediaStatus>(
            items: {
              for (final status in MediaStatus.values) status.label: status,
            },
            control: FSelectControl.managed(
              initial: _status,
              onChange: (value) {
                if (value != null) setState(() => _status = value);
              },
            ),
            label: const Text('Status'),
          ),
        ),
      ],
    );
  }

  List<Widget> _typeSpecificFields() => switch (_mediaType) {
    MediaType.book => [
      _numberField('Page count', _pageCount),
      _text('ISBN', _isbn, keyboardType: TextInputType.number),
    ],
    MediaType.comic => [
      _numberField('Page count', _pageCount),
      _numberField('Chapter count', _chapterCount),
    ],
    MediaType.manga => [_numberField('Chapter count', _chapterCount)],
    MediaType.anime ||
    MediaType.tv => [_numberField('Episode count', _episodeCount)],
    MediaType.movie => [_numberField('Runtime (minutes)', _runtimeMinutes)],
    MediaType.game => [_text('Platform', _platform)],
    MediaType.music => [_numberField('Track count', _trackCount)],
  };

  Widget _numberField(String label, TextEditingController controller) =>
      _text(label, controller, keyboardType: TextInputType.number);

  Widget _historySection(BuildContext context) {
    final history = ref.watch(historyForItemProvider(widget.mediaItemId!));
    return history.when(
      data: (entries) => entries.isEmpty
          ? Text(
              'No activity recorded yet.',
              style: context.theme.typography.body.sm.copyWith(
                color: context.theme.colors.mutedForeground,
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (final entry in entries.take(25))
                  HistoryEntryRow(entry: entry, showDateTime: true),
              ],
            ),
      loading: () => const SizedBox.shrink(),
      error: (error, stackTrace) => const SizedBox.shrink(),
    );
  }

  Widget _franchiseSelect() {
    final franchises = ref.watch(franchisesProvider);
    return franchises.when(
      data: (list) => FSelect<String?>(
        key: ValueKey(_franchiseId),
        items: {
          'None': null,
          for (final franchise in list) franchise.name: franchise.id,
        },
        control: FSelectControl.managed(
          initial: _franchiseId != null && list.any((f) => f.id == _franchiseId)
              ? _franchiseId
              : null,
          onChange: (value) => setState(() => _franchiseId = value),
        ),
        label: const Text('Franchise / series'),
      ),
      loading: () => const SizedBox.shrink(),
      error: (error, stackTrace) => const SizedBox.shrink(),
    );
  }
}

String? _nullIfEmpty(String value) {
  final trimmed = value.trim();
  return trimmed.isEmpty ? null : trimmed;
}

String _formatDate(DateTime date) =>
    '${date.year.toString().padLeft(4, '0')}-'
    '${date.month.toString().padLeft(2, '0')}-'
    '${date.day.toString().padLeft(2, '0')}';

int? _parseInt(String value) => int.tryParse(value.trim());

double? _parseDouble(String value) => double.tryParse(value.trim());
