// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i4;
import 'package:expense_tracker/auth/auth.dart' as _i10;
import 'package:expense_tracker/auth/bloc/auth/auth_cubit.dart' as _i11;
import 'package:expense_tracker/auth/bloc/splash/splash_bloc.dart' as _i9;
import 'package:expense_tracker/auth/data/auth_source.dart' as _i7;
import 'package:expense_tracker/auth/repo/auth_repo.dart' as _i8;
import 'package:expense_tracker/di/modules.dart' as _i12;
import 'package:expense_tracker/theme_selector/bloc/theme_mode_bloc.dart'
    as _i6;
import 'package:firebase_auth/firebase_auth.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i5;
import 'package:injectable/injectable.dart' as _i2;

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final modules = _$Modules();
    gh.lazySingleton<_i3.FirebaseAuth>(() => modules.firebaseAuth);
    gh.lazySingleton<_i4.FirebaseFirestore>(() => modules.firebaseFirestore);
    gh.lazySingleton<_i5.GoogleSignIn>(() => modules.googleSignIn);
    gh.factory<_i6.ThemeModeBloc>(() => _i6.ThemeModeBloc());
    gh.lazySingleton<_i7.AuthSource>(() => _i7.AuthSourceImpl(
          gh<_i3.FirebaseAuth>(),
          gh<_i5.GoogleSignIn>(),
        ));
    gh.lazySingleton<_i8.AuthRepo>(
        () => _i8.AuthRepoImpl(gh<_i7.AuthSource>()));
    gh.factory<_i9.SplashBloc>(() => _i9.SplashBloc(gh<_i10.AuthRepo>()));
    gh.factory<_i11.AuthCubit>(() => _i11.AuthCubit(gh<_i10.AuthRepo>()));
    return this;
  }
}

class _$Modules extends _i12.Modules {}
