import 'package:flutter_starter/base_app/core/abstractions/feature_resolver.dart';
import 'package:flutter_starter/base_app/core/abstractions/router_module.dart';

import '../core/abstractions/injection_module.dart';
import '../router/app_router.dart';
import 'app_injection_module.dart';

class BaseAppResolver implements FeatureResolver {
  @override
  InjectionModule? get injectionModule => BaseAppInjectionModule();

  @override
  RouterModule? get routerModule => BaseAppRouteModule();
}
