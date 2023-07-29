import 'package:auto_route/auto_route.dart';
import 'package:expense_tracker/auth/auth.dart';
import 'package:expense_tracker/di/di.dart';
import 'package:expense_tracker/gen/gen.dart';
import 'package:expense_tracker/l10n/l10n.dart';
import 'package:expense_tracker/router/router.dart';
import 'package:expense_tracker/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';

@RoutePage()
class LoginPage extends StatelessWidget {
  const LoginPage({super.key, this.authCubit});

  @visibleForTesting
  final AuthCubit? authCubit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => authCubit ?? getIt<AuthCubit>(),
      child: LoginView(
        authCubitTest: authCubit,
      ),
    );
  }
}

class LoginView extends StatefulWidget {
  const LoginView({super.key, this.authCubitTest, this.onListenerCalled});
  @visibleForTesting
  final AuthCubit? authCubitTest;
  @visibleForTesting
  final BlocWidgetListener<AuthState>? onListenerCalled;

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  AppLocalizations get l10n => AppLocalizations.of(context);
  TextTheme get textTheme => Theme.of(context).textTheme;
  // AuthCubit get authCubit => ;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AuthCubit>().state;

    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        widget.onListenerCalled?.call(context, state);
        switch (state.status) {
          case FormzSubmissionStatus.inProgress:
            context.loadingSnackbar();
            break;
          case FormzSubmissionStatus.success:
            context.hideSnackBar();
            break;
          case FormzSubmissionStatus.failure:
            context.errorSnackbar(state.errorCode);
            break;
          default:
        }
      },
      child: Scaffold(
        body: Center(
          child: ListView(
            padding: EdgeInsets.all(10),
            shrinkWrap: true,
            children: [
              //header
              Hero(
                tag: 'logo',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(Assets.saco),
                    Text(
                      l10n.appTitle,
                      textAlign: TextAlign.center,
                      style: textTheme.displayMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              //form field
              TextFormField(
                key: const Key('loginForm_emailInput_textField'),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) =>
                    state.email.isNotValid ? l10n.invalidEmail : null,
                readOnly: state.status.isInProgress,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: l10n.email,
                  hintText: l10n.emailHint,
                ),
                onChanged: context.read<AuthCubit>().emailChanged,
              ),
              SizedBox(height: 10),
              TextFormField(
                key: const Key('loginForm_passwordInput_textField'),
                obscureText: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) =>
                    state.password.isNotValid ? l10n.weakPassword : null,
                readOnly: state.status.isInProgress,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  labelText: l10n.password,
                  hintText: l10n.passwordHint,
                ),
                onChanged: context.read<AuthCubit>().passwordChanged,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                key: const Key('sign_in_btn'),
                onPressed: state.status.isInProgress || !state.loginValid
                    ? null
                    : context.read<AuthCubit>().signIn,
                child: Text(l10n.signIn),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              //already did this
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(l10n.dontHaveAccount),
                  TextButton(
                    key: const Key('sign_up_btn'),
                    onPressed: state.status.isInProgress
                        ? null
                        : () {
                            context.navigateTo(
                              RegisterRoute(authCubit: widget.authCubitTest),
                            );
                          },
                    child: Text(l10n.signUp),
                    style: TextButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.background,
                      foregroundColor: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
              //google sign in
              ElevatedButton.icon(
                key: const Key('google_btn'),
                onPressed: state.status.isInProgress
                    ? null
                    : context.read<AuthCubit>().signInWithGoogle,
                icon: SvgPicture.asset(
                  Assets.google,
                  height: 24,
                ),
                label: Text(l10n.signInWith('Google')),
                style: FilledButton.styleFrom(
                  backgroundColor: Color(0xff0057e7),
                  foregroundColor: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
