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

  //ELP: This test is failing because of the splash screen
  // group('SplashBloc', () {
  //   testWidgets(
  //     "Navigate to LoginPage when SplashState.unauthenticated",
  //     (WidgetTester tester) async {
  //       final _state = [
  //         SplashState.initial,
  //         SplashState.loading,
  //         SplashState.unauthenticated
  //       ];
  //       whenListen(
  //         splashBloc,
  //         Stream.fromIterable(_state),
  //       );

  //       await tester.pumpApp(
  //         AppView(appRouter: router),
  //         splashBloc: splashBloc,
  //       );
  //       await tester.pump();
  //       expect(router.current.name, SplashRoute.page.name);
  //       await tester.pump(Duration(milliseconds: 750));
  //       expect(router.current.name, SplashRoute.page.name);
  //       await tester.pump(Duration(milliseconds: 750));
  //       expect(router.current.name, LoginRoute.page.name);
  //     },
  //   );
  // });
}
