import 'package:bloc_test/bloc_test.dart';
import 'package:expense_tracker/app/app.dart';
import 'package:expense_tracker/auth/auth.dart';
import 'package:expense_tracker/theme_selector/theme_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/helpers.dart';

class MockThemeModeBloc extends MockBloc<ThemeModeEvent, ThemeMode>
    implements ThemeModeBloc {
  @override
  ThemeMode get state => ThemeMode.system;
}

class MockSplashBloc extends MockBloc<SplashEvent, SplashState>
    implements SplashBloc {
  @override
  SplashState get state => SplashState.authenticated;
}

void main() {
  initMockHydratedStorage();
  late final ThemeModeBloc themeModeBloc;
  late final SplashBloc splashBloc;

  setUp(() {
    themeModeBloc = MockThemeModeBloc();
    splashBloc = MockSplashBloc();
  });

  group('App', () {
    testWidgets('renders App View', (tester) async {
      await tester.pumpWidget(App(
        themeModeBloc: themeModeBloc,
        splashBloc: splashBloc,
      ));
      expect(find.byType(AppView), findsOneWidget);
    });
  });
}
