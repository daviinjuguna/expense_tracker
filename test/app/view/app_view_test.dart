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
  late ThemeModeBloc themeModeBloc;
  late SplashBloc splashBloc;
  // late AppRouter router;

  setUp(() {
    themeModeBloc = MockThemeModeBloc();
    splashBloc = MockSplashBloc();
    // router = AppRouter();
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
}
