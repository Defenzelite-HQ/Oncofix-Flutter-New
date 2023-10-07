import 'package:get/get.dart';

import '../../../models/ApiResponse.dart';
import 'DoctorService.dart';
import 'dataset/DoctorData.dart';

class MockDoctorService implements DoctorService {
  /// Start the server request
  @override
  void init() => null;

  /// Stop the server request
  @override
  void close() => null;

  @override
  Future<ApiResponse> index({String? params}) async {
    return await 300.milliseconds.delay(() => DoctorData.doctor);
  }

  @override
  Future<ApiResponse> show({required int id}) async {
    return await 300.milliseconds.delay(() => DoctorData.doctor);
  }

  @override
  Future<ApiResponse> getMeetings({required int id}) async {
    return await 300.milliseconds.delay(() => DoctorData.doctor);
  }

  @override
  Future<ApiResponse> getFeedbacks({required int id}) async {
    return await 300.milliseconds.delay(() => DoctorData.doctor);
  }

  @override
  Future<ApiResponse> create({required Map<String, dynamic> body}) async {
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse> store({required Map<String, dynamic> body}) async {
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse> edit(
      {required Map<String, dynamic> body, required int id}) async {
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse> patch(
      {required Map<String, dynamic> body, required int id}) async {
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse> delete({required int id}) async {
    throw UnimplementedError();
  }
}
