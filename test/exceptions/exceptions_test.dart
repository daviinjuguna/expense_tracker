import 'package:expense_tracker/exceptions/exceptions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AuthException', () {
    test("AuthException is a AppException", () {
      expect(AuthException("any"), isA<AppException>());
    });

    test('Can be instantiated', () {
      expect(AuthException('error'), isNotNull);
    });
  });

  group('GoogleSignInCancelledException', () {
    test("is a AppException", () {
      expect(GoogleSignInCancelledException(), isA<AppException>());
    });

    test('Can be instantiated', () {
      expect(GoogleSignInCancelledException(), isNotNull);
    });
  });
}
