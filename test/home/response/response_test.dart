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
}
