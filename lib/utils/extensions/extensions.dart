import 'package:expense_tracker/l10n/l10n.dart';
import 'package:flutter/material.dart';

extension ShowSnackBar on BuildContext {
  void hideSnackBar() {
    ScaffoldMessenger.of(this).hideCurrentSnackBar();
  }

  void loadingSnackbar([Key key = const Key('loading_snackbar')]) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(this).colorScheme.primaryContainer,
          key: key,
          content: Row(
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(
                  Theme.of(this).colorScheme.onPrimaryContainer,
                ),
              ),
              const Spacer(),
              Text(
                AppLocalizations.of(this).loading,
                style: TextStyle(
                  color: Theme.of(this).colorScheme.onPrimaryContainer,
                ),
              ),
            ],
          ),
          duration: const Duration(seconds: 60),
          behavior: SnackBarBehavior.fixed,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
            ),
          ),
        ),
      );
  }

  String _messageFromLocale(String message) {
    switch (message) {
      case 'invalidEmail':
        return l10n.invalidEmail;
      case 'userDisabled':
        return l10n.userDisabled;
      case 'emailAlreadyInUse':
        return l10n.emailAlreadyInUse;
      case 'invalidCredentials':
        return l10n.invalidCredentials;
      case 'signInError':
        return l10n.signInError;
      case 'weakPassword':
        return l10n.weakPassword;
      case 'signUpError':
        return l10n.signUpError;
      case 'googleSignInCancelled':
        return l10n.googleSignInCancelled;
      case 'accountExistsWithDifferentCredential':
        return l10n.accountExistsWithDifferentCredential;
      case 'signOutError':
        return l10n.signOutError;
      default:
        return l10n.unknownError;
    }
  }

  void errorSnackbar(String message, [Key key = const Key('error_snackbar')]) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          key: key,
          content: Text(
            _messageFromLocale(message),
            style: TextStyle(color: Theme.of(this).colorScheme.onError),
          ),
          backgroundColor: Theme.of(this).colorScheme.error,
          behavior: SnackBarBehavior.fixed,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
            ),
          ),
        ),
      );
  }
}
