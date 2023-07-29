import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:expense_tracker/auth/data/auth_source.dart';
import 'package:expense_tracker/auth/models/authentication_state.dart';
import 'package:expense_tracker/exceptions/exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

abstract class AuthRepo {
  Future<Either<String, Unit>> signIn(
    String email,
    String password,
  );
  Future<Either<String, Unit>> signUp(
    String email,
    String password,
  );

  Future<Either<String, Unit>> signInWithGoogle();
  Future<Either<String, Unit>> signOut();
  Stream<AuthenticationState> watchAuthState();
}

@LazySingleton(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AuthSource _source;

  AuthRepoImpl(this._source);

  @override
  Future<Either<String, Unit>> signIn(String email, String password) async {
    try {
      await _source.signIn(email, password);
      return right(unit);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        return left('invalidCredentials');
      }
      if (e.code == 'invalid-email') {
        return left('invalidEmail');
      }
      if (e.code == 'user-disabled') {
        return left('userDisabled');
      }
      return left('signInError');
    } catch (e) {
      return left('signInError');
    }
  }

  @override
  Future<Either<String, Unit>> signUp(String email, String password) async {
    try {
      await _source.signUp(email, password);
      return right(unit);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return left('emailAlreadyInUse');
      }
      if (e.code == 'weak-password') {
        return left('weakPassword');
      }
      if (e.code == 'invalid-email') {
        return left('invalidEmail');
      }
      return left('signUpError');
    } catch (e) {
      return left('signUpError');
    }
  }

  @override
  Future<Either<String, Unit>> signInWithGoogle() async {
    try {
      await _source.signInWithGoogle();
      return right(unit);
    } on GoogleSignInCancelledException catch (e) {
      log(e.toString());
      return left('googleSignInCancelled');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        //in camelCase
        return left('accountExistsWithDifferentCredential');
      }
      if (e.code == 'user-disabled') {
        return left('userDisabled');
      }
      return left('signInError');
    } catch (e) {
      return left('signInError');
    }
  }

  @override
  Future<Either<String, Unit>> signOut() async {
    try {
      await _source.signOut();
      return right(unit);
    } catch (e) {
      return left('signOutError');
    }
  }

  @override
  Stream<AuthenticationState> watchAuthState() => _source.watchAuthState();
}
