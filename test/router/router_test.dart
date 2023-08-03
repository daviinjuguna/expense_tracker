import 'package:bloc_test/bloc_test.dart';
import 'package:expense_tracker/app/app.dart';
import 'package:expense_tracker/auth/auth.dart';
import 'package:expense_tracker/home/home.dart';
import 'package:expense_tracker/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/helpers.dart';

class MockAuthBloc extends MockCubit<AuthState> implements AuthCubit {
  @override
  AuthState get state => const AuthState();
}

void main() {
  late AuthCubit authCubit;
  setUp(() {
    authCubit = MockAuthBloc();
    // when(() => authCubit.state).thenReturn(AuthState());
  });

  tearDown(() {
    authCubit.close();
  });

  group('Router', () {
    group('SplashRoute', () {
      testWidgets(
        "go to Splash page",
        (WidgetTester tester) async {
          await tester.pumpAppWidget(AppView());
          final ScaffoldState scaffoldState =
              tester.firstState(find.byType(Scaffold));

          SplashRoute().go(scaffoldState.context);
          await tester.pump();
          expect(find.byType(SplashPage), findsOneWidget);
        },
      );
      testWidgets(
        "push to Splash page",
        (WidgetTester tester) async {
          await tester.pumpAppWidget(AppView());
          final ScaffoldState scaffoldState =
              tester.firstState(find.byType(Scaffold));

          SplashRoute().push<SplashPage>(scaffoldState.context);
          await tester.pump();
          expect(find.byType(SplashPage), findsOneWidget);
        },
      );

      testWidgets(
        "replace to Splash page",
        (WidgetTester tester) async {
          await tester.pumpAppWidget(AppView());
          final ScaffoldState scaffoldState =
              tester.firstState(find.byType(Scaffold));

          SplashRoute().replace(scaffoldState.context);
          await tester.pump();
          expect(find.byType(SplashPage), findsOneWidget);
        },
      );

      testWidgets(
        "pushReplacement to Splash page",
        (WidgetTester tester) async {
          await tester.pumpAppWidget(AppView());
          final ScaffoldState scaffoldState =
              tester.firstState(find.byType(Scaffold));

          SplashRoute().pushReplacement(scaffoldState.context);
          await tester.pump();
          expect(find.byType(SplashPage), findsOneWidget);
        },
      );
    });

    group('LoginRoute', () {
      testWidgets(
        "go to login page",
        (WidgetTester tester) async {
          await tester.pumpAppWidget(AppView());
          final ScaffoldState scaffoldState =
              tester.firstState(find.byType(Scaffold));

          SplashRoute().go(scaffoldState.context);
          await tester.pump();
          LoginRoute($extra: authCubit).go(scaffoldState.context);
          await tester.pumpAndSettle();
          expect(find.byType(LoginPage), findsOneWidget);
        },
      );

      testWidgets(
        "push to login page",
        (WidgetTester tester) async {
          await tester.pumpAppWidget(AppView());
          final ScaffoldState scaffoldState =
              tester.firstState(find.byType(Scaffold));

          SplashRoute().go(scaffoldState.context);
          await tester.pump();
          LoginRoute($extra: authCubit).push<LoginPage>(scaffoldState.context);
          await tester.pumpAndSettle();
          expect(find.byType(LoginPage), findsOneWidget);
        },
      );

      testWidgets(
        "replace to login page",
        (WidgetTester tester) async {
          await tester.pumpAppWidget(AppView());
          final ScaffoldState scaffoldState =
              tester.firstState(find.byType(Scaffold));

          SplashRoute().go(scaffoldState.context);
          await tester.pump();
          LoginRoute($extra: authCubit).replace(scaffoldState.context);
          await tester.pumpAndSettle();
          expect(find.byType(LoginPage), findsOneWidget);
        },
      );

      testWidgets(
        "pushReplacement to login page",
        (WidgetTester tester) async {
          await tester.pumpAppWidget(AppView());
          final ScaffoldState scaffoldState =
              tester.firstState(find.byType(Scaffold));

          SplashRoute().go(scaffoldState.context);
          await tester.pump();
          LoginRoute($extra: authCubit).pushReplacement(scaffoldState.context);
          await tester.pumpAndSettle();
          expect(find.byType(LoginPage), findsOneWidget);
        },
      );
    });

    group('RegisterRoute', () {
      testWidgets(
        "go to register page",
        (WidgetTester tester) async {
          await tester.pumpAppWidget(AppView());
          final ScaffoldState scaffoldState =
              tester.firstState(find.byType(Scaffold));

          SplashRoute().go(scaffoldState.context);
          await tester.pump();
          RegisterRoute($extra: authCubit).go(scaffoldState.context);
          await tester.pumpAndSettle();
          expect(find.byType(RegisterPage), findsOneWidget);
        },
      );

      testWidgets(
        "push to register page",
        (WidgetTester tester) async {
          await tester.pumpAppWidget(AppView());
          final ScaffoldState scaffoldState =
              tester.firstState(find.byType(Scaffold));

          SplashRoute().go(scaffoldState.context);
          await tester.pump();
          RegisterRoute($extra: authCubit)
              .push<RegisterPage>(scaffoldState.context);
          await tester.pumpAndSettle();
          expect(find.byType(RegisterPage), findsOneWidget);
        },
      );

      testWidgets(
        "replace to register page",
        (WidgetTester tester) async {
          await tester.pumpAppWidget(AppView());
          final ScaffoldState scaffoldState =
              tester.firstState(find.byType(Scaffold));

          SplashRoute().go(scaffoldState.context);
          await tester.pump();
          RegisterRoute($extra: authCubit).replace(scaffoldState.context);
          await tester.pumpAndSettle();
          expect(find.byType(RegisterPage), findsOneWidget);
        },
      );

      testWidgets(
        "pushReplacement to register page",
        (WidgetTester tester) async {
          await tester.pumpAppWidget(AppView());
          final ScaffoldState scaffoldState =
              tester.firstState(find.byType(Scaffold));

          SplashRoute().go(scaffoldState.context);
          await tester.pump();
          RegisterRoute($extra: authCubit)
              .pushReplacement(scaffoldState.context);
          await tester.pumpAndSettle();
          expect(find.byType(RegisterPage), findsOneWidget);
        },
      );
    });

    group('HomeRoute', () {
      testWidgets(
        "go to home page",
        (WidgetTester tester) async {
          await tester.pumpAppWidget(AppView());
          final ScaffoldState scaffoldState =
              tester.firstState(find.byType(Scaffold));

          SplashRoute().go(scaffoldState.context);
          await tester.pump();
          HomeRoute().go(scaffoldState.context);
          await tester.pumpAndSettle();
          expect(find.byType(HomePage), findsOneWidget);
        },
      );

      testWidgets(
        "push to home page",
        (WidgetTester tester) async {
          await tester.pumpAppWidget(AppView());
          final ScaffoldState scaffoldState =
              tester.firstState(find.byType(Scaffold));
          SplashRoute().go(scaffoldState.context);
          await tester.pump();
          HomeRoute().push<HomePage>(scaffoldState.context);
          await tester.pumpAndSettle();
          expect(find.byType(HomePage), findsOneWidget);
        },
      );

      testWidgets(
        "replace to home page",
        (WidgetTester tester) async {
          await tester.pumpAppWidget(AppView());
          final ScaffoldState scaffoldState =
              tester.firstState(find.byType(Scaffold));
          SplashRoute().go(scaffoldState.context);
          await tester.pump();
          HomeRoute().replace(scaffoldState.context);
          await tester.pumpAndSettle();
          expect(find.byType(HomePage), findsOneWidget);
        },
      );

      testWidgets(
        "pushReplacement to home page",
        (WidgetTester tester) async {
          await tester.pumpAppWidget(AppView());
          final ScaffoldState scaffoldState =
              tester.firstState(find.byType(Scaffold));
          SplashRoute().go(scaffoldState.context);
          await tester.pump();
          HomeRoute().pushReplacement(scaffoldState.context);
          await tester.pumpAndSettle();
          expect(find.byType(HomePage), findsOneWidget);
        },
      );

      testWidgets(
        "pushAndRemoveUntil to home page",
        (WidgetTester tester) async {
          await tester.pumpAppWidget(AppView());
          final ScaffoldState scaffoldState =
              tester.firstState(find.byType(Scaffold));
          SplashRoute().go(scaffoldState.context);
          await tester.pump();
          HomeRoute().pushReplacement(scaffoldState.context);
          await tester.pumpAndSettle();
          expect(find.byType(HomePage), findsOneWidget);
        },
      );
    });
  });
}
