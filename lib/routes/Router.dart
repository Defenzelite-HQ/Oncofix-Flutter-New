import 'package:get/get_navigation/src/routes/get_route.dart';

import '../app/modules/Modules.dart';

List<GetPage> routes = [
  /// Basic Routes
  ...splashRoutes,

  /// Auth Routes
  ...authRoutes,

  /// WebView Routes
  ...webviewRoutes,

  /// OnBoarding Routes
  ...onboardingRoutes,

  /// Setting Routes
  ...settingRoutes,

  /// Dashboard Routes
  ...dashboardRoutes,

  /// Doctor Routes
  ...doctorRoutes,

  /// Cases Routes
  ...casesRoutes,

  /// About Routes
  ...aboutRoutes,
];
