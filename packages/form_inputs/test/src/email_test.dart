import 'package:flutter_test/flutter_test.dart';
import 'package:form_inputs/form_inputs.dart';

void main() {
  const emailStr = 'davidnjugunaofficial25@gmail.com';

  group('constructors', () {
    test('pure creates correct instance', () {
      const email = Email.pure();
      expect(email.value, '');
      expect(email.isPure, true);
    });
    test('dirty creates correct instance', () {
      const email = Email.dirty(emailStr);
      expect(email.value, emailStr);
      expect(email.isPure, false);
    });
  });

  group('validator', () {
    test('returns invalid error when email is empty', () {
      expect(
        const Email.dirty().error,
        EmailValidationError.invalid,
      );
    });

    test('returns invalid error when email is malformed', () {
      expect(
        const Email.dirty('test').error,
        EmailValidationError.invalid,
      );
    });

    test('is valid when email is valid', () {
      expect(
        const Email.dirty(emailStr).error,
        isNull,
      );
    });
  });
}
