import 'package:get/get_utils/get_utils.dart';

import '../../../modules/Auth/services/dataset/AuthData.dart';
import '../../../models/ApiResponse.dart';
import 'GlobalAuthService.dart';

class MockGlobalAuthService implements GlobalAuthService {
  /// Start the server request
  @override
  void init() => null;

  /// Stop the server request
  @override
  void close() => null;

  @override
  Future<ApiResponse> getUser() async {
    await Future.delayed(2.seconds);
    return AuthData.getUserSuccess;
  }

  @override
  Future<ApiResponse> logout() async {
    return await 2.delay(() => AuthData.logoutSuccess);
  }
}
