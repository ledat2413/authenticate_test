import 'package:authenticate_module/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('User Login Flow', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    await tester.enterText(find.byType(TextFormField).at(0), 'test@email.com');
    await tester.enterText(find.byType(TextFormField).at(1), 'password123');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    expect(find.text('Welcome Home!'), findsOneWidget);
  });
}
