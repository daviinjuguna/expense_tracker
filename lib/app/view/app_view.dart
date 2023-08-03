import 'package:expense_tracker/auth/auth.dart';
import 'package:expense_tracker/l10n/l10n.dart';
import 'package:expense_tracker/router/router.dart';
import 'package:expense_tracker/theme_selector/theme_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppView extends StatefulWidget {
  const AppView({
    super.key,
    this.authCubit,
  });

  @visibleForTesting
  final AuthCubit? authCubit;

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  late final GoRouter _appRouter;
  //blocs

  @override
  void initState() {
    super.initState();
    _appRouter = GoRouter(
      routes: $appRoutes,
      navigatorKey: _navigatorKey,
      initialLocation: SplashRoute().location,
    );
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
                _appRouter.go(HomeRoute().location);
                break;
              case SplashState.unauthenticated:
                _appRouter.go(LoginRoute().location, extra: widget.authCubit);
                break;
              default:
            }
          },
        ),
      ],
      child: BlocBuilder<ThemeModeBloc, ThemeMode>(
        builder: (context, state) {
          return MaterialApp.router(
            theme: ThemeData.from(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Color(0xffe9b96e),
                brightness: Brightness.light,
              ),
              useMaterial3: true,
            ),
            darkTheme: ThemeData.from(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Color(0xff8f5902),
                brightness: Brightness.dark,
              ),
              useMaterial3: true,
            ),
            themeMode: state,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            routerConfig: _appRouter,
          );
        },
      ),
    );
  }
}
