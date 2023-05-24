import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_starter/base_app/core/abstractions/build_config.dart';
import 'package:flutter_starter/base_app/utils/app_theme.dart';
import 'package:go_router/go_router.dart';

class MyApp extends StatelessWidget {
  final BuildConfig buildConfig;
  final GoRouter routes;

  const MyApp({
    Key? key,
    required this.buildConfig,
    required this.routes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: ScreenUtilInit(
        designSize: const Size(428, 926),
        builder: (context, child) => child!,
        minTextAdapt: true,
        splitScreenMode: true,
        child: MaterialApp.router(
          routerDelegate: routes.routerDelegate,
          routeInformationParser: routes.routeInformationParser,
          routeInformationProvider: routes.routeInformationProvider,
          title: buildConfig.appName,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.theme(context),
          themeMode: ThemeMode.light,
        ),
      ),
    );
  }
}
