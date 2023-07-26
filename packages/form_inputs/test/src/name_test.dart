import 'package:flutter_test/flutter_test.dart';
import 'package:form_inputs/form_inputs.dart';

void main() {
  const fNameStr = 'Davii';
  const lNameStr = 'Njuguna';
  group('First Name', () {
    group('constructors', () {
      test('pure creates correct instance', () {
        const fName = FirstName.pure();
        expect(fName.value, '');
        expect(fName.isPure, true);
      });
      test('dirty creates correct instance', () {
        const fName = FirstName.dirty(fNameStr);
        expect(fName.value, fNameStr);
        expect(fName.isPure, false);
      });
    });

    group('validator', () {
      test('returns invalid error when first name is empty', () {
        expect(
          const FirstName.dirty().error,
          NameValidationError.empty,
        );
      });

      test('returns invalid error when first name is malformed', () {
        expect(
          const FirstName.dirty().error,
          NameValidationError.empty,
        );
      });

      test('is valid when first name is valid', () {
        expect(
          const FirstName.dirty(fNameStr).error,
          isNull,
        );
      });
    });
  });
  group('Last Name', () {
    group('constructors', () {
      test('pure creates correct instance', () {
        const fName = LastName.pure();
        expect(fName.value, '');
        expect(fName.isPure, true);
      });
      test('dirty creates correct instance', () {
        const fName = LastName.dirty(lNameStr);
        expect(fName.value, lNameStr);
        expect(fName.isPure, false);
      });
    });

    group('validator', () {
      test('returns invalid error when last name is empty', () {
        expect(
          const LastName.dirty().error,
          NameValidationError.empty,
        );
      });

      test('returns invalid error when last name is malformed', () {
        expect(
          const LastName.dirty().error,
          NameValidationError.empty,
        );
      });

      test('is valid when last name is valid', () {
        expect(
          const LastName.dirty(fNameStr).error,
          isNull,
        );
      });
    });
  });
}
