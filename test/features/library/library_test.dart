import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:material_ui/material_ui.dart';

import 'package:medialib/app.dart';
import 'package:medialib/core/database/app_database.dart';
import 'package:medialib/core/database/database_providers.dart';
import 'package:medialib/core/database/enums.dart';
import 'package:medialib/core/repositories/media_repository.dart';
import 'package:medialib/features/library/presentation/media_editor_screen.dart';

void main() {
  late AppDatabase db;
  late MediaRepository media;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    media = MediaRepository(db);
  });

  tearDown(() => db.close());

  // Uses explicit pumps instead of pumpAndSettle: the library shows an
  // indeterminate progress indicator while loading, which never settles.
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

  // Unmounts the app so drift's stream queries are closed, then flushes the
  // resulting zero-duration timer before the test's pending-timer check.
  Future<void> disposeApp(WidgetTester tester) async {
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(milliseconds: 10));
  }

  testWidgets('shows entries stored in the library', (tester) async {
    await media.create(
      MediaItemsCompanion.insert(title: 'Dune', mediaType: MediaType.book),
    );

    await pumpApp(tester);

    expect(find.text('Dune'), findsOneWidget);
    await disposeApp(tester);
  });

  testWidgets('shows the empty state when there are no entries', (
    tester,
  ) async {
    await pumpApp(tester);

    expect(find.text('Your library is empty'), findsOneWidget);
    await disposeApp(tester);
  });

  testWidgets('creates an entry through the editor', (tester) async {
    await pumpApp(tester);

    await tester.tap(find.text('Add'));
    await settle(tester);
    expect(find.text('New entry'), findsOneWidget);

    await tester.enterText(
      find
          .descendant(
            of: find.byType(MediaEditorScreen),
            matching: find.byType(EditableText),
          )
          .first,
      'Berserk',
    );
    await tester.tap(find.byIcon(FLucideIcons.check));
    await settle(tester);

    expect(find.text('Berserk'), findsOneWidget);
    final stored = await media.all();
    expect(stored.map((item) => item.title), ['Berserk']);
    await disposeApp(tester);
  });
}
