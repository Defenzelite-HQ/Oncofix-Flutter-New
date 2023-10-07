import '../../../models/ApiResponse.dart';
import 'OnBoardingService.dart';
import 'package:get/get.dart';
import 'dataset/OnBoardingData.dart';

class MockOnBoardingService implements OnBoardingService {
  /// Start the server request
  @override
  void init() => null;

  /// Stop the server request
  @override
  void close() => null;
  
  @override
  Future<ApiResponse> index() async {
    return await 300.milliseconds.delay(() => OnBoardingData.onboarding);
  }

  @override
  Future<ApiResponse> show({required int id}) async {
    return await 300.milliseconds.delay(() => OnBoardingData.onboarding);
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

