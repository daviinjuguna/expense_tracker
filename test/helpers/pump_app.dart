import 'package:bloc_test/bloc_test.dart';
import 'package:expense_tracker/auth/auth.dart';
import 'package:expense_tracker/l10n/l10n.dart';
import 'package:expense_tracker/theme_selector/theme_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mockingjay/mockingjay.dart';

import 'helpers.dart';

class _MockThemeModeBloc extends MockBloc<ThemeModeEvent, ThemeMode>
    implements ThemeModeBloc {
  @override
  ThemeMode get state => ThemeMode.system;
}

class MockSplashBloc extends MockBloc<SplashEvent, SplashState>
    implements SplashBloc {
  @override
  SplashState get state => SplashState.authenticated;
}

class MockAuthBloc extends MockCubit<AuthState> implements AuthCubit {
  @override
  AuthState get state => const AuthState();
}

extension PumpApp on WidgetTester {
  Future<void> pumpAppWidget(
    Widget widgetUnderTest, {
    ThemeModeBloc? themeModeBloc,
    SplashBloc? splashBloc,
    AuthCubit? authCubit,
    TargetPlatform? platform,
    NavigatorObserver? navigatorObserver,
    MockNavigator? navigator,
  }) =>
      pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<ThemeModeBloc>.value(
              value: themeModeBloc ?? _MockThemeModeBloc(),
            ),
            BlocProvider<SplashBloc>.value(
              value: splashBloc ?? MockSplashBloc(),
            ),
            BlocProvider<AuthCubit>.value(
              value: authCubit ?? MockAuthBloc(),
            ),
          ],
          child: widgetUnderTest,
        ),
      );

  Future<void> pumpApp(
    Widget widgetUnderTest, {
    ThemeModeBloc? themeModeBloc,
    SplashBloc? splashBloc,
    AuthCubit? authCubit,
    TargetPlatform? platform,
    NavigatorObserver? navigatorObserver,
    MockNavigator? navigator,
  }) {
    return pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<ThemeModeBloc>.value(
            value: themeModeBloc ?? _MockThemeModeBloc(),
          ),
          BlocProvider<SplashBloc>.value(
            value: splashBloc ?? MockSplashBloc(),
          ),
          BlocProvider<AuthCubit>.value(
            value: authCubit ?? MockAuthBloc(),
          ),
        ],
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Theme(
            data: ThemeData(platform: platform),
            child: navigator == null
                ? Scaffold(body: widgetUnderTest)
                : MockNavigatorProvider(
                    navigator: navigator,
                    child: Scaffold(body: widgetUnderTest),
                  ),
          ),
        ),
      ),
    );
  }

  Future<GoRouter> createRouter(
    List<RouteBase> routes,
    WidgetTester tester, {
    GoRouterRedirect? redirect,
    String initialLocation = '/',
    Object? initialExtra,
    int redirectLimit = 5,
    GlobalKey<NavigatorState>? navigatorKey,
    GoRouterWidgetBuilder? errorBuilder,
    String? restorationScopeId,
    GoExceptionHandler? onException,
  }) async {
    final GoRouter goRouter = GoRouter(
      routes: routes,
      redirect: redirect,
      initialLocation: initialLocation,
      onException: onException,
      initialExtra: initialExtra,
      redirectLimit: redirectLimit,
      errorBuilder: errorBuilder,
      navigatorKey: navigatorKey,
      restorationScopeId: restorationScopeId,
    );
    await tester.pumpWidget(
      MaterialApp.router(
        restorationScopeId:
            restorationScopeId != null ? '$restorationScopeId-root' : null,
        routerConfig: goRouter,
      ),
    );
    return goRouter;
  }

  Future<void> pumpMockGoRouterApp(
    Widget widgetUnderTest, {
    required MockGoRouter mockGoRouter,
    ThemeModeBloc? themeModeBloc,
    SplashBloc? splashBloc,
    AuthCubit? authCubit,
    TargetPlatform? platform,
    NavigatorObserver? navigatorObserver,
    MockNavigator? navigator,
  }) =>
      pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<ThemeModeBloc>.value(
              value: themeModeBloc ?? _MockThemeModeBloc(),
            ),
            BlocProvider<SplashBloc>.value(
              value: splashBloc ?? MockSplashBloc(),
            ),
            BlocProvider<AuthCubit>.value(
              value: authCubit ?? MockAuthBloc(),
            ),
          ],
          child: MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: MockGoRouterProvider(
              goRouter: mockGoRouter,
              child: widgetUnderTest,
            ),
          ),
        ),
      );
}
