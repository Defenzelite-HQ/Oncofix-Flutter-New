import 'package:get/get.dart';

import '../../../models/ApiResponse.dart';
import 'AppSettingService.dart';
import 'MockSettingService.dart';

abstract class SettingService {
  /// Configure if Mock is enabled or not @accepts[true|false]
  static const MOCK_ENABLED = false;

  /// Create and get the instance of [SettingService]
  static SettingService get instance {
    if (!Get.isRegistered<SettingService>())
      Get.lazyPut<SettingService>(
          () => MOCK_ENABLED ? MockSettingService() : AppSettingService());
    return Get.find<SettingService>();
  }

  /// Start the server request
  void init();

  /// Stop the server request
  void close();

  /// Do Something
  Future<ApiResponse> doSomething();

  /// [State and City]
  Future<ApiResponse> getState();

  Future<ApiResponse> getCity({required stateID});

  ///  [Account Service]
  Future<ApiResponse> updateAccount({required Map<String, dynamic> body});

  /// [Address Service]
  Future<ApiResponse> createAddress({required Map<String, dynamic> body});

  Future<ApiResponse> deleteAddress({required int id});

  Future<ApiResponse> updateAddress(
      {required Map<String, dynamic> body, required int id});

  Future<ApiResponse> getAddressList();

  /// [Change Password]
  Future<ApiResponse> changePassword({required Map<String, dynamic> body});

  /// [Subscription Plan]
  Future<ApiResponse> getPlans();

  Future<ApiResponse> checkout({required int id});
}
