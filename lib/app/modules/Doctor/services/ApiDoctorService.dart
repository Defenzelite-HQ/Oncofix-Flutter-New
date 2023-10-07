import 'package:ui_x/helpers/Helpers.dart';

import '../../../helpers/Request.dart';
import '../../../models/ApiResponse.dart';
import 'DoctorService.dart';

class ApiDoctorService implements DoctorService {
  /// Start the server request
  @override
  void init() => Request.start();

  /// Stop the server request
  @override
  void close() => Request.close();

  @override
  Future<ApiResponse> index({String? params}) async {
    return await Request.get('/doctors?$params', authenticate: true);
  }

  @override
  Future<ApiResponse> show({required int id}) async {
    return await Request.get('/doctors/$id', authenticate: true);
  }
  @override
  Future<ApiResponse> getMeetings({required int id}) async {
    return await Request.get('/doctors/$id/meetings', authenticate: true);
  }

 @override
  Future<ApiResponse> getFeedbacks({required int id}) async {
    return await Request.get('/doctors/$id/feedbacks', authenticate: true);
  }

  @override
  Future<ApiResponse> create({required Map<String, dynamic> body}) async {
    return await Request.post('/url', body: body, authenticate: true);
  }

  @override
  Future<ApiResponse> store({required Map<String, dynamic> body}) async {
    return await Request.post('/url', body: body, authenticate: true);
  }

  @override
  Future<ApiResponse> edit(
      {required Map<String, dynamic> body, required int id}) async {
    return await Request.post('/url', body: body, authenticate: true);
  }

  @override
  Future<ApiResponse> patch(
      {required Map<String, dynamic> body, required int id}) async {
    return await Request.post('/url', body: body, authenticate: true);
  }

  @override
  Future<ApiResponse> delete({required int id}) async {
    return await Request.get('/url', authenticate: true);
  }

}
