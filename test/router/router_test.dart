import 'package:bloc_test/bloc_test.dart';
import 'package:expense_tracker/auth/auth.dart';
import 'package:expense_tracker/home/home.dart';
import 'package:expense_tracker/router/router.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/helpers.dart';

class MockAuthBloc extends MockCubit<AuthState> implements AuthCubit {
  @override
  AuthState get state => const AuthState();
}

void main() {
  late AppRouter router;

  setUp(() {
    router = AppRouter();
  });

  tearDown(() {
    router.dispose();
  });

  group('AppRouter', () {
    testWidgets('Initial route should be ${SplashRoute.name}',
        (WidgetTester tester) async {
      await tester.pumpRouterApp(router);
      expect(router.urlState.url, '/');
      expect(router.current.name, SplashRoute.name);
      await tester.pump();
      expect(find.byType(SplashPage), findsOneWidget);
    });

    testWidgets(
      "Navigation to ${LoginRoute.name} should push ${LoginRoute.name} page",
      (WidgetTester tester) async {
        await tester.pumpRouterApp(router);
        router.navigate(LoginRoute(authCubit: MockAuthBloc()));
        await tester.pump();
        expect(router.current.name, LoginRoute.name);
        expect(find.byType(LoginPage), findsOneWidget);
      },
    );
    testWidgets(
      "Navigation to RegisterRoute should push RegisterPage page",
      (WidgetTester tester) async {
        await tester.pumpRouterApp(router);
        router.navigate(RegisterRoute(authCubit: MockAuthBloc()));
        await tester.pump();
        expect(router.current.name, RegisterRoute.name);
        expect(find.byType(RegisterPage), findsOneWidget);
      },
    );

    testWidgets(
      "Navigation to HomeRoute should push HomePage page",
      (WidgetTester tester) async {
        await tester.pumpRouterApp(router);
        router.navigate(HomeRoute());
        await tester.pump();
        expect(router.current.name, HomeRoute.name);
        expect(find.byType(HomePage), findsOneWidget);
      },
    );
  });
}
