import 'package:flutter_test/flutter_test.dart';
import 'package:form_inputs/form_inputs.dart';

void main() {
  group('Password', () {
    group('constructors', () {
      test('pure creates correct instance', () {
        const password = Password.pure();
        expect(password.value, '');
        expect(password.isPure, true);
      });
      test('dirty creates correct instance', () {
        const password = Password.dirty('test');
        expect(password.value, 'test');
        expect(password.isPure, false);
      });
    });

    group('validator', () {
      test('returns weak error when password is empty', () {
        expect(
          const Password.dirty().error,
          PasswordValidationError.weak,
        );
      });

      test('returns weak error when password is malformed', () {
        expect(
          const Password.dirty('test').error,
          PasswordValidationError.weak,
        );
      });

      test('is valid when password is valid', () {
        expect(
          const Password.dirty('test1234').error,
          isNull,
        );
      });
    });
  });
}
