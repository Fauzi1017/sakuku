import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sakuku/app.dart';
import 'package:sakuku/core/providers/database_providers.dart';
import 'package:sakuku/data/local/database.dart';

void main() {
  testWidgets('App boots to the login screen after seeding', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final db = AppDatabase.forTesting(NativeDatabase.memory());
    addTearDown(db.close);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [databaseProvider.overrideWithValue(db)],
        child: const SakukuApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Rimba'), findsOneWidget);
    expect(find.text('Masuk'), findsOneWidget);
  });
}
