import 'package:formz/formz.dart';

///ConfirmPassword form input validation error
enum ConfirmPasswordValidationError {
  /// ConfirmPassword is weak (generic validation error)
  notMatch,
}

///{@template confirmPasswordValidationMixin}
/// ConfirmPassword form input validation mixin
/// {@endtemplate}

class ConfirmPassword
    extends FormzInput<String, ConfirmPasswordValidationError> {
  /// {@macro confirm password}
  const ConfirmPassword.pure({this.password = 'pure'}) : super.pure('');

  /// {@macro confirm password}
  const ConfirmPassword.dirty({required this.password, String value = ''})
      : super.dirty(value);

  /// Password to compare with
  final String password;

  @override
  ConfirmPasswordValidationError? validator(String value) {
    return password == value ? null : ConfirmPasswordValidationError.notMatch;
  }
}
