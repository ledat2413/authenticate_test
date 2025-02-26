import 'package:authenticate_module/feature/login_screen.dart';
import 'package:authenticate_module/service/auth_service.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:integration_test/integration_test.dart';

import 'package:firebase_core/firebase_core.dart';

class MockUserCredential extends Mock implements UserCredential {}

@GenerateMocks([FirebaseAuth, UserCredential])
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  group('AuthService Unit Tests', () {
    late AuthService authService;
    late MockFirebaseAuth mockFirebaseAuth;
    late MockUserCredential mockUserCredential;

    setUp(() {
      mockFirebaseAuth = MockFirebaseAuth();
      mockUserCredential = MockUserCredential();
      authService = AuthService();
    });

    test('Successful login returns a User', () async {
      when(
        mockFirebaseAuth.signInWithEmailAndPassword(
          email: 'datle2413@gmail.com',
          password: 'password123',
        ),
      ).thenAnswer((_) async => mockUserCredential);

      final user = await authService.signInWithEmail(
        'datle2413@gmail.com',
        'password123',
      );
      expect(user, isNotNull);
    });

    test('Login with incorrect credentials throws error', () async {
      when(
        mockFirebaseAuth.signInWithEmailAndPassword(
          email: 'wrong@example.com',
          password: 'wrongpass',
        ),
      ).thenThrow(FirebaseAuthException(code: 'user-not-found'));

      expect(
        () => authService.signInWithEmail('wrong@example.com', 'wrongpass'),
        throwsException,
      );
    });
  });

  group('LoginScreen Widget Tests', () {
    testWidgets('Displays email and password fields', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(MaterialApp(home: LoginScreen()));
      expect(find.byType(TextField), findsNWidgets(2));
    });

    testWidgets('Shows error message on failed login', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(MaterialApp(home: LoginScreen()));
      await tester.enterText(
        find.byKey(Key('emailField')),
        'wrong@example.com',
      );
      await tester.enterText(find.byKey(Key('passwordField')), 'wrongpass');
      await tester.tap(find.byKey(Key('loginButton')));
      await tester.pump();

      expect(find.text('Login failed'), findsOneWidget);
    });
  });

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Auth Integration Tests', () {
    testWidgets('User can log in with correct credentials', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(MaterialApp(home: LoginScreen()));
      await tester.enterText(
        find.byKey(Key('emailField')),
        'datle2413@gmail.com',
      );
      await tester.enterText(find.byKey(Key('passwordField')), 'password123');
      await tester.tap(find.byKey(Key('loginButton')));
      await tester.pumpAndSettle();

      expect(find.text('Welcome'), findsOneWidget);
    });
  });
}
