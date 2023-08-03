import 'package:bloc_test/bloc_test.dart';
import 'package:expense_tracker/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';

import '../../helpers/helpers.dart';

class MockSplashBloc extends MockBloc<SplashEvent, SplashState>
    implements SplashBloc {}

// @GenerateNiceMocks([MockSpec<AutoRouterObserver>()])
void main() {
  late SplashBloc bloc;
  setUp(() {
    bloc = MockSplashBloc();

    when(() => bloc.state).thenReturn(SplashState.initial);
  });
  testWidgets('Splash page contains circular indicator', (tester) async {
    await tester.pumpApp(const SplashPage());
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  // group('Authentication', () {
  //   testWidgets(
  //     "navigates to login when unauthenticated",
  //     (WidgetTester tester) async {
  //       // await tester.pumpRouterApp(router, splashBloc: bloc);

  //       await tester.pumpRouterConfigApp(
  //         router.config(
  //           navigatorObservers: () => [MockAutoRouterObserver()],
  //         ),
  //         observers: () => [MockAutoRouterObserver()],
  //         splashBloc: bloc,
  //       );
  //       await tester.pump(const Duration(milliseconds: 750));
  //       whenListen(
  //           bloc,
  //           Stream.fromIterable([
  //             SplashState.loading,
  //             SplashState.unauthenticated,
  //           ]));
  //       expect(find.byType(SplashPage), findsOneWidget);
  //     },
  //   );
  // });
}
