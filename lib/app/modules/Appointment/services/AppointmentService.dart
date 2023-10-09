import '../../../models/ApiResponse.dart';
import 'package:get/get.dart';

import 'ApiAppointmentService.dart';
import 'MockAppointmentService.dart';

abstract class AppointmentService {
  /// Configure if Mock is enabled or not @accepts[true|false]
  static const MOCK_ENABLED = false;

  /// Create and get the instance of [AppointmentService]
  static AppointmentService get instance {
    if (!Get.isRegistered<AppointmentService>())
      Get.lazyPut<AppointmentService>(() =>
          MOCK_ENABLED ? MockAppointmentService() : ApiAppointmentService());
    return Get.find<AppointmentService>();
  }

  /// Start the server request
  void init();

  /// Stop the server request
  void close();

  /// Index
  Future<ApiResponse> index({DateTime? date, required doctorId});

  /// Show
  Future<ApiResponse> show({required int id});

  /// Create
  Future<ApiResponse> create({required Map<String, dynamic> body});

  /// Store
  Future<ApiResponse> store({required Map<String, dynamic> body});

  /// Edit
  Future<ApiResponse> edit(
      {required Map<String, dynamic> body, required int id});

  /// Update
  Future<ApiResponse> patch(
      {required Map<String, dynamic> body, required int id});

  /// Delete
  Future<ApiResponse> delete({required int id});
}
