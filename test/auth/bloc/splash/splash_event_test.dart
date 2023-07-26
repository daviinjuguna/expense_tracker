import 'package:expense_tracker/auth/auth.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const authState = AuthenticationState.authenticated;
  const authState2 = AuthenticationState.unauthenticated;

  group('StartSplashEvent', () {
    test('is a type of SplashEvent', () {
      expect(StartSplashEvent(), isA<SplashEvent>());
    });

    test('can be instantiated', () {
      expect(StartSplashEvent(), isNotNull);
    });
  });

  group('ReceiveSplashEvent', () {
    test('is a type of SplashEvent', () {
      expect(ReceiveSplashEvent(authState), isA<SplashEvent>());
    });

    test('can be instantiated', () {
      expect(ReceiveSplashEvent(authState), isNotNull);
    });

    test('supports comparison', () {
      final event = ReceiveSplashEvent(authState);
      final event2 = ReceiveSplashEvent(authState2);

      expect(event, ReceiveSplashEvent(authState));
      expect(event, isNot(equals(event2)));
      //hashcode
      expect(event.hashCode, ReceiveSplashEvent(authState).hashCode);
      expect(event.hashCode, isNot(equals(event2.hashCode)));
    });
  });
}
