import '../../../models/ApiResponse.dart';
import 'package:get/get.dart';

import 'ApiOnBoardingService.dart';
import 'MockOnBoardingService.dart';

abstract class OnBoardingService {
  /// Configure if Mock is enabled or not @accepts[true|false]
  static const MOCK_ENABLED = true;

  /// Create and get the instance of [OnBoardingService]
  static OnBoardingService get instance {
    if (!Get.isRegistered<OnBoardingService>()) Get.lazyPut<OnBoardingService>(() => MOCK_ENABLED ? MockOnBoardingService() : ApiOnBoardingService());
    return Get.find<OnBoardingService>();
  }
  
  /// Start the server request
  void init();

  /// Stop the server request
  void close();

 /// Index
 Future<ApiResponse> index();

  /// Show
  Future<ApiResponse> show({required int id});
  
  /// Create
  Future<ApiResponse> create({required Map<String, dynamic> body});
  
  /// Store
  Future<ApiResponse> store({required Map<String, dynamic> body});
 
  /// Edit
  Future<ApiResponse> edit({required Map<String, dynamic> body, required int id});

 /// Update
  Future<ApiResponse> patch({required Map<String, dynamic> body, required int id});
 
  /// Delete
  Future<ApiResponse> delete({required int id});
}

