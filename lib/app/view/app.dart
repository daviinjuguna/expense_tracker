import 'package:expense_tracker/app/view/app_view.dart';
import 'package:expense_tracker/auth/auth.dart';
import 'package:expense_tracker/di/injection.dart';
import 'package:expense_tracker/theme_selector/theme_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    this.themeModeBloc,
    this.splashBloc,
  });

  @visibleForTesting
  final ThemeModeBloc? themeModeBloc;
  @visibleForTesting
  final SplashBloc? splashBloc;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeModeBloc>(create: (_) => themeModeBloc ?? getIt()),
        BlocProvider<SplashBloc>(
            create: (_) => (splashBloc ?? getIt())..add(StartSplashEvent())),
      ],
      child: const AppView(),
    );
  }
}
