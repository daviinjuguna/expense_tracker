import 'package:expense_tracker/auth/auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepo extends Mock implements AuthRepo {}

void main() {
  late SplashBloc splashBloc;
  late MockAuthRepo authRepo;

  setUp(() {
    authRepo = MockAuthRepo();
    splashBloc = SplashBloc(authRepo);
  });
  group('SplashBloc', () {
    test('initial state is initial', () {
      expect(splashBloc.state, SplashState.initial);
    });

    group('StartSplashEvent', () {
      blocTest<SplashBloc, SplashState>(
        'Calls watchAuthState when called',
        build: () => splashBloc,
        setUp: () {
          when(() => authRepo.watchAuthState()).thenAnswer(
              (_) => Stream.value(AuthenticationState.authenticated));
        },
        act: (bloc) => bloc.add(StartSplashEvent()),
        verify: (bloc) => verify(() => authRepo.watchAuthState()).called(1),
      );

      blocTest<SplashBloc, SplashState>(
        'emits [SplashState.loading, SplashState.authenticated] when StartSplashEvent is added.',
        build: () => splashBloc,
        setUp: () {
          when(() => authRepo.watchAuthState()).thenAnswer(
              (_) => Stream.value(AuthenticationState.authenticated));
        },
        act: (bloc) => bloc.add(StartSplashEvent()),
        expect: () =>
            const <SplashState>[SplashState.loading, SplashState.authenticated],
      );
      blocTest<SplashBloc, SplashState>(
        'emits [SplashState.loading, SplashState.unauthenticated] when StartSplashEvent is added.',
        build: () => splashBloc,
        setUp: () {
          when(() => authRepo.watchAuthState()).thenAnswer(
              (_) => Stream.value(AuthenticationState.unauthenticated));
        },
        act: (bloc) => bloc.add(StartSplashEvent()),
        expect: () => const <SplashState>[
          SplashState.loading,
          SplashState.unauthenticated
        ],
      );
      blocTest<SplashBloc, SplashState>(
        'emits [SplashState.loading, SplashState.unauthenticated] when StartSplashEvent is added, when auth state is unknown',
        build: () => splashBloc,
        setUp: () {
          when(() => authRepo.watchAuthState())
              .thenAnswer((_) => Stream.value(AuthenticationState.unknown));
        },
        act: (bloc) => bloc.add(StartSplashEvent()),
        expect: () => const <SplashState>[
          SplashState.loading,
          SplashState.unauthenticated
        ],
      );
    });

    group('ReceiveSplashEvent', () {
      blocTest<SplashBloc, SplashState>(
        'emits [SplashState.authenticated] when ReceiveSplashEvent is added. with authenticated state',
        build: () => splashBloc,
        act: (bloc) =>
            bloc.add(ReceiveSplashEvent(AuthenticationState.authenticated)),
        expect: () => const <SplashState>[SplashState.authenticated],
      );
      blocTest<SplashBloc, SplashState>(
        'emits [SplashState.unauthenticated] when ReceiveSplashEvent is added. with unauthenticated state',
        build: () => splashBloc,
        act: (bloc) =>
            bloc.add(ReceiveSplashEvent(AuthenticationState.unauthenticated)),
        expect: () => const <SplashState>[SplashState.unauthenticated],
      );
      blocTest<SplashBloc, SplashState>(
        'emits [SplashState.unauthenticated] when ReceiveSplashEvent is added. with unknown state',
        build: () => splashBloc,
        act: (bloc) =>
            bloc.add(ReceiveSplashEvent(AuthenticationState.unknown)),
        expect: () => const <SplashState>[SplashState.unauthenticated],
      );
    });
  });
}
