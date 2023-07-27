// coverage:ignore-file

import 'package:app_ui/app_ui.dart';
import 'package:expense_tracker/auth/auth.dart';
import 'package:expense_tracker/l10n/l10n.dart';
import 'package:expense_tracker/router/router.dart';
import 'package:expense_tracker/theme_selector/theme_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppView extends StatefulWidget {
  const AppView({super.key, this.appRouter});

  @visibleForTesting
  final AppRouter? appRouter;

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  late final AppRouter _appRouter;

  //blocs

  @override
  void initState() {
    super.initState();
    _appRouter = widget.appRouter ?? AppRouter(navigatorKey: _navigatorKey);
    context.read<SplashBloc>().add(StartSplashEvent());
  }

  @override
  void dispose() {
    _appRouter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<SplashBloc, SplashState>(
          listener: (context, state) {
            switch (state) {
              case SplashState.authenticated:
                //nav to home

                break;
              case SplashState.unauthenticated:
                //nav to login
                _appRouter.pushAndPopUntil(LoginRoute(),
                    predicate: (_) => false);
                break;
              default:
            }
          },
        )
      ],
      child: Builder(
        builder: (context) {
          return MaterialApp.router(
            theme: const AppTheme().themeData,
            darkTheme: const AppDarkTheme().themeData,
            themeMode: context.watch<ThemeModeBloc>().state,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            routeInformationParser: _appRouter.defaultRouteParser(),
            routerDelegate: _appRouter.delegate(),
            // routerConfig: _appRouter.config(),
          );
        },
      ),
    );
  }
}
