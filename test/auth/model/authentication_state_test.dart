// enum AuthenticationState { unknown, authenticated, unauthenticated }

//write test on this enum

import 'package:expense_tracker/auth/auth.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AuthenticationState', () {
    test('unknown', () {
      expect(AuthenticationState.unknown, isNotNull);
    });
    test('authenticated', () {
      expect(AuthenticationState.authenticated, isNotNull);
    });
    test('unauthenticated', () {
      expect(AuthenticationState.unauthenticated, isNotNull);
    });
  });
}
