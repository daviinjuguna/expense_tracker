import 'package:expense_tracker/auth/auth.dart';
import 'package:expense_tracker/exceptions/exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mocktail/mocktail.dart';

class FirebaseAuthMock extends Mock implements MockFirebaseAuth {}

class GoogleSignInMock extends Mock implements GoogleSignIn {}

class MockUserCredential extends Mock implements UserCredential {
  MockUserCredential({required User? mockUser}) {
    when(() => user).thenReturn(mockUser);
  }
}

class MockGoogleSignInAccount extends Mock implements GoogleSignInAccount {}

class MockGoogleSignInAuthentication extends Mock
    implements GoogleSignInAuthentication {}

class MockGoogleAuth extends Mock implements GoogleSignIn {}

class MockUser extends Mock implements User {
  MockUser({
    String uid = 'uid',
    String email = email,
  }) {
    when(() => this.uid).thenReturn(uid);
    when(() => this.email).thenReturn(email);
  }
}

const email = 'test@test.com';
const password = 'password';
void main() {
  late AuthSource authSource;
  late FirebaseAuthMock firebaseAuth;
  late GoogleSignInMock mockGoogleSignIn;
  late final mockGoogleUser = MockGoogleSignInAccount();
  late final mockGoogleSignInAuthentication = MockGoogleSignInAuthentication();

  final mockUser = MockUser(
    uid: 'uid',
    email: email,
  );

  final mockCredentials = MockUserCredential(
    mockUser: mockUser,
  );

  setUp(() {
    firebaseAuth = FirebaseAuthMock();
    mockGoogleSignIn = GoogleSignInMock();
    authSource = AuthSourceImpl(firebaseAuth, mockGoogleSignIn);
  });
  group("Sign in", () {
    test('with email completes', () async {
      when(
        () => firebaseAuth.signInWithEmailAndPassword(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer(
        (_) async => mockCredentials,
      );

      expect(authSource.signIn(email, password), completes);
    });
    test('with email throws FirebaseAuthExeption on firebase exeption', () {
      when(
        () => firebaseAuth.signInWithEmailAndPassword(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenThrow(FirebaseAuthException(code: 'test-exception'));
      expect(
        authSource.signIn(email, password),
        throwsA(isA<FirebaseAuthException>()),
      );
    });
    test('with email throws AuthExeption on  exeption', () {
      when(
        () => firebaseAuth.signInWithEmailAndPassword(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenThrow(Exception());
      expect(
        authSource.signIn(email, password),
        throwsA(isA<AuthException>()),
      );
    });
  });

  group('Sign up', () {
    test('with email completes', () async {
      when(
        () => firebaseAuth.createUserWithEmailAndPassword(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer(
        (_) async => mockCredentials,
      );

      expect(authSource.signUp(email, password), completes);
    });
    test('with email throws FirebaseAuthException on firebase exeption', () {
      when(
        () => firebaseAuth.createUserWithEmailAndPassword(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenThrow(FirebaseAuthException(code: 'test-exception'));
      expect(
        authSource.signUp(email, password),
        throwsA(isA<FirebaseAuthException>()),
      );
    });
    test('with email throws AuthExeption on  exeption', () {
      when(
        () => firebaseAuth.createUserWithEmailAndPassword(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenThrow(Exception());
      expect(
        authSource.signUp(email, password),
        throwsA(isA<AuthException>()),
      );
    });
  });

  group('Sign in with google', () {
    test('completes', () async {
      when(mockGoogleSignIn.signIn).thenAnswer((_) async => mockGoogleUser);
      when(() => mockGoogleUser.authentication)
          .thenAnswer((_) async => mockGoogleSignInAuthentication);
      when(() => mockGoogleSignInAuthentication.accessToken)
          .thenReturn('access-token');
      when(() => mockGoogleSignInAuthentication.idToken).thenReturn('id-token');
      when(() => firebaseAuth.signInWithCredential(any()))
          .thenAnswer((_) async => mockCredentials);
      when(() => mockCredentials.user).thenReturn(mockUser);

      expect(authSource.signInWithGoogle(), completes);
    });

    test('returns auth exception when cancelled', () {
      // Arrange
      const MockGoogleSignInAccount? mockGoogleUserNull =
          null; // Simulating null when sign-in is cancelled.
      when(mockGoogleSignIn.signIn).thenAnswer((_) async => mockGoogleUserNull);

      expect(authSource.signInWithGoogle(), throwsA(isA<AuthException>()));
    });

    test('returns firebase exception when firebase exception thrown', () {
      // Arrange
      when(mockGoogleSignIn.signIn).thenAnswer((_) async => mockGoogleUser);
      when(() => mockGoogleUser.authentication)
          .thenAnswer((_) async => mockGoogleSignInAuthentication);
      when(() => mockGoogleSignInAuthentication.accessToken)
          .thenReturn('access-token');
      when(() => mockGoogleSignInAuthentication.idToken).thenReturn('id-token');
      when(() => firebaseAuth.signInWithCredential(any()))
          .thenThrow(FirebaseAuthException(code: 'test-exception'));

      expect(
          authSource.signInWithGoogle(), throwsA(isA<FirebaseAuthException>()));
    });

    test('returns auth exception when  exception thrown', () {
      // Arrange
      when(mockGoogleSignIn.signIn).thenAnswer((_) async => mockGoogleUser);
      when(() => mockGoogleUser.authentication)
          .thenAnswer((_) async => mockGoogleSignInAuthentication);
      when(() => mockGoogleSignInAuthentication.accessToken)
          .thenReturn('access-token');
      when(() => mockGoogleSignInAuthentication.idToken).thenReturn('id-token');
      when(() => firebaseAuth.signInWithCredential(any()))
          .thenThrow(Exception('oops'));

      expect(authSource.signInWithGoogle(), throwsA(isA<AuthException>()));
    });
  });

  group('sign out', () {
    test('completes', () async {
      // when(() => authClient.signOut()).thenAnswer((_) async => authResponse);
      when(() => firebaseAuth.signOut()).thenAnswer((_) async => null);
      expect(authSource.signOut(), completes);
    });
    test('throws FirebaseAuthException when Firebase Exeption is thrown', () {
      when(() => firebaseAuth.signOut())
          .thenThrow(FirebaseAuthException(code: 'oops'));
      expect(authSource.signOut(), throwsA(isA<FirebaseAuthException>()));
    });
    test('throws AuthException', () {
      when(() => firebaseAuth.signOut()).thenThrow(Exception('oops'));
      expect(authSource.signOut(), throwsA(isA<AuthException>()));
    });
  });

  group('Watch Auth State', () {
    test('returns authenticated when session is not null', () async {
      when(() => firebaseAuth.authStateChanges()).thenAnswer(
        (_) => Stream.value(
          mockUser,
        ),
      );

      expect(
        authSource.watchAuthState(),
        emitsInOrder(<AuthenticationState>[
          AuthenticationState.authenticated,
        ]),
      );
    });
    test('returns unauthenticated when session is null', () async {
      when(() => firebaseAuth.authStateChanges()).thenAnswer(
        (_) => Stream.value(
          null,
        ),
      );

      expect(
        authSource.watchAuthState(),
        emitsInOrder(<AuthenticationState>[
          AuthenticationState.unauthenticated,
        ]),
      );
    });

    test('returns unknown when error occurs', () async {
      when(() => firebaseAuth.authStateChanges()).thenAnswer(
        (_) => Stream.error(Exception('oops')),
      );
      expect(
        authSource.watchAuthState(),
        emitsInOrder(<AuthenticationState>[
          AuthenticationState.unknown,
        ]),
      );
    });
  });
}
