import 'package:auto_route/auto_route.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:expense_tracker/auth/auth.dart';
import 'package:expense_tracker/l10n/l10n.dart';
import 'package:expense_tracker/theme_selector/theme_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';

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
  Future<void> pumpApp(
    Widget widgetUnderTest, {
    ThemeModeBloc? themeModeBloc,
    SplashBloc? splashBloc,
    AuthCubit? authCubit,
    TargetPlatform? platform,
    NavigatorObserver? navigatorObserver,
    NavigatorObserversBuilder? navigatorObserversBuilder,
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
}

extension PumpRouterApp on WidgetTester {
  Future<void> pumpRouterApp(
    RootStackRouter router, {
    ThemeModeBloc? themeModeBloc,
    SplashBloc? splashBloc,
    AuthCubit? authCubit,
    String? initialLink,
    NavigatorObserversBuilder observers =
        AutoRouterDelegate.defaultNavigatorObserversBuilder,
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
        child: MaterialApp.router(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          routeInformationParser: router.defaultRouteParser(),
          routerDelegate: router.delegate(
            deepLinkBuilder: (link) =>
                initialLink == null ? link : DeepLink.path(initialLink),
            navigatorObservers: observers,
          ),
        ),
      ),
    );
  }

  Future<void> pumpRouterConfigApp(
    RouterConfig<UrlState> config, {
    NavigatorObserversBuilder observers =
        AutoRouterDelegate.defaultNavigatorObserversBuilder,
  }) {
    return pumpWidget(
      MaterialApp.router(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: config,
      ),
    );
  }
}

void expectCurrentPage(StackRouter router, String name) {
  expect(router.current.name, name);
  expect(find.text(name), findsOneWidget);
}

void expectTopPage(StackRouter router, String name) {
  expect(router.topRoute.name, name);
  expect(find.text(name), findsOneWidget);
}
