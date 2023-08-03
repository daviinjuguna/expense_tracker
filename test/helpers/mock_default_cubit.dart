//auth
import 'package:bloc_test/bloc_test.dart';
import 'package:expense_tracker/auth/auth.dart';

class MockDefaultAuthBloc extends MockCubit<AuthState> implements AuthCubit {
  @override
  AuthState get state => const AuthState();
}
