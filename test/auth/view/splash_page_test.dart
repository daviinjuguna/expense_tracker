import 'package:expense_tracker/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/helpers.dart';

void main() {
  testWidgets('Splash page contains circular indicator', (tester) async {
    await tester.pumpApp(const SplashPage());
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
