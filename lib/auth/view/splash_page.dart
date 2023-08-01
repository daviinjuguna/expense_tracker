import 'package:auto_route/auto_route.dart';
import 'package:expense_tracker/auth/bloc/splash/splash_bloc.dart';
import 'package:expense_tracker/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        switch (state) {
          case SplashState.authenticated:
            context.router
                .pushAndPopUntil(HomeRoute(), predicate: (_) => false);
            break;
          case SplashState.unauthenticated:
            context.router
                .pushAndPopUntil(LoginRoute(), predicate: (_) => false);
          default:
        }
      },
      child: Scaffold(
        body: Center(
          child: CircularProgressIndicator.adaptive(
            key: Key('circProgInd'),
          ),
        ),
      ),
    );
  }
}
