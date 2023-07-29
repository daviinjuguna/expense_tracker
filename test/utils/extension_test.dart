import 'package:expense_tracker/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/helpers.dart';

void main() {
  group('Snackbar', () {
    testWidgets('Test loadingSnackbar()', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpApp(
        Builder(
          builder: (context) => ElevatedButton(
            onPressed: () {
              context.loadingSnackbar();
            },
            child: const Text('Show Loading Snackbar'),
          ),
        ),
      );

      // Tap the button to show the loadingSnackbar
      await tester.tap(find.text('Show Loading Snackbar'));
      await tester.pump(
        const Duration(milliseconds: 750),
      ); // 0.75s // animation last frame; two second timer starts here

      // Verify that the loadingSnackbar is shown
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Loading...'), findsOneWidget);
    });

    group('Test errorSnackbar', () {
      Widget _errorApp(String customErrorMessage) => Builder(
            builder: (context) => ElevatedButton(
              onPressed: () {
                context.errorSnackbar(customErrorMessage);
              },
              child: const Text('Show Error Snackbar'),
            ),
          );

      //invalidEmail
      testWidgets('shows invalidEmail', (WidgetTester tester) async {
        // Build our app and trigger a frame.
        final String customErrorMessage = 'invalidEmail';
        await tester.pumpApp(_errorApp(customErrorMessage));
        // Tap the button to show the errorSnackbar
        await tester.tap(find.text('Show Error Snackbar'));

        // Simulate an errorSnackbar call with a custom error message
        // 0.75s // animation last frame; two second timer starts here
        await tester.pump(const Duration(milliseconds: 750));

        expect(
          find.text('Invalid email'),
          findsOneWidget,
        );
      });

      //userDisabled
      testWidgets('shows userDisabled', (WidgetTester tester) async {
        // Build our app and trigger a frame.
        final String customErrorMessage = 'userDisabled';
        await tester.pumpApp(_errorApp(customErrorMessage));
        // Tap the button to show the errorSnackbar
        await tester.tap(find.text('Show Error Snackbar'));

        // Simulate an errorSnackbar call with a custom error message
        // 0.75s // animation last frame; two second timer starts here
        await tester.pump(const Duration(milliseconds: 750));

        expect(
          find.text('User is disabled'),
          findsOneWidget,
        );
      });

      //emailAlreadyInUse
      testWidgets('shows emailAlreadyInUse', (WidgetTester tester) async {
        // Build our app and trigger a frame.
        final String customErrorMessage = 'emailAlreadyInUse';
        await tester.pumpApp(_errorApp(customErrorMessage));
        // Tap the button to show the errorSnackbar
        await tester.tap(find.text('Show Error Snackbar'));

        // Simulate an errorSnackbar call with a custom error message
        // 0.75s // animation last frame; two second timer starts here
        await tester.pump(const Duration(milliseconds: 750));

        expect(
          find.text('Email already in use'),
          findsOneWidget,
        );
      });

      //invalidCredentials
      testWidgets('shows invalidCredentials', (WidgetTester tester) async {
        // Build our app and trigger a frame.
        final String customErrorMessage = 'invalidCredentials';
        await tester.pumpApp(_errorApp(customErrorMessage));
        // Tap the button to show the errorSnackbar
        await tester.tap(find.text('Show Error Snackbar'));

        // Simulate an errorSnackbar call with a custom error message
        // 0.75s // animation last frame; two second timer starts here
        await tester.pump(const Duration(milliseconds: 750));

        expect(
          find.text('Invalid credentials'),
          findsOneWidget,
        );
      });

      //signInError
      testWidgets('shows signInError', (WidgetTester tester) async {
        // Build our app and trigger a frame.
        final String customErrorMessage = 'signInError';
        await tester.pumpApp(_errorApp(customErrorMessage));
        // Tap the button to show the errorSnackbar
        await tester.tap(find.text('Show Error Snackbar'));

        // Simulate an errorSnackbar call with a custom error message
        // 0.75s // animation last frame; two second timer starts here
        await tester.pump(const Duration(milliseconds: 750));

        expect(
          find.text('Sign in error'),
          findsOneWidget,
        );
      });

      //weakPassword
      testWidgets('shows weakPassword', (WidgetTester tester) async {
        // Build our app and trigger a frame.
        final String customErrorMessage = 'weakPassword';
        await tester.pumpApp(_errorApp(customErrorMessage));
        // Tap the button to show the errorSnackbar
        await tester.tap(find.text('Show Error Snackbar'));

        // Simulate an errorSnackbar call with a custom error message
        // 0.75s // animation last frame; two second timer starts here
        await tester.pump(const Duration(milliseconds: 750));

        expect(
          find.text('Weak password'),
          findsOneWidget,
        );
      });

      //signUpError
      testWidgets('shows signUpError', (WidgetTester tester) async {
        // Build our app and trigger a frame.
        final String customErrorMessage = 'signUpError';
        await tester.pumpApp(_errorApp(customErrorMessage));
        // Tap the button to show the errorSnackbar
        await tester.tap(find.text('Show Error Snackbar'));

        // Simulate an errorSnackbar call with a custom error message
        // 0.75s // animation last frame; two second timer starts here
        await tester.pump(const Duration(milliseconds: 750));

        expect(
          find.text('Sign up error'),
          findsOneWidget,
        );
      });

      //googleSignInCancelled
      testWidgets('shows googleSignInCancelled', (WidgetTester tester) async {
        // Build our app and trigger a frame.
        final String customErrorMessage = 'googleSignInCancelled';
        await tester.pumpApp(_errorApp(customErrorMessage));
        // Tap the button to show the errorSnackbar
        await tester.tap(find.text('Show Error Snackbar'));
        // Simulate an errorSnackbar call with a custom error message
        // 0.75s // animation last frame; two second timer starts here
        await tester.pump(const Duration(milliseconds: 750));
        expect(
          find.text('Google sign in cancelled'),
          findsOneWidget,
        );
      });

      //accountExistsWithDifferentCredential
      testWidgets('shows accountExistsWithDifferentCredential',
          (WidgetTester tester) async {
        // Build our app and trigger a frame.
        final String customErrorMessage =
            'accountExistsWithDifferentCredential';
        await tester.pumpApp(_errorApp(customErrorMessage));
        // Tap the button to show the errorSnackbar
        await tester.tap(find.text('Show Error Snackbar'));
        // Simulate an errorSnackbar call with a custom error message
        // 0.75s // animation last frame; two second timer starts here
        await tester.pump(const Duration(milliseconds: 750));
        expect(
          find.text('Account exists with different credential'),
          findsOneWidget,
        );
      });

      //signOutError
      testWidgets('shows signOutError', (WidgetTester tester) async {
        // Build our app and trigger a frame.
        final String customErrorMessage = 'signOutError';
        await tester.pumpApp(_errorApp(customErrorMessage));
        // Tap the button to show the errorSnackbar
        await tester.tap(find.text('Show Error Snackbar'));
        // Simulate an errorSnackbar call with a custom error message
        // 0.75s // animation last frame; two second timer starts here
        await tester.pump(const Duration(milliseconds: 750));
        expect(
          find.text('Sign out error'),
          findsOneWidget,
        );
      });

      testWidgets('shows uknownError', (WidgetTester tester) async {
        // Build our app and trigger a frame.
        final String customErrorMessage = 'anyOtherError';
        await tester.pumpApp(_errorApp(customErrorMessage));
        // Tap the button to show the errorSnackbar
        await tester.tap(find.text('Show Error Snackbar'));
        // Simulate an errorSnackbar call with a custom error message
        // 0.75s // animation last frame; two second timer starts here
        await tester.pump(const Duration(milliseconds: 750));
        expect(
          find.text('Unknown error'),
          findsOneWidget,
        );
      });

      //tooManyRequests
    });

    testWidgets(
      "Test dismiss snackbar",
      (WidgetTester tester) async {
        await tester.pumpApp(
          Builder(
            builder: (context) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () {
                    context.loadingSnackbar();
                  },
                  child: const Text('Show Loading Snackbar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.hideSnackBar();
                  },
                  child: const Text('Dismiss Snackbar'),
                ),
              ],
            ),
          ),
        );

        await tester.tap(find.text('Show Loading Snackbar'));
        await tester.pump(const Duration(milliseconds: 750));
        await tester.tap(find.text('Dismiss Snackbar'));
        await tester.pump(const Duration(milliseconds: 750));
        // Verify that the loadingSnackbar is hidden
        expect(find.byType(CircularProgressIndicator), findsNothing);
        expect(find.text('Loading...'), findsNothing);
      },
    );
  });
}
