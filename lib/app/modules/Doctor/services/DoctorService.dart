import 'package:get/get.dart';

import '../../../models/ApiResponse.dart';
import 'ApiDoctorService.dart';
import 'MockDoctorService.dart';

abstract class DoctorService {
  /// Configure if Mock is enabled or not @accepts[true|false]
  static const MOCK_ENABLED = false;

  /// Create and get the instance of [DoctorService]
  static DoctorService get instance {
    if (!Get.isRegistered<DoctorService>())
      Get.lazyPut<DoctorService>(
          () => MOCK_ENABLED ? MockDoctorService() : ApiDoctorService());
    return Get.find<DoctorService>();
  }

  /// Start the server request
  void init();

  /// Stop the server request
  void close();

  /// Index
  Future<ApiResponse> index({String? params});

  /// Show
  Future<ApiResponse> show({required int id});

  /// getMeeting
  Future<ApiResponse> getMeetings({required int id});

  /// getFeedback
  Future<ApiResponse> getFeedbacks({required int id});

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
