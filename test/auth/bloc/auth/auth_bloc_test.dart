import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:expense_tracker/auth/auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:mockingjay/mockingjay.dart';

class MockAuthRepo extends Mock implements AuthRepo {}

const invalidEmailString = 'invalid';
const invalidEmail = Email.dirty(invalidEmailString);

const validEmailString = 'test@gmail.com';
const validEmail = Email.dirty(validEmailString);

const invalidPasswordString = 'inv';
const invalidPassword = Password.dirty(invalidPasswordString);

const validPasswordString = 't0pS3cret1234';
const validPassword = Password.dirty(validPasswordString);

const invalidCPasswordString = 'invalid';
const validCPasswordString = validPasswordString;

const invalidCPassword = ConfirmPassword.dirty(
  password: validPasswordString,
  value: invalidCPasswordString,
);

const validCPassword = ConfirmPassword.dirty(
  password: validPasswordString,
  value: validPasswordString,
);
void main() {
  late MockAuthRepo mockRepo;
  late AuthCubit authCubit;

  setUp(() {
    mockRepo = MockAuthRepo();
    authCubit = AuthCubit(mockRepo);
  });

  group('AuthBloc', () {
    test('Initial login state', () {
      expect(authCubit.state, const AuthState());
    });
    group('EmailChanged', () {
      blocTest<AuthCubit, AuthState>(
        'emits [invalid] when email/password are invalid',
        build: () => authCubit,
        act: (bloc) => bloc.emailChanged(invalidEmailString),
        expect: () => const <AuthState>[AuthState(email: invalidEmail)],
      );
    });
    blocTest<AuthCubit, AuthState>(
      'emits [loginValid] when email/password are valid',
      build: () => authCubit,
      seed: () => const AuthState(password: validPassword),
      act: (cubit) => cubit.emailChanged(validEmailString),
      expect: () => const <AuthState>[
        AuthState(
          email: validEmail,
          password: validPassword,
          loginValid: true,
          isValid: false,
        ),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [valid] when email/password/cPassword are valid',
      build: () => authCubit,
      seed: () => const AuthState(
        password: validPassword,
        confirmPassword: validCPassword,
      ),
      act: (cubit) => cubit.emailChanged(validEmailString),
      expect: () => const <AuthState>[
        AuthState(
          email: validEmail,
          password: validPassword,
          confirmPassword: validCPassword,
          isValid: true,
          loginValid: true,
        ),
      ],
    );
  });

  group('Password Changed', () {
    blocTest<AuthCubit, AuthState>(
      'emits [invalid] when email/password are invalid',
      build: () => authCubit,
      act: (bloc) => bloc.passwordChanged(invalidPasswordString),
      expect: () => const <AuthState>[AuthState(password: invalidPassword)],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [loginValid] when email/password are valid',
      build: () => authCubit,
      seed: () => const AuthState(
        email: validEmail,
      ),
      act: (cubit) => cubit.passwordChanged(validPasswordString),
      expect: () => const <AuthState>[
        AuthState(
          email: validEmail,
          password: validPassword,
          loginValid: true,
        ),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [valid] when email/password/cpass are valid',
      build: () => authCubit,
      seed: () => const AuthState(
        email: validEmail,
        confirmPassword: validCPassword,
      ),
      act: (cubit) => cubit.passwordChanged(validPasswordString),
      expect: () => const <AuthState>[
        AuthState(
          email: validEmail,
          password: validPassword,
          confirmPassword: validCPassword,
          isValid: true,
          loginValid: true,
        ),
      ],
    );
  });

  group('Confirm Password Changed', () {
    blocTest<AuthCubit, AuthState>(
      'emits [invalid] when email/password/cPassword are invalid',
      build: () => authCubit,
      act: (bloc) => bloc.confirmPasswordChanged(invalidCPasswordString),
      expect: () =>
          const <AuthState>[AuthState(confirmPassword: invalidCPassword)],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [valid] when email/password/cpass are valid',
      build: () => authCubit,
      seed: () => const AuthState(
        email: validEmail,
        password: validPassword,
      ),
      act: (cubit) => cubit.confirmPasswordChanged(validCPasswordString),
      expect: () => const <AuthState>[
        AuthState(
          email: validEmail,
          password: validPassword,
          confirmPassword: validCPassword,
          isValid: true,
        ),
      ],
    );
  });

  group('Sign in', () {
    blocTest<AuthCubit, AuthState>(
      'does nothing when status is not validated',
      build: () => authCubit,
      act: (cubit) => cubit.signIn(),
      expect: () => const <AuthState>[],
    );

    blocTest<AuthCubit, AuthState>(
      'calls signIn with correct email/password',
      build: () => authCubit,
      setUp: () {
        when(
          () => mockRepo.signIn(
            validEmailString,
            validPasswordString,
          ),
        ).thenAnswer((_) async => right(unit));
      },
      seed: () => const AuthState(
        email: validEmail,
        password: validPassword,
        loginValid: true,
      ),
      act: (cubit) => cubit.signIn(),
      verify: (_) {
        verify(
          () => mockRepo.signIn(
            validEmailString,
            validPasswordString,
          ),
        ).called(1);
      },
    );
    blocTest<AuthCubit, AuthState>(
      'emits [submissionInProgress, submissionSuccess] '
      'when sign in succeeds',
      build: () => authCubit,
      setUp: () {
        when(
          () => mockRepo.signIn(
            validEmailString,
            validPasswordString,
          ),
        ).thenAnswer((_) async => right(unit));
      },
      seed: () => const AuthState(
        email: validEmail,
        password: validPassword,
        loginValid: true,
      ),
      act: (cubit) => cubit.signIn(),
      expect: () => <AuthState>[
        const AuthState(
          status: FormzSubmissionStatus.inProgress,
          email: validEmail,
          password: validPassword,
          loginValid: true,
        ),
        AuthState(
          status: FormzSubmissionStatus.success,
          email: validEmail,
          password: validPassword,
          loginValid: true,
        )
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [submissionInProgress, submissionFailure] '
      'when sign in fails '
      'result in left',
      setUp: () {
        when(
          () => mockRepo.signIn(any(), any()),
        ).thenAnswer((_) async => left('error-code'));
      },
      build: () => authCubit,
      seed: () => const AuthState(
        email: validEmail,
        password: validPassword,
        loginValid: true,
      ),
      act: (cubit) => cubit.signIn(),
      expect: () => const <AuthState>[
        AuthState(
          status: FormzSubmissionStatus.inProgress,
          email: validEmail,
          password: validPassword,
          loginValid: true,
        ),
        AuthState(
          status: FormzSubmissionStatus.failure,
          errorCode: 'error-code',
          email: validEmail,
          password: validPassword,
          loginValid: true,
        )
      ],
    );
  });

  group('Sign up', () {
    blocTest<AuthCubit, AuthState>(
      'does nothing when status is not validated',
      build: () => authCubit,
      act: (cubit) => cubit.signUp(),
      expect: () => const <AuthState>[],
    );

    blocTest<AuthCubit, AuthState>(
      'calls signUp with correct email/password',
      build: () => authCubit,
      setUp: () {
        when(
          () => mockRepo.signUp(
            validEmailString,
            validPasswordString,
          ),
        ).thenAnswer((_) async => right(unit));
      },
      seed: () => const AuthState(
        email: validEmail,
        password: validPassword,
        isValid: true,
      ),
      act: (cubit) => cubit.signUp(),
      verify: (_) {
        verify(
          () => mockRepo.signUp(
            validEmailString,
            validPasswordString,
          ),
        ).called(1);
      },
    );
    blocTest<AuthCubit, AuthState>(
      'emits [submissionInProgress, submissionSuccess] '
      'when sign up succeeds',
      build: () => authCubit,
      setUp: () {
        when(
          () => mockRepo.signUp(
            validEmailString,
            validPasswordString,
          ),
        ).thenAnswer((_) async => right(unit));
      },
      seed: () => const AuthState(
        email: validEmail,
        password: validPassword,
        isValid: true,
      ),
      act: (cubit) => cubit.signUp(),
      expect: () => <AuthState>[
        const AuthState(
          status: FormzSubmissionStatus.inProgress,
          email: validEmail,
          password: validPassword,
          isValid: true,
        ),
        AuthState(
          status: FormzSubmissionStatus.success,
          email: validEmail,
          password: validPassword,
          isValid: true,
        )
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [submissionInProgress, submissionFailure] '
      'when sign up fails '
      'result in left',
      setUp: () {
        when(
          () => mockRepo.signUp(any(), any()),
        ).thenAnswer((_) async => left('error-code'));
      },
      build: () => authCubit,
      seed: () => const AuthState(
        email: validEmail,
        password: validPassword,
        isValid: true,
      ),
      act: (cubit) => cubit.signUp(),
      expect: () => const <AuthState>[
        AuthState(
          status: FormzSubmissionStatus.inProgress,
          email: validEmail,
          password: validPassword,
          isValid: true,
        ),
        AuthState(
          status: FormzSubmissionStatus.failure,
          errorCode: 'error-code',
          email: validEmail,
          password: validPassword,
          isValid: true,
        )
      ],
    );
  });

  group('Sign in with google', () {
    blocTest<AuthCubit, AuthState>(
      'calls signInWithGoogle',
      build: () => authCubit,
      setUp: () {
        when(
          () => mockRepo.signInWithGoogle(),
        ).thenAnswer((_) async => right(unit));
      },
      act: (cubit) => cubit.signInWithGoogle(),
      verify: (_) {
        verify(
          () => mockRepo.signInWithGoogle(),
        ).called(1);
      },
    );

    blocTest<AuthCubit, AuthState>(
      'emits [submissionInProgress, submissionSuccess] '
      'when signInWithGoogle succeeds',
      build: () => authCubit,
      setUp: () {
        when(
          () => mockRepo.signInWithGoogle(),
        ).thenAnswer((_) async => right(unit));
      },
      act: (cubit) => cubit.signInWithGoogle(),
      expect: () => <AuthState>[
        const AuthState(
          status: FormzSubmissionStatus.inProgress,
        ),
        AuthState(
          status: FormzSubmissionStatus.success,
        )
      ],
    );
    blocTest<AuthCubit, AuthState>(
      'emits [submissionInProgress, submissionFailure] '
      'when signInWithGoogle fails '
      'result in left',
      setUp: () {
        when(
          () => mockRepo.signInWithGoogle(),
        ).thenAnswer((_) async => left('error-code'));
      },
      build: () => authCubit,
      act: (cubit) => cubit.signInWithGoogle(),
      expect: () => const <AuthState>[
        AuthState(
          status: FormzSubmissionStatus.inProgress,
        ),
        AuthState(
          status: FormzSubmissionStatus.failure,
          errorCode: 'error-code',
        )
      ],
    );
  });
}
