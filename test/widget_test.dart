import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:cinemapedia/main.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async {
    await dotenv.load(fileName: '.env');
  });

  testWidgets('Smoke test', (WidgetTester tester) async {
    // Reemplaza el provider con el mock en la prueba
    await tester.pumpWidget(
      ProviderScope(
        child: const MyApp(),
      ),
    );
    await tester.pumpAndSettle();
    // Realiza tus verificaciones
  });
}
