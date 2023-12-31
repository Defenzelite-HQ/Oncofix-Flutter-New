import '../../../models/ApiResponse.dart';
import 'package:get/get.dart';

import 'ApiDashboardService.dart';
import 'MockDashboardService.dart';

abstract class DashboardService {
  /// Configure if Mock is enabled or not @accepts[true|false]
  static const MOCK_ENABLED = false;

  /// Create and get the instance of [DashboardService]
  static DashboardService get instance {
    if (!Get.isRegistered<DashboardService>()) Get.lazyPut<DashboardService>(() => MOCK_ENABLED ? MockDashboardService() : ApiDashboardService());
    return Get.find<DashboardService>();
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
  Future<ApiResponse> storePatientAttendance({required Map<String, dynamic> body});
 
  /// Edit
  Future<ApiResponse> edit({required Map<String, dynamic> body, required int id});

 /// Update
  Future<ApiResponse> patch({required Map<String, dynamic> body, required int id});
 
  /// Delete
  Future<ApiResponse> delete({required int id});
}

