import 'package:expense_tracker/auth/auth.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // enum SplashState { initial, loading, authenticated, unauthenticated }

  group('SplashState', () {
    test('supports value comparisons', () {
      expect(SplashState.initial, SplashState.initial);
      expect(SplashState.loading, SplashState.loading);
      expect(SplashState.authenticated, SplashState.authenticated);
      expect(SplashState.unauthenticated, SplashState.unauthenticated);
    });

    test('returns correct enum name', () {
      expect(SplashState.initial.name, 'initial');
      expect(SplashState.loading.name, 'loading');
      expect(SplashState.authenticated.name, 'authenticated');
      expect(SplashState.unauthenticated.name, 'unauthenticated');
    });

    test('returns correct enum index', () {
      expect(SplashState.initial.index, 0);
      expect(SplashState.loading.index, 1);
      expect(SplashState.authenticated.index, 2);
      expect(SplashState.unauthenticated.index, 3);
    });

    test('returns list of enum values', () {
      expect(SplashState.values, [
        SplashState.initial,
        SplashState.loading,
        SplashState.authenticated,
        SplashState.unauthenticated,
      ]);
    });
  });
}
