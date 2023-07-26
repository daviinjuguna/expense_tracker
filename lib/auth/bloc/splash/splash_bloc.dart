import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import 'package:expense_tracker/auth/auth.dart';

part 'splash_event.dart';
part 'splash_state.dart';

@injectable
class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc(this._repo) : super(SplashState.initial) {
    on<StartSplashEvent>((event, emit) {
      _subscription?.cancel();
      emit(SplashState.loading);
      _subscription = _repo
          .watchAuthState()
          .listen((state) => add(ReceiveSplashEvent(state)));
    });
    on<ReceiveSplashEvent>((event, emit) {
      if (event.state == AuthenticationState.authenticated) {
        emit(SplashState.authenticated);
      } else {
        emit(SplashState.unauthenticated);
      }
    });
  }

  final AuthRepo _repo;

  StreamSubscription<AuthenticationState>? _subscription;

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
