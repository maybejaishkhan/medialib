import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import 'package:medialib/app.dart';
import 'package:medialib/core/database/app_database.dart';
import 'package:medialib/core/database/database_providers.dart';

void main() {
  late AppDatabase db;

  setUp(() => db = AppDatabase.forTesting(NativeDatabase.memory()));
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

  // Unmounts the app so drift's stream queries close and flush their timer.
  Future<void> disposeApp(WidgetTester tester) async {
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(milliseconds: 10));
  }

  testWidgets('boots into the library tab', (tester) async {
    await pumpApp(tester);

    expect(find.text('Your library is empty'), findsOneWidget);
    await disposeApp(tester);
  });

  testWidgets('navigates between tabs', (tester) async {
    await pumpApp(tester);

    await tester.tap(find.text('Settings').first);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('Appearance'), findsOneWidget);
    expect(find.text('Metadata sources'), findsOneWidget);
    await disposeApp(tester);
  });
}
