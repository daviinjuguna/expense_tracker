import 'package:formz/formz.dart';

///Name form input validation error
enum NameValidationError {
  /// Password is weak (generic validation error)
  empty,
}

class _Name extends FormzInput<String, NameValidationError> {
  const _Name.pure() : super.pure('');

  const _Name.dirty([super.value = '']) : super.dirty();

  static final RegExp _nameRegExp = RegExp(
    r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$',
  );

  @override
  NameValidationError? validator(String? value) {
    return _nameRegExp.hasMatch(value ?? '') ? null : NameValidationError.empty;
  }
}

/// {@template firstName}
/// Reusable firstName form input.
/// {@endtemplate}
class FirstName extends _Name {
  /// {@macro name}
  @override
  const FirstName.pure() : super.pure();

  /// {@macro name}
  @override
  const FirstName.dirty([super.value = '']) : super.dirty();
}

/// {@template lastName}
/// Reusable lastName form input.
/// {@endtemplate}
class LastName extends _Name {
  /// {@macro name}
  @override
  const LastName.pure() : super.pure();

  /// {@macro name}
  @override
  const LastName.dirty([super.value = '']) : super.dirty();
}
