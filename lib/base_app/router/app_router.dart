import 'package:flutter_starter/base_app/core/abstractions/router_module.dart';
import 'package:flutter_starter/base_app/view/splash_screen.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static const String indexSplash = '/';
  static const String onboardingPage = '/onboardingPage';
  static const String supportPage = '/supportPage';
  static const String aboutPage = '/aboutPage';
}

class BaseAppRouteModule implements RouterModule {
  @override
  List<GoRoute> getRoutes() {
    return [
      GoRoute(
        path: AppRoutes.indexSplash,
        name: AppRoutes.indexSplash,
        builder: (context, state) => const SplashScreen(),
      ),
    ];
  }
}
