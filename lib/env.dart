import 'package:flutter/foundation.dart';

import 'base_app/core/abstractions/build_config.dart';

class Env {
  static final BuildConfig _dev = BuildConfig(
    baseUrl: 'https://www.google.com/',
    appName: "Staging",
  );
  static final BuildConfig _prod = BuildConfig(
    baseUrl: 'https://v2-api.nguvuhealth.com/',
    // baseUrl: 'http://35.221.45.86/',
    appName: "Nguvu Health production",
  );

  static BuildConfig get getConfig => kReleaseMode ? _prod : _dev;
}
