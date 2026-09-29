import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:material_ui/material_ui.dart';

import 'package:medialib/app.dart';
import 'package:medialib/core/database/app_database.dart';
import 'package:medialib/core/database/database_providers.dart';
import 'package:medialib/core/database/enums.dart';
import 'package:medialib/features/library/presentation/media_editor_screen.dart';
import 'package:medialib/features/metadata/domain/media_metadata.dart';
import 'package:medialib/features/metadata/domain/metadata_provider.dart';
import 'package:medialib/features/metadata/presentation/metadata_providers.dart';
import 'package:medialib/features/metadata/presentation/widgets/metadata_result_card.dart';
import 'package:medialib/features/metadata/presentation/widgets/metadata_result_tile.dart';
import 'package:medialib/features/search/presentation/search_screen.dart';

void main() {
  late AppDatabase db;

  setUp(() => db = AppDatabase.forTesting(NativeDatabase.memory()));
  tearDown(() => db.close());

  Future<void> pumpApp(WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          metadataRegistryProvider.overrideWithValue(
            MetadataProviderRegistry([_FakeProvider()]),
          ),
        ],
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

  Finder inSearch(Finder matching) =>
      find.descendant(of: find.byType(SearchScreen), matching: matching);

  Future<void> openSearchTab(WidgetTester tester) async {
    await pumpApp(tester);
    await tester.tap(find.text('Search').first);
    await settle(tester);
  }

  testWidgets('prompts for a query before searching', (tester) async {
    await openSearchTab(tester);

    expect(inSearch(find.text('Search metadata sources')), findsOneWidget);
    await disposeApp(tester);
  });

  testWidgets('searches a source and opens the result in the editor', (
    tester,
  ) async {
    await openSearchTab(tester);

    await tester.enterText(
      find.descendant(
        of: find.byKey(const ValueKey('source-search-field')),
        matching: find.byType(EditableText),
      ),
      'dune',
    );
    await tester.tap(find.widgetWithText(FButton, 'Search'));
    await settle(tester);

    // The grid is the default layout.
    expect(inSearch(find.byType(MetadataResultCard)), findsOneWidget);

    await tester.tap(inSearch(find.byType(MetadataResultCard)));
    await settle(tester);

    expect(find.text('New entry'), findsOneWidget);
    expect(
      find.descendant(
        of: find.byType(MediaEditorScreen),
        matching: find.text('Dune'),
      ),
      findsOneWidget,
    );

    await disposeApp(tester);
  });

  testWidgets('toggles between grid and list results', (tester) async {
    await openSearchTab(tester);

    await tester.enterText(
      find.descendant(
        of: find.byKey(const ValueKey('source-search-field')),
        matching: find.byType(EditableText),
      ),
      'dune',
    );
    await tester.tap(find.widgetWithText(FButton, 'Search'));
    await settle(tester);

    expect(inSearch(find.byType(MetadataResultCard)), findsOneWidget);
    expect(inSearch(find.byType(MetadataResultTile)), findsNothing);

    // In grid mode the toggle offers the list icon, and vice-versa.
    await tester.tap(inSearch(find.widgetWithIcon(FButton, FLucideIcons.list)));
    await settle(tester);

    expect(inSearch(find.byType(MetadataResultTile)), findsOneWidget);
    expect(inSearch(find.byType(MetadataResultCard)), findsNothing);

    await disposeApp(tester);
  });
}

class _FakeProvider extends MetadataProvider {
  @override
  String get id => 'fake';

  @override
  String get name => 'Fake Source';

  @override
  Set<MediaType> get supportedTypes => {MediaType.book};

  @override
  Future<List<MetadataSearchResult>> search(
    String query, {
    MediaType? type,
  }) async => const [
    MetadataSearchResult(
      providerId: 'fake',
      externalId: '1',
      title: 'Dune',
      subtitle: 'Frank Herbert',
      year: 1965,
    ),
  ];

  @override
  Future<MediaMetadata> fetch(MetadataSearchResult result) async =>
      const MediaMetadata(
        providerId: 'fake',
        externalId: '1',
        title: 'Dune',
        creators: 'Frank Herbert',
      );
}
