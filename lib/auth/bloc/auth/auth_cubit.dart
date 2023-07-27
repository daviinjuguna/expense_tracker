import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:expense_tracker/auth/auth.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._repo) : super(AuthState());
  final AuthRepo _repo;

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(
      email: email,
      isValid: Formz.validate([email, state.password, state.confirmPassword]),
      loginValid: Formz.validate([email, state.password]),
    ));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(state.copyWith(
      password: password,
      isValid: Formz.validate([state.email, password, state.confirmPassword]),
      loginValid: Formz.validate([state.email, password]),
    ));
  }

  void confirmPasswordChanged(String value) {
    final confirmPassword = ConfirmPassword.dirty(
      password: state.password.value,
      value: value,
    );
    emit(state.copyWith(
      confirmPassword: confirmPassword,
      isValid: Formz.validate([state.email, state.password, confirmPassword]),
    ));
  }

  void signInWithGoogle() => _repoAuth(_repo.signInWithGoogle());

  void signIn() async {
    if (state.loginValid) {
      return _repoAuth(_repo.signIn(state.email.value, state.password.value));
    }
  }

  void signUp() async {
    if (state.isValid) {
      return _repoAuth(_repo.signUp(state.email.value, state.password.value));
    }
  }

  Future<void> _repoAuth(final Future<Either<String, Unit>> function) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    final result = await function;
    result.fold(
      (l) => emit(state.copyWith(
        status: FormzSubmissionStatus.failure,
        errorCode: l,
      )),
      (r) => emit(state.copyWith(status: FormzSubmissionStatus.success)),
    );
  }
}
