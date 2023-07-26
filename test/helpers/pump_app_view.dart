import 'package:bloc_test/bloc_test.dart';
import 'package:expense_tracker/theme_selector/theme_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

class _MockThemeModeBloc extends MockBloc<ThemeModeEvent, ThemeMode>
    implements ThemeModeBloc {
  @override
  ThemeMode get state => ThemeMode.system;
}

extension PumpAppView on WidgetTester {
  Future<void> pumpAppView(
    Widget appView, {
    ThemeModeBloc? themeModeBloc,
  }) {
    return pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<ThemeModeBloc>.value(
            value: themeModeBloc ?? _MockThemeModeBloc(),
          ),
        ],
        child: appView,
      ),
    );
  }
}
