import 'package:get/get.dart';

import '../../../helpers/Request.dart';
import '../../../models/ApiResponse.dart';
import 'AppGlobalAuthService.dart';
import 'MockGlobalAuthService.dart';

abstract class GlobalAuthService {
  /// Configure if Mock is enabled or not
  static const MOCK_ENABLED = false;

  /// Create and get the instance of [GlobalAuthService]
  static GlobalAuthService get instance {
    if (!Get.isRegistered<GlobalAuthService>())
      Get.lazyPut<GlobalAuthService>(
        () => MOCK_ENABLED ? MockGlobalAuthService() : AppGlobalAuthService(),
      );
    return Get.find<GlobalAuthService>();
  }

  /// Start the server request
  @override
  void init() => Request.start();

  /// Stop the server request
  @override
  void close() => Request.close();

  /// Get and refresh user data
  Future<ApiResponse> getUser();

  /// Logout the user from system
  Future<ApiResponse> logout();
}
