import 'package:bloc_test/bloc_test.dart';
import 'package:expense_tracker/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';

import 'package:expense_tracker/app/app.dart';
import 'package:expense_tracker/auth/auth.dart';
import 'package:expense_tracker/theme_selector/theme_selector.dart';

import '../../helpers/helpers.dart';

class MockThemeModeBloc extends MockBloc<ThemeModeEvent, ThemeMode>
    implements ThemeModeBloc {}

class MockSplashBloc extends MockBloc<SplashEvent, SplashState>
    implements SplashBloc {}

void main() {
  late ThemeModeBloc themeModeBloc;
  late SplashBloc splashBloc;
  // late AppRouter router;

  setUp(() {
    themeModeBloc = MockThemeModeBloc();
    splashBloc = MockSplashBloc();
    // router = AppRouter();
  });

  group('AppTheme', () {
    testWidgets('test on dark theme when set', (tester) async {
      when(() => themeModeBloc.state).thenAnswer((_) => ThemeMode.dark);

      final mockGoRouter = MockGoRouter();
      await tester.pumpMockGoRouterApp(
        AppView(),
        mockGoRouter: mockGoRouter,
        themeModeBloc: themeModeBloc,
      );
      await tester.pump();

      final splashWidget = tester.element(find.byType(SplashPage));

      expect(Theme.of(splashWidget).brightness, Brightness.dark);
    });

    testWidgets('test on light theme when set', (tester) async {
      when(() => themeModeBloc.state).thenAnswer((_) => ThemeMode.light);

      final mockGoRouter = MockGoRouter();
      await tester.pumpMockGoRouterApp(
        AppView(),
        mockGoRouter: mockGoRouter,
        themeModeBloc: themeModeBloc,
      );
      await tester.pump();

      final splashWidget = tester.element(find.byType(SplashPage));

      expect(Theme.of(splashWidget).brightness, Brightness.light);
    });
  });

  group('Authentication', () {
    testWidgets('test on authenticated state', (tester) async {
      whenListen(
        splashBloc,
        Stream.fromIterable([
          SplashState.loading,
          SplashState.authenticated,
        ]),
        initialState: SplashState.initial,
      );

      await tester.pumpAppWidget(AppView(), splashBloc: splashBloc);
      await tester.pump();
      await tester.pumpAndSettle();
      expect(find.byType(HomePage), findsOneWidget);
    });

    testWidgets('test on unauthenticated state', (tester) async {
      whenListen(
        splashBloc,
        Stream.fromIterable([
          SplashState.loading,
          SplashState.unauthenticated,
        ]),
        initialState: SplashState.initial,
      );

      await tester.pumpAppWidget(
          AppView(
            authCubit: MockDefaultAuthBloc(),
          ),
          splashBloc: splashBloc);
      await tester.pump();
      await tester.pumpAndSettle();

      expect(find.byType(LoginPage), findsOneWidget);
    });
  });
}
