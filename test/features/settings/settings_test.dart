import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:material_ui/material_ui.dart';

import 'package:medialib/app.dart';
import 'package:medialib/core/database/app_database.dart';
import 'package:medialib/core/database/database_providers.dart';
import 'package:medialib/core/repositories/settings_repository.dart';
import 'package:medialib/core/settings/settings_keys.dart';
import 'package:medialib/features/metadata/presentation/metadata_providers.dart';

void main() {
  late AppDatabase db;
  late SettingsRepository settings;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    settings = SettingsRepository(db);
  });

  tearDown(() => db.close());

  test('registers TMDB only when an API key is configured', () {
    final client = MockClient((request) async => http.Response('{}', 200));

    final withoutKey = buildMetadataProviders(client, const {});
    expect(withoutKey.map((provider) => provider.id), isNot(contains('tmdb')));

    final withKey = buildMetadataProviders(client, const {
      SettingsKeys.tmdbApiKey: 'abc',
    });
    expect(withKey.map((provider) => provider.id), contains('tmdb'));
  });

  testWidgets('saves the TMDB API key from the settings screen', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [appDatabaseProvider.overrideWithValue(db)],
        child: const MediaLibApp(),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    await tester.tap(find.text('Settings').first);
    for (var i = 0; i < 8; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }
    expect(find.text('Metadata sources'), findsOneWidget);

    final tmdbField = find.ancestor(
      of: find.text('TMDB API key'),
      matching: find.byType(FTextField),
    );
    await tester.enterText(
      find.descendant(of: tmdbField, matching: find.byType(EditableText)),
      'my-key',
    );
    await tester.tap(find.text('Save'));
    for (var i = 0; i < 4; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }

    expect(await settings.get(SettingsKeys.tmdbApiKey), 'my-key');

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(milliseconds: 10));
  });
}
