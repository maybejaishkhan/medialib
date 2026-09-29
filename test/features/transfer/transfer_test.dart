import 'dart:convert';

import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:medialib/core/database/app_database.dart';
import 'package:medialib/core/database/enums.dart';
import 'package:medialib/core/repositories/franchise_repository.dart';
import 'package:medialib/core/repositories/media_repository.dart';
import 'package:medialib/core/repositories/order_repository.dart';
import 'package:medialib/core/repositories/tag_repository.dart';
import 'package:medialib/features/transfer/data/library_transfer_service.dart';

void main() {
  late AppDatabase source;

  setUp(() => source = AppDatabase.forTesting(NativeDatabase.memory()));
  tearDown(() => source.close());

  Future<String> seedAndExport() async {
    final franchiseId = await FranchiseRepository(source).create(name: 'Dune');
    final media = MediaRepository(source);
    final mediaItemId = await media.create(
      MediaItemsCompanion.insert(
        title: 'Dune',
        mediaType: MediaType.book,
        franchiseId: Value(franchiseId),
      ),
    );

    final tagId = await TagRepository(source).ensure('sci-fi');
    await TagRepository(source).attach(mediaItemId, tagId);

    final orders = OrderRepository(source);
    final orderId = await orders.create(
      name: 'Dune order',
      franchiseId: franchiseId,
    );
    await orders.setSteps(orderId, const [
      OrderStepDraft(title: 'Dune'),
      OrderStepDraft(title: 'Dune Messiah'),
    ]);

    final item = await media.findById(mediaItemId);
    await media.setStatus(item!, MediaStatus.inProgress);

    return LibraryTransferService(source).exportToJson();
  }

  test('exports a versioned, readable document', () async {
    final json = await seedAndExport();
    final decoded = jsonDecode(json) as Map<String, dynamic>;

    expect(decoded['format'], LibraryTransferService.formatId);
    expect(decoded['version'], LibraryTransferService.formatVersion);

    final data = decoded['data'] as Map<String, dynamic>;
    final firstItem = (data['mediaItems'] as List).first as Map;
    // Dates are written as ISO-8601 strings, not timestamps.
    expect(firstItem['addedAt'], isA<String>());
  });

  test('round-trips a library into a fresh database', () async {
    final json = await seedAndExport();

    final target = AppDatabase.forTesting(NativeDatabase.memory());
    addTearDown(target.close);

    final summary = await LibraryTransferService(target).importFromJson(json);

    expect(summary.franchises, 1);
    expect(summary.mediaItems, 1);
    expect(summary.tags, 1);
    expect(summary.orders, 1);
    expect(summary.historyEntries, greaterThanOrEqualTo(1));

    final items = await target.select(target.mediaItems).get();
    expect(items.single.title, 'Dune');
    expect(items.single.franchiseId, isNotNull);

    final steps = await target.select(target.watchOrderSteps).get();
    expect(
      steps.map((step) => step.title),
      containsAll(['Dune', 'Dune Messiah']),
    );

    final links = await target.select(target.mediaItemTags).get();
    expect(links, hasLength(1));
  });

  test('replace clears the existing library first', () async {
    final json = await seedAndExport();

    final target = AppDatabase.forTesting(NativeDatabase.memory());
    addTearDown(target.close);
    await MediaRepository(target).create(
      MediaItemsCompanion.insert(title: 'Old entry', mediaType: MediaType.game),
    );

    await LibraryTransferService(target).importFromJson(json, replace: true);

    final items = await target.select(target.mediaItems).get();
    expect(items.map((item) => item.title), ['Dune']);
  });

  test('rejects documents that are not MediaLib exports', () {
    expectLater(
      LibraryTransferService(source).importFromJson('{"format":"other"}'),
      throwsFormatException,
    );
    expectLater(
      LibraryTransferService(source).importFromJson('not json'),
      throwsA(isA<FormatException>()),
    );
  });
}
