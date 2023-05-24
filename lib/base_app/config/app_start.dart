import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_starter/base_app/core/abstractions/build_config.dart';
import 'package:flutter_starter/base_app/core/abstractions/feature_resolver.dart';
import 'package:flutter_starter/base_app/core/abstractions/injection_module.dart';
import 'package:flutter_starter/base_app/core/abstractions/router_module.dart';
import 'package:flutter_starter/base_app/resolver/app_resolver.dart';
import 'package:flutter_starter/my_app.dart';
import 'package:go_router/go_router.dart';

import 'app_injection_component.dart';
import 'app_set_up.dart';
import 'constant.dart';

// import 'package:auto_orientation/auto_orientation.dart';

abstract class AppStart {
  final BuildConfig buildConfig;

  final resolvers = <FeatureResolver>[
    BaseAppResolver(),
  ];

  final routerModule = <RouterModule>[];

  final injectionModule = <InjectionModule>[];
  AppStart(this.buildConfig);
  GoRouter generateRoute(List<RouterModule> routerModule) {
    // itereate all router modueles and create go router object
    List<RouteBase> routeBase = [];
    for (var element in routerModule) {
      element.getRoutes().forEach((route) {
        routeBase.add(route);
      });
    }
    var routes = GoRouter(
        // debugLogDiagnostics: true,
        initialLocation: '/',
        navigatorKey: navigatorKey,
        routes: routeBase);
    return routes;
  }

  Future initModules() async {
    for (final resolver in resolvers) {
      if (resolver.routerModule != null) {
        routerModule.add(resolver.routerModule!);
      }
      if (resolver.injectionModule != null) {
        injectionModule.add(resolver.injectionModule!);
      }
    }

    final injector = await AppInjectionComponent.instance.registerModules(
      modules: injectionModule,
    );

    await AppSetUp().initStorage(injector.get());
  }

  Future<void> startApp() async {
    await runZonedGuarded<Future<void>>(() async {
      await AppSetUp().init();
      await initModules();
      runApp(
        Phoenix(
          child: MyApp(
            buildConfig: buildConfig,
            routes: generateRoute(routerModule),
          ),
        ),
      );
    }, (onError, stackTrace) {
      log(onError.toString(), stackTrace: stackTrace);
    });
  }
}
