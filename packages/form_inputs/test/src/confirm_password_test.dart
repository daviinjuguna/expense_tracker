import 'package:flutter_test/flutter_test.dart';
import 'package:form_inputs/form_inputs.dart';

void main() {
  const password = 'test1234';
  group('Confirm password', () {
    group('constructors', () {
      test('pure creates correct instance', () {
        const cPassword = ConfirmPassword.pure();
        expect(cPassword.value, '');
        expect(cPassword.isPure, true);
      });
      test('dirty creates correct instance', () {
        const cPassword = ConfirmPassword.dirty(
          password: password,
          value: 'test',
        );
        expect(cPassword.value, 'test');
        expect(cPassword.isPure, false);
      });
    });
  });

  group('validator', () {
    test('returns not match when c-password is empty', () {
      expect(
        const ConfirmPassword.dirty(password: password).error,
        ConfirmPasswordValidationError.notMatch,
      );
    });

    test('returns not match when password is malformed', () {
      expect(
        const ConfirmPassword.dirty(password: password, value: 'test').error,
        ConfirmPasswordValidationError.notMatch,
      );
    });

    test('is valid when password is valid', () {
      expect(
        const ConfirmPassword.dirty(
          password: password,
          value: 'test1234',
        ).error,
        isNull,
      );
    });
  });
}
