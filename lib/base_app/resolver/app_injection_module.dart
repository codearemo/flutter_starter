import 'dart:async';

import 'package:flutter_starter/base_app/core/api.dart';
import 'package:flutter_starter/base_app/core/storage.dart';
import 'package:get_it/get_it.dart';

import '../core/abstractions/injection_module.dart';

class BaseAppInjectionModule implements InjectionModule {
  @override
  FutureOr<void> registerDepenencies({
    required GetIt injector,
  }) {
    injector.registerLazySingleton<Storage>(() => StorageImpl());

    injector.registerLazySingleton(() => Api());
  }
}
