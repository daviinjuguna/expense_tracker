import 'package:bloc_test/bloc_test.dart';
import 'package:expense_tracker/auth/auth.dart';
import 'package:expense_tracker/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:mockingjay/mockingjay.dart';

import '../../helpers/helpers.dart';

class MockAuthBloc extends MockCubit<AuthState> implements AuthCubit {}

void main() {
  late AuthCubit authCubit;

  const emailKey = Key('loginForm_emailInput_textField');
  const passwordKey = Key('loginForm_passwordInput_textField');
  const signInBtn = Key('sign_in_btn');
  const createAccBtnKey = Key('sign_up_btn');
  const googleBtn = Key('google_btn');

  const testEmail = 'test@gmail.com';
  const testPass = 't0pS3cret1234';
  late AppRouter router;

  setUp(() {
    router = AppRouter();
    authCubit = MockAuthBloc();
    when(() => authCubit.state).thenReturn(AuthState());
  });

  group('LoginPage', () {
    testWidgets(
      "LoginPage renders LoginView",
      (WidgetTester tester) async {
        await tester.pumpApp(LoginPage(authCubit: authCubit));
        expect(find.byType(LoginView), findsOneWidget);
      },
    );
  });

  group('LoginView', () {
    group('calls', () {
      testWidgets(
        "emailChanged when email is changed",
        (WidgetTester tester) async {
          await tester.pumpApp(const LoginView(), authCubit: authCubit);
          await tester.enterText(find.byKey(emailKey), testEmail);
          await tester.pumpAndSettle();
          verify(() => authCubit.emailChanged(testEmail)).called(1);
        },
      );
      testWidgets(
        "passwordChanged when password is changed",
        (WidgetTester tester) async {
          await tester.pumpApp(const LoginView(), authCubit: authCubit);
          await tester.enterText(find.byKey(passwordKey), testPass);
          await tester.pumpAndSettle();
          verify(() => authCubit.passwordChanged(testPass)).called(1);
        },
      );

      testWidgets(
        "signIn when sign in button is pressed",
        (WidgetTester tester) async {
          when(() => authCubit.state).thenReturn(
            const AuthState(
              email: Email.dirty(testEmail),
              password: Password.dirty(testPass),
              loginValid: true,
            ),
          );
          await tester.pumpApp(const LoginView(), authCubit: authCubit);
          await tester.tap(find.byKey(signInBtn));
          await tester.pumpAndSettle();
          verify(() => authCubit.signIn()).called(1);
        },
      );

      testWidgets(
        "signInWithGoogle when signInWithGoogle button is pressed",
        (WidgetTester tester) async {
          await tester.pumpApp(const LoginView(), authCubit: authCubit);
          await tester.tap(find.byKey(googleBtn));
          await tester.pumpAndSettle();
          verify(() => authCubit.signInWithGoogle()).called(1);
        },
      );
    });

    group('Validator', () {
      testWidgets(
        "shows when email is invalid",
        (WidgetTester tester) async {
          await tester.pumpApp(const LoginView(), authCubit: authCubit);
          final textField = find.byKey(emailKey);
          await tester.enterText(textField, 'invalid');
          await tester.pumpAndSettle();
          final textFinder = find.text('Invalid email');
          final validationMessage = find
              .descendant(of: textField, matching: textFinder)
              .first
              .evaluate()
              .single
              .widget as Text;
          expect(validationMessage.data, 'Invalid email');
        },
      );

      testWidgets(
        "shows when password is weak",
        (WidgetTester tester) async {
          await tester.pumpApp(const LoginView(), authCubit: authCubit);
          final textField = find.byKey(passwordKey);
          await tester.enterText(textField, 'weak');
          await tester.pumpAndSettle();
          final textFinder = find.text('Weak password');
          final validationMessage = find
              .descendant(of: textField, matching: textFinder)
              .first
              .evaluate()
              .single
              .widget as Text;
          expect(validationMessage.data, 'Weak password');
        },
      );
    });

    group('Navigator', () {
      testWidgets(
        "navigates to RegisterPage when create account button is pressed",
        (WidgetTester tester) async {
          await tester.pumpRouterApp(router);
          router.navigate(LoginRoute(authCubit: authCubit));
          await tester.pumpAndSettle();
          await tester.tap(find.byKey(createAccBtnKey));
          await tester.pumpAndSettle();
          expect(router.current.name, RegisterRoute.name);
          expect(find.byType(RegisterPage), findsOneWidget);
        },
      );
    });
  });
}