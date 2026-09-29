import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import 'package:medialib/app.dart';
import 'package:medialib/core/database/app_database.dart';
import 'package:medialib/core/database/database_providers.dart';
import 'package:medialib/core/database/enums.dart';
import 'package:medialib/core/repositories/media_repository.dart';

void main() {
  late AppDatabase db;
  late MediaRepository media;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    media = MediaRepository(db);
  });

  tearDown(() => db.close());

  Future<void> pumpApp(WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [appDatabaseProvider.overrideWithValue(db)],
        child: const MediaLibApp(),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
  }

  Future<void> settle(WidgetTester tester) async {
    for (var i = 0; i < 8; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }
  }

  Future<void> disposeApp(WidgetTester tester) async {
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(milliseconds: 10));
  }

  testWidgets('shows an empty state before any activity', (tester) async {
    await pumpApp(tester);

    await tester.tap(find.text('History').first);
    await settle(tester);

    expect(find.text('No history yet'), findsOneWidget);
    await disposeApp(tester);
  });

  testWidgets('lists status changes in the timeline', (tester) async {
    final id = await media.create(
      MediaItemsCompanion.insert(title: 'Dune', mediaType: MediaType.book),
    );
    final item = await media.findById(id);
    await media.setStatus(item!, MediaStatus.inProgress);

    await pumpApp(tester);

    await tester.tap(find.text('History').first);
    await settle(tester);

    expect(find.text('Today'), findsOneWidget);
    expect(find.text('Dune'), findsOneWidget);
    expect(find.text('Started'), findsOneWidget);
    await disposeApp(tester);
  });
}
