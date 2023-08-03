// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i4;
import 'package:expense_tracker/auth/auth.dart' as _i11;
import 'package:expense_tracker/auth/bloc/auth/auth_cubit.dart' as _i12;
import 'package:expense_tracker/auth/bloc/splash/splash_bloc.dart' as _i10;
import 'package:expense_tracker/auth/data/auth_source.dart' as _i8;
import 'package:expense_tracker/auth/repo/auth_repo.dart' as _i9;
import 'package:expense_tracker/di/modules.dart' as _i13;
import 'package:expense_tracker/home/data/home_data_source.dart' as _i6;
import 'package:expense_tracker/theme_selector/bloc/theme_mode_bloc.dart'
    as _i7;
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
    gh.lazySingleton<_i6.HomeDataSource>(
        () => _i6.HomeDataSourceImpl(gh<_i4.FirebaseFirestore>()));
    gh.factory<_i7.ThemeModeBloc>(() => _i7.ThemeModeBloc());
    gh.lazySingleton<_i8.AuthSource>(() => _i8.AuthSourceImpl(
          gh<_i3.FirebaseAuth>(),
          gh<_i5.GoogleSignIn>(),
        ));
    gh.lazySingleton<_i9.AuthRepo>(
        () => _i9.AuthRepoImpl(gh<_i8.AuthSource>()));
    gh.factory<_i10.SplashBloc>(() => _i10.SplashBloc(gh<_i11.AuthRepo>()));
    gh.factory<_i12.AuthCubit>(() => _i12.AuthCubit(gh<_i11.AuthRepo>()));
    return this;
  }
}

class _$Modules extends _i13.Modules {}
