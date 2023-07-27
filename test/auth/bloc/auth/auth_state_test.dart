import 'package:expense_tracker/auth/auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

void main() {
  group('AuthState', () {
    test('Initial values', () {
      final state = AuthState();
      expect(state.email, const Email.pure());
      expect(state.password, const Password.pure());
      expect(state.confirmPassword, const ConfirmPassword.pure());
      expect(state.status, FormzSubmissionStatus.initial);
      expect(state.isValid, false);
      expect(state.loginValid, false);
      expect(state.errorCode, '');
    });

    test('copyWith comparison', () {
      final state = AuthState();
      expect(state, state.copyWith());
    });

    test('copyWith properties', () {
      final state = AuthState();
      expect(
        state.copyWith(
          email: const Email.dirty('email'),
          password: const Password.dirty('password'),
          confirmPassword:
              ConfirmPassword.dirty(password: 'password', value: 'password'),
          status: FormzSubmissionStatus.success,
          isValid: true,
          loginValid: true,
          errorCode: 'errorCode',
        ),
        AuthState(
          email: const Email.dirty('email'),
          password: const Password.dirty('password'),
          confirmPassword:
              ConfirmPassword.dirty(password: 'password', value: 'password'),
          status: FormzSubmissionStatus.success,
          isValid: true,
          loginValid: true,
          errorCode: 'errorCode',
        ),
      );
    });

    test('copyWith null properties', () {
      final state = AuthState();
      expect(
        state.copyWith(
          email: null,
          password: null,
          status: null,
          isValid: null,
          errorCode: null,
        ),
        AuthState(),
      );
    });

    //hashcode
    test('hashcode', () {
      final state = AuthState();
      expect(
        state.hashCode,
        AuthState().hashCode,
      );
    });
  });
}
