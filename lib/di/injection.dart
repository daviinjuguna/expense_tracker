// coverage:ignore-file

import 'package:expense_tracker/di/injection.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.instance;

@InjectableInit()

///initializing service locator for the app
Future<void> configureInjection({String? environment}) async =>
    getIt.init(environment: environment);
