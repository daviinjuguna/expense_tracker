import 'package:auto_route/auto_route.dart';
import 'package:expense_tracker/auth/auth.dart';
import 'package:expense_tracker/home/home.dart';
import 'package:flutter/material.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  AppRouter({super.navigatorKey});

  @override
  List<AutoRoute> get routes {
    return [
      AutoRoute(page: SplashRoute.page, initial: true),
      AutoRoute(page: LoginRoute.page),
      AutoRoute(page: RegisterRoute.page),
      AutoRoute(page: HomeRoute.page),
    ];
  }
}
