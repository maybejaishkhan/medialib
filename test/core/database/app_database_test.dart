import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:medialib/core/database/app_database.dart';
import 'package:medialib/core/database/enums.dart';
import 'package:medialib/core/repositories/history_repository.dart';
import 'package:medialib/core/repositories/media_repository.dart';
import 'package:medialib/core/repositories/metadata_repository.dart';
import 'package:medialib/core/repositories/order_repository.dart';
import 'package:medialib/core/repositories/settings_repository.dart';
import 'package:medialib/core/repositories/tag_repository.dart';

void main() {
  late AppDatabase db;
  late MediaRepository media;
  late HistoryRepository history;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    media = MediaRepository(db);
    history = HistoryRepository(db);
  });

  tearDown(() => db.close());

  test('creates an entry and reads it back with defaults', () async {
    final id = await media.create(
      MediaItemsCompanion.insert(title: 'Dune', mediaType: MediaType.book),
    );

    final item = await media.findById(id);
    expect(item, isNotNull);
    expect(item!.title, 'Dune');
    expect(item.mediaType, MediaType.book);
    expect(item.status, MediaStatus.planned);
    expect(item.progress, 0);
  });

  test('filters by media type and search term', () async {
    await media.create(
      MediaItemsCompanion.insert(title: 'Dune', mediaType: MediaType.book),
    );
    await media.create(
      MediaItemsCompanion.insert(
        title: 'Dune: Part Two',
        mediaType: MediaType.movie,
      ),
    );
    await media.create(
      MediaItemsCompanion.insert(title: 'Berserk', mediaType: MediaType.manga),
    );

    final books = await media.all(mediaType: MediaType.book);
    expect(books.map((e) => e.title), ['Dune']);

    final dune = await media.all(query: 'dune');
    expect(dune, hasLength(2));
  });

  test('status changes and progress are recorded in history', () async {
    final id = await media.create(
      MediaItemsCompanion.insert(title: 'Berserk', mediaType: MediaType.manga),
    );

    final item = await media.findById(id);
    await media.setStatus(item!, MediaStatus.inProgress);

    final inProgress = (await media.findById(id))!;
    await media.updateProgress(inProgress, 5);

    final entries = await history.watchForItem(id).first;
    expect(
      entries.map((e) => e.eventType),
      containsAll([HistoryEventType.started, HistoryEventType.progressed]),
    );

    final updated = (await media.findById(id))!;
    expect(updated.status, MediaStatus.inProgress);
    expect(updated.progress, 5);
    expect(updated.startedAt, isNotNull);
  });

  test('deleting an entry cascades its history', () async {
    final id = await media.create(
      MediaItemsCompanion.insert(
        title: 'Hollow Knight',
        mediaType: MediaType.game,
      ),
    );
    final item = await media.findById(id);
    await media.setStatus(item!, MediaStatus.completed);
    expect(await history.watchForItem(id).first, isNotEmpty);

    await media.delete(id);

    expect(await history.watchForItem(id).first, isEmpty);
    expect(await media.findById(id), isNull);
  });

  test('tags can be created and attached', () async {
    final tags = TagRepository(db);
    final id = await media.create(
      MediaItemsCompanion.insert(title: 'Frieren', mediaType: MediaType.anime),
    );

    final tagId = await tags.ensure('favourite');
    await tags.attach(id, tagId);

    final attached = await tags.watchForItem(id).first;
    expect(attached.map((t) => t.name), ['favourite']);
  });

  test('order steps are stored in order', () async {
    final orders = OrderRepository(db);
    final orderId = await orders.create(name: 'Fate order');

    await orders.setSteps(orderId, const [
      OrderStepDraft(title: 'Fate/Zero'),
      OrderStepDraft(title: 'Fate/stay night'),
    ]);

    final steps = await orders.steps(orderId);
    expect(steps.map((s) => s.title), ['Fate/Zero', 'Fate/stay night']);
    expect(steps.map((s) => s.position), [0, 1]);
  });

  test('metadata payloads are cached and replaced', () async {
    final metadata = MetadataRepository(db);
    final id = await media.create(
      MediaItemsCompanion.insert(title: 'Arrival', mediaType: MediaType.movie),
    );

    await metadata.cache(
      mediaItemId: id,
      source: 'tmdb',
      payload: {'title': 'Arrival'},
    );
    await metadata.cache(
      mediaItemId: id,
      source: 'tmdb',
      payload: {'title': 'Arrival (updated)'},
    );

    expect(await metadata.forItem(id), hasLength(1));
    final payload = await metadata.payload(mediaItemId: id, source: 'tmdb');
    expect(payload?['title'], 'Arrival (updated)');
  });

  test('settings round-trip', () async {
    final settings = SettingsRepository(db);

    await settings.set('metadata.tmdb.apiKey', 'abc');
    expect(await settings.get('metadata.tmdb.apiKey'), 'abc');

    await settings.delete('metadata.tmdb.apiKey');
    expect(await settings.get('metadata.tmdb.apiKey'), isNull);
  });
}
