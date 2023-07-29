import 'package:dartz/dartz.dart';
import 'package:expense_tracker/auth/auth.dart';
import 'package:expense_tracker/exceptions/exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthSource extends Mock implements AuthSource {}

void main() {
  late AuthRepo authRepo;
  late MockAuthSource authSource;

  setUp(() {
    authSource = MockAuthSource();
    authRepo = AuthRepoImpl(authSource);
  });

  const email = 'test@test.com';
  const password = 'password';

  group('Sign in', () {
    test('with email result to right as unit', () async {
      when(() => authSource.signIn(any(), any())).thenAnswer((_) async => unit);

      final result = await authRepo.signIn(email, password);
      expect(result, isA<Right<String, Unit>>());
      expect(result.isRight(), isTrue);
      expect(result.isLeft(), isFalse);
      expect(result.fold((l) => l, (r) => r), unit);
    });

    group(
      "Exception",
      () {
        test('user-not-found result to left as invalidCredentials', () async {
          when(() => authSource.signIn(any(), any())).thenThrow(
            FirebaseAuthException(code: 'user-not-found'),
          );

          final result = await authRepo.signIn(email, password);
          expect(result, isA<Left<String, Unit>>());
          expect(result.isLeft(), isTrue);
          expect(result.isRight(), isFalse);
          expect(result.fold((l) => l, (r) => r), 'invalidCredentials');
        });

        test('wrong-password result to left as invalidCredentials', () async {
          when(() => authSource.signIn(any(), any())).thenThrow(
            FirebaseAuthException(code: 'wrong-password'),
          );

          final result = await authRepo.signIn(email, password);
          expect(result, isA<Left<String, Unit>>());
          expect(result.isLeft(), isTrue);
          expect(result.isRight(), isFalse);
          expect(result.fold((l) => l, (r) => r), 'invalidCredentials');
        });

        test('invalid-email result to left as invalidEmail', () async {
          when(() => authSource.signIn(any(), any())).thenThrow(
            FirebaseAuthException(code: 'invalid-email'),
          );

          final result = await authRepo.signIn(email, password);
          expect(result, isA<Left<String, Unit>>());
          expect(result.isLeft(), isTrue);
          expect(result.isRight(), isFalse);
          expect(result.fold((l) => l, (r) => r), 'invalidEmail');
        });

        test('user-disabled result to left as userDisabled', () async {
          when(() => authSource.signIn(any(), any())).thenThrow(
            FirebaseAuthException(code: 'user-disabled'),
          );

          final result = await authRepo.signIn(email, password);
          expect(result, isA<Left<String, Unit>>());
          expect(result.isLeft(), isTrue);
          expect(result.isRight(), isFalse);
          expect(result.fold((l) => l, (r) => r), 'userDisabled');
        });

        //any firebase exception is default
        test('firebase display default', () async {
          when(() => authSource.signIn(any(), any()))
              .thenThrow(FirebaseAuthException(code: 'oops'));

          final result = await authRepo.signIn(email, password);
          expect(result, isA<Left<String, Unit>>());
          expect(result.isLeft(), isTrue);
          expect(result.isRight(), isFalse);
          expect(result.fold((l) => l, (r) => r), 'signInError');
        });

        test('default display default', () async {
          when(() => authSource.signIn(any(), any()))
              .thenThrow(Exception('oops'));

          final result = await authRepo.signIn(email, password);
          expect(result, isA<Left<String, Unit>>());
          expect(result.isLeft(), isTrue);
          expect(result.isRight(), isFalse);
          expect(result.fold((l) => l, (r) => r), 'signInError');
        });
      },
    );
  });

  group('Sign up', () {
    test('with email result to right as unit', () async {
      when(() => authSource.signUp(any(), any())).thenAnswer((_) async => unit);

      final result = await authRepo.signUp(email, password);
      expect(result, isA<Right<String, Unit>>());
      expect(result.isRight(), isTrue);
      expect(result.isLeft(), isFalse);
      expect(result.fold((l) => l, (r) => r), unit);
    });

    group('Exception', () {
      test('email-already-in-use result to left as emailAlreadyInUse',
          () async {
        when(() => authSource.signUp(any(), any())).thenThrow(
          FirebaseAuthException(code: 'email-already-in-use'),
        );

        final result = await authRepo.signUp(email, password);
        expect(result, isA<Left<String, Unit>>());
        expect(result.isLeft(), isTrue);
        expect(result.isRight(), isFalse);
        expect(result.fold((l) => l, (r) => r), 'emailAlreadyInUse');
      });

      test('weakPassword result to left as weakPassword', () async {
        when(() => authSource.signUp(any(), any())).thenThrow(
          FirebaseAuthException(code: 'weak-password'),
        );

        final result = await authRepo.signUp(email, password);
        expect(result, isA<Left<String, Unit>>());
        expect(result.isLeft(), isTrue);
        expect(result.isRight(), isFalse);
        expect(result.fold((l) => l, (r) => r), 'weakPassword');
      });

      test('invalidEmail result to left as invalidEmail', () async {
        when(() => authSource.signUp(any(), any())).thenThrow(
          FirebaseAuthException(code: 'invalid-email'),
        );

        final result = await authRepo.signUp(email, password);
        expect(result, isA<Left<String, Unit>>());
        expect(result.isLeft(), isTrue);
        expect(result.isRight(), isFalse);
        expect(result.fold((l) => l, (r) => r), 'invalidEmail');
      });

      //any firebase exception is default
      test('firebase display default', () async {
        when(() => authSource.signUp(any(), any()))
            .thenThrow(FirebaseAuthException(code: 'oops'));

        final result = await authRepo.signUp(email, password);
        expect(result, isA<Left<String, Unit>>());
        expect(result.isLeft(), isTrue);
        expect(result.isRight(), isFalse);
        expect(result.fold((l) => l, (r) => r), 'signUpError');
      });

      test('default display default', () async {
        when(() => authSource.signUp(any(), any()))
            .thenThrow(Exception('oops'));

        final result = await authRepo.signUp(email, password);
        expect(result, isA<Left<String, Unit>>());
        expect(result.isLeft(), isTrue);
        expect(result.isRight(), isFalse);
        expect(result.fold((l) => l, (r) => r), 'signUpError');
      });
    });
  });

  group('google sign in', () {
    test('result to right as unit when success', () async {
      when(() => authSource.signInWithGoogle()).thenAnswer((_) async => unit);

      final result = await authRepo.signInWithGoogle();
      expect(result, isA<Right<String, Unit>>());
      expect(result.isRight(), isTrue);
      expect(result.isLeft(), isFalse);
      expect(result.fold((l) => l, (r) => r), unit);
    });

    group('Exception', () {
      //account-exists-with-different-credential
      test(
          'account-exists-with-different-credential result to left as accountExistsWithDifferentCredential',
          () async {
        when(() => authSource.signInWithGoogle()).thenThrow(
          FirebaseAuthException(
              code: 'account-exists-with-different-credential'),
        );

        final result = await authRepo.signInWithGoogle();
        expect(result, isA<Left<String, Unit>>());
        expect(result.isLeft(), isTrue);
        expect(result.isRight(), isFalse);
        //in camelCase
        expect(result.fold((l) => l, (r) => r),
            'accountExistsWithDifferentCredential');
      });

      test('user-disabled result to left as userDisabled', () async {
        when(() => authSource.signInWithGoogle()).thenThrow(
          FirebaseAuthException(code: 'user-disabled'),
        );

        final result = await authRepo.signInWithGoogle();
        expect(result, isA<Left<String, Unit>>());
        expect(result.isLeft(), isTrue);
        expect(result.isRight(), isFalse);
        //in camelCase
        expect(result.fold((l) => l, (r) => r), 'userDisabled');
      });

      //any firebase exception is default
      test('firebase display default', () async {
        when(() => authSource.signInWithGoogle())
            .thenThrow(FirebaseAuthException(code: 'oops'));

        final result = await authRepo.signInWithGoogle();
        expect(result, isA<Left<String, Unit>>());
        expect(result.isLeft(), isTrue);
        expect(result.isRight(), isFalse);
        //in camelCase
        expect(result.fold((l) => l, (r) => r), 'signInError');
      });

      test('google sign in cancelled display google sign in cancelled',
          () async {
        when(() => authSource.signInWithGoogle())
            .thenThrow(GoogleSignInCancelledException());

        final result = await authRepo.signInWithGoogle();
        expect(result, isA<Left<String, Unit>>());
        expect(result.isLeft(), isTrue);
        expect(result.isRight(), isFalse);
        //in camelCase
        expect(result.fold((l) => l, (r) => r), 'googleSignInCancelled');
      });

      test('default display default', () async {
        when(() => authSource.signInWithGoogle()).thenThrow(Exception('oops'));

        final result = await authRepo.signInWithGoogle();
        expect(result, isA<Left<String, Unit>>());
        expect(result.isLeft(), isTrue);
        expect(result.isRight(), isFalse);
        //in camelCase
        expect(result.fold((l) => l, (r) => r), 'signInError');
      });
    });
  });

  group('Sign out', () {
    test('result to right as unit', () async {
      when(() => authSource.signOut()).thenAnswer((_) async => unit);

      final result = await authRepo.signOut();
      expect(result, isA<Right<String, Unit>>());
      expect(result.isRight(), isTrue);
      expect(result.isLeft(), isFalse);
      expect(result.fold((l) => l, (r) => r), unit);
    });

    group('Exception', () {
      test('firebase display default', () async {
        when(() => authSource.signOut())
            .thenThrow(FirebaseAuthException(code: 'oops'));

        final result = await authRepo.signOut();
        expect(result, isA<Left<String, Unit>>());
        expect(result.isLeft(), isTrue);
        expect(result.isRight(), isFalse);
        expect(result.fold((l) => l, (r) => r), 'signOutError');
      });
      test('default display default', () async {
        when(() => authSource.signOut()).thenThrow(Exception('oops'));

        final result = await authRepo.signOut();
        expect(result, isA<Left<String, Unit>>());
        expect(result.isLeft(), isTrue);
        expect(result.isRight(), isFalse);
        expect(result.fold((l) => l, (r) => r), 'signOutError');
      });
    });
  });

  group('Watch auth state', () {
    test('result to authenticated when authenticated is result', () {
      when(() => authSource.watchAuthState())
          .thenAnswer((_) => Stream.value(AuthenticationState.authenticated));

      final result = authRepo.watchAuthState();
      expect(result, emits(AuthenticationState.authenticated));
    });

    test('result to unauthenticated when unauthenticated is result', () {
      when(() => authSource.watchAuthState())
          .thenAnswer((_) => Stream.value(AuthenticationState.unauthenticated));

      final result = authRepo.watchAuthState();
      expect(result, emits(AuthenticationState.unauthenticated));
    });

    test('result to unknown when unknown is result', () {
      when(() => authSource.watchAuthState())
          .thenAnswer((_) => Stream.value(AuthenticationState.unknown));

      final result = authRepo.watchAuthState();
      expect(result, emits(AuthenticationState.unknown));
    });
  });
}
