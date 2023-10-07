import '../../../models/ApiResponse.dart';
import 'package:get/get.dart';

import 'AppSplashService.dart';
import 'MockSplashService.dart';

abstract class SplashService {
  /// Configure if Mock is enabled or not @accepts[true|false]
  static const MOCK_ENABLED = true;

  /// Create and get the instance of [SplashService]
  static SplashService get instance {
    if (!Get.isRegistered<SplashService>()) Get.lazyPut<SplashService>(() => MOCK_ENABLED ? MockSplashService() : AppSplashService());
    return Get.find<SplashService>();
  }
  
  /// Start the server request
  void init();

  /// Stop the server request
  void close();

  /// Do Something
  Future<ApiResponse> doSomething();
}

