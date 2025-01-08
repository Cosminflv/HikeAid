import 'package:core/di/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:running_app/running_app.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    setUp(() {
      initEarlyDependencies('127.0.0.1');
    });
    testWidgets('login behaviour', (tester) async {
      // Load app widget.
      await tester.pumpWidget(const RunningApp());

      // Verify the counter starts at 0.
      expect(find.text('Get started'), findsOneWidget);

      // Finds the floating action button to tap on.
      final getStartedButton = find.byKey(const ValueKey('GetStartedButton'));

      // // Emulate a tap on the floating action button.
      await tester.tap(getStartedButton);

      // // Trigger a frame.
      await tester.pumpAndSettle();

      // // Verify the counter increments by 1.
      expect(find.text('Welcome'), findsOneWidget);

      final usernameField = find.byKey(const Key('usernameForm'));
      final passwordField = find.byKey(const ValueKey('passwordForm'));

      await tester.enterText(usernameField, 'Cosbos');
      await tester.enterText(passwordField, 'qaz123//');

      await tester.pumpAndSettle();

      final loginButton = find.byKey(const ValueKey('LoginButton'));

      await tester.tap(loginButton);

      await Future.delayed(const Duration(seconds: 5));

      await tester.pumpAndSettle();

      await Future.delayed(const Duration(seconds: 5));

      await tester.pumpAndSettle();

      final mapWidget = find.byKey(const Key('MapWidget'));
      expect(mapWidget, isNotNull);
    });
  });
}
