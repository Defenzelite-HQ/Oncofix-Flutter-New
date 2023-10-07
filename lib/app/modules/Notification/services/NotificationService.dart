import '../../../models/ApiResponse.dart';
import 'package:get/get.dart';

import 'ApiNotificationService.dart';
import 'MockNotificationService.dart';

abstract class NotificationService {
  /// Configure if Mock is enabled or not @accepts[true|false]
  static const MOCK_ENABLED = false;

  /// Create and get the instance of [NotificationService]
  static NotificationService get instance {
    if (!Get.isRegistered<NotificationService>()) Get.lazyPut<NotificationService>(() => MOCK_ENABLED ? MockNotificationService() : ApiNotificationService());
    return Get.find<NotificationService>();
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

