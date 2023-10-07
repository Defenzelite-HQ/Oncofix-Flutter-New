import '../../../models/ApiResponse.dart';
import 'package:get/get.dart';

import 'ApiAboutService.dart';
import 'MockAboutService.dart';

abstract class AboutService {
  /// Configure if Mock is enabled or not @accepts[true|false]
  static const MOCK_ENABLED = true;

  /// Create and get the instance of [AboutService]
  static AboutService get instance {
    if (!Get.isRegistered<AboutService>()) Get.lazyPut<AboutService>(() => MOCK_ENABLED ? MockAboutService() : ApiAboutService());
    return Get.find<AboutService>();
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

