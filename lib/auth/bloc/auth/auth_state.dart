part of 'auth_cubit.dart';

@immutable
class AuthState {
  final Email email;
  final Password password;
  final ConfirmPassword confirmPassword;
  final FormzSubmissionStatus status;
  final bool isValid;
  final bool loginValid;
  final String errorCode;

  const AuthState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmPassword = const ConfirmPassword.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
    this.loginValid = false,
    this.errorCode = '',
  });

  AuthState copyWith({
    Email? email,
    Password? password,
    ConfirmPassword? confirmPassword,
    FormzSubmissionStatus? status,
    bool? isValid,
    bool? loginValid,
    String? errorCode,
  }) {
    return AuthState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      loginValid: loginValid ?? this.loginValid,
      errorCode: errorCode ?? this.errorCode,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthState &&
        other.email == email &&
        other.password == password &&
        other.confirmPassword == confirmPassword &&
        other.status == status &&
        other.isValid == isValid &&
        other.loginValid == loginValid &&
        other.errorCode == errorCode;
  }

  @override
  int get hashCode {
    return email.hashCode ^
        password.hashCode ^
        confirmPassword.hashCode ^
        status.hashCode ^
        isValid.hashCode ^
        loginValid.hashCode ^
        errorCode.hashCode;
  }

  @override
  String toString() {
    return 'AuthState(status: $status, isValid: $isValid, loginValid: $loginValid, errorCode: $errorCode)';
  }
}
