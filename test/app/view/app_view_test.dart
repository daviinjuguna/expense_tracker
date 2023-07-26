import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';

import 'package:expense_tracker/app/app.dart';
import 'package:expense_tracker/auth/auth.dart';
import 'package:expense_tracker/theme_selector/theme_selector.dart';

class MockThemeModeBloc extends MockBloc<ThemeModeEvent, ThemeMode>
    implements ThemeModeBloc {}

class MockSplashBloc extends MockBloc<SplashEvent, SplashState>
    implements SplashBloc {}

void main() {
  // initMockHydratedStorage();
  late ThemeModeBloc themeModeBloc;
  late SplashBloc splashBloc;
  // setUp();

  setUp(() {
    // configureTestInjection();
    themeModeBloc = MockThemeModeBloc();
    splashBloc = MockSplashBloc();
  });

  group('AppTheme', () {
    testWidgets('test on theme when set', (tester) async {
      when(() => themeModeBloc.state).thenAnswer((_) => ThemeMode.light);
      when(() => splashBloc.state).thenReturn(SplashState.unauthenticated);
      // await tester.pumpAppView(const AppView(), themeModeBloc: themeModeBloc);
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<SplashBloc>.value(value: splashBloc),
            BlocProvider.value(value: themeModeBloc),
          ],
          child: AppView(),
        ),
      );
      await tester.pump();
      final BuildContext context = tester.element(find.byType(MaterialApp));
      expect(MediaQuery.of(context).platformBrightness, Brightness.light);
    });
  });

  // group('SplashBloc', () {
  //   testWidgets(
  //     "Unauthenticated state should navigate to Login Page",
  //     (WidgetTester tester) async {
  //       when(() => splashBloc.state)
  //           .thenAnswer((_) => SplashState.authenticated);
  //       when(() => themeModeBloc.state).thenAnswer((_) => ThemeMode.light);
  //       await tester.pumpWidget(App(
  //         themeModeBloc: themeModeBloc,
  //         splashBloc: splashBloc,
  //       ));
  //       await tester.pump(Duration(seconds: 5));
  //       expect(find.byType(LoginPage), findsOneWidget);
  //     },
  //   );
  // });
}
