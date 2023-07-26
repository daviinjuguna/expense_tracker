part of 'splash_bloc.dart';

@immutable
abstract class SplashEvent {}

class StartSplashEvent extends SplashEvent {}

class ReceiveSplashEvent extends SplashEvent {
  final AuthenticationState state;

  ReceiveSplashEvent(this.state);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ReceiveSplashEvent && other.state == state;
  }

  @override
  int get hashCode => state.hashCode;
}
