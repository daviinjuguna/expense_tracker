import 'package:expense_tracker/auth/auth.dart';
import 'package:expense_tracker/home/home.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:go_router/go_router.dart';

part 'app_router.g.dart';

@TypedGoRoute<SplashRoute>(path: '/')
class SplashRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) => SplashPage();
}

@TypedGoRoute<LoginRoute>(path: '/login')
class LoginRoute extends GoRouteData {
  final AuthCubit? $extra;

  LoginRoute({this.$extra});

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      LoginPage(authCubit: $extra);
}

@TypedGoRoute<RegisterRoute>(path: '/register')
class RegisterRoute extends GoRouteData {
  final AuthCubit? $extra;
  RegisterRoute({this.$extra});
  @override
  Widget build(BuildContext context, GoRouterState state) => RegisterPage(
        authCubit: $extra,
      );
}

@TypedGoRoute<HomeRoute>(path: '/home')
class HomeRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) => HomePage();
}
