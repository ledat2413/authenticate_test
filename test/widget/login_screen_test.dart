import 'package:authenticate_module/feature/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Should display Email and Password fields', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: LoginScreen()));

    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.text('Login'), findsOneWidget);
  });

  testWidgets('Shows Error if Email is Empty', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: LoginScreen()));
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    expect(find.text('Enter email'), findsOneWidget);
  });

  testWidgets('Successful Login navigates to Home Screen', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: LoginScreen()));

    await tester.enterText(find.byType(TextFormField).at(0), 'test@email.com');
    await tester.enterText(find.byType(TextFormField).at(1), 'password123');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    expect(find.text('Welcome Home!'), findsOneWidget);
  });
}
