import 'package:expense_tracker/auth/auth.dart';
import 'package:expense_tracker/router/router.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/helpers.dart';

void main() {
  late AppRouter router;

  setUp(() {
    router = AppRouter();
  });

  tearDown(() {
    router.dispose();
  });

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
      router.navigate(LoginRoute());
      await tester.pump();
      expect(router.current.name, LoginRoute.name);
      expect(find.byType(LoginPage), findsOneWidget);
    },
  );
}
