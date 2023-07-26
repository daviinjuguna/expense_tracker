/// {@template app_exception}
/// Abstract class to handle the supabase  exceptions.
/// {@endtemplate}
abstract class AppException implements Exception {
  /// {@macro App_exception}
  const AppException(this.error);

  /// The error which was caught.
  final Object error;
}

class AuthException extends AppException {
  const AuthException(super.error);
}
