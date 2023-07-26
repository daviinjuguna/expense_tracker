import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

extension PumpRouterApp on WidgetTester {
  Future<void> pumpRouterApp(
    RootStackRouter router, {
    String? initialLink,
    NavigatorObserversBuilder observers =
        AutoRouterDelegate.defaultNavigatorObserversBuilder,
  }) {
    return pumpWidget(
      MaterialApp.router(
        routeInformationParser: router.defaultRouteParser(),
        routerDelegate: router.delegate(
          deepLinkBuilder: (link) =>
              initialLink == null ? link : DeepLink.path(initialLink),
          navigatorObservers: observers,
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
