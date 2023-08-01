// coverage:ignore-file

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
  }

  @override
  void dispose() {
    _appRouter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeModeBloc, ThemeMode>(
      builder: (context, state) {
        return MaterialApp.router(
          theme: ThemeData.from(
            colorScheme: ColorScheme.fromSeed(seedColor: Color(0xffe9b96e)),
            useMaterial3: true,
          ),
          darkTheme: ThemeData.from(
            colorScheme: ColorScheme.fromSeed(seedColor: Color(0xff8f5902)),
            useMaterial3: true,
          ),
          themeMode: state,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          routeInformationParser: _appRouter.defaultRouteParser(),
          routerDelegate: _appRouter.delegate(),
          // routerConfig: _appRouter.config(),
        );
      },
    );
  }
}
