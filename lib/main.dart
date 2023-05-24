import 'package:flutter_starter/base_app/config/app_start.dart';

import 'env.dart';

void main() {
  InitializeApp().startApp();
}

class InitializeApp extends AppStart {
  InitializeApp() : super(Env.getConfig);
}
