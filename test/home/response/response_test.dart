import 'package:expense_tracker/home/home.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Can be instantiated', () {
    test('with success constructor', () {
      expect(FirebaseResponse.success([]), isNotNull);
    });

    test('with error constructor', () {
      expect(FirebaseResponse.error('error'), isNotNull);
    });
  });

  group('Equality and hashcode', () {
    test('equality', () {
      expect(
        FirebaseResponse.error("Error"),
        FirebaseResponse.error("Error"),
      );
    });

    test('hashcode', () {
      expect(
        FirebaseResponse.error("Error").hashCode,
        FirebaseResponse.error("Error").hashCode,
      );
    });
  });
}
