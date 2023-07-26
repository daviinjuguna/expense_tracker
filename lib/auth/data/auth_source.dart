import 'dart:developer';

import 'package:expense_tracker/auth/auth.dart';
import 'package:expense_tracker/exceptions/exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

abstract class AuthSource {
  Future<void> signIn(String email, String password);
  Future<void> signUp(String email, String password);
  Future<void> signInWithGoogle();
  Future<void> signOut();
  Stream<AuthenticationState> watchAuthState();
}

@LazySingleton(as: AuthSource)
class AuthSourceImpl implements AuthSource {
  final FirebaseAuth authClient;
  final GoogleSignIn googleSignIn;

  AuthSourceImpl(this.authClient, this.googleSignIn);

  @override
  Future<void> signIn(String email, String password) async {
    try {
      await authClient.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e, s) {
      log("signIn", error: e, stackTrace: s);
      rethrow;
    } catch (e, s) {
      log("signIn", error: e, stackTrace: s);
      Error.throwWithStackTrace(AuthException(e), s);
    }
  }

  @override
  Future<void> signUp(String email, String password) async {
    try {
      await authClient.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e, s) {
      log("signUp", error: e, stackTrace: s);
      rethrow;
    } catch (e, s) {
      log("signUp", error: e, stackTrace: s);
      Error.throwWithStackTrace(AuthException(e), s);
    }
  }

  @override
  Future<void> signInWithGoogle() async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        Error.throwWithStackTrace(
          AuthException("google-sign-in-cancelled"),
          StackTrace.current,
        );
      }
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await authClient.signInWithCredential(credential);
    } on FirebaseAuthException catch (e, s) {
      log("signOut", error: e, stackTrace: s);
      rethrow;
    } catch (e, s) {
      log("signOut", error: e, stackTrace: s);
      Error.throwWithStackTrace(AuthException(e), s);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await authClient.signOut();
    } on FirebaseAuthException catch (e, s) {
      log("signOut", error: e, stackTrace: s);
      rethrow;
    } catch (e, s) {
      log("signOut", error: e, stackTrace: s);
      Error.throwWithStackTrace(AuthException(e), s);
    }
  }

  @override
  Stream<AuthenticationState> watchAuthState() async* {
    yield* authClient.authStateChanges().map((user) {
      if (user == null) {
        return AuthenticationState.unauthenticated;
      } else {
        return AuthenticationState.authenticated;
      }
    }).onErrorReturnWith((error, stackTrace) {
      log("watchAuthState", error: error, stackTrace: stackTrace);
      return AuthenticationState.unknown;
    });
  }
}
