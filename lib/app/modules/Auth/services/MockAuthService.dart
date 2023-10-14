import 'package:get/get.dart';

import '../../../../config/Config.dart';
import 'dataset/AuthData.dart';
import '../../../models/ApiResponse.dart';
import 'AuthService.dart';

class MockAuthService implements AuthService {
  /// Create the server request
  @override
  void init() => null;

  /// Close the server request
  @override
  void close() => null;

  @override
  Future<ApiResponse> login({required Map<String, dynamic> body}) async {
    String _identifier = Config.hasEmail
        ? "admin@test.com"
        : Config.hasPhone
            ? "8305546538"
            : 'admin';

    return await 300.milliseconds.delay(() {
      if (body['identifier'] != _identifier && body['password'] != 'secret') {
        return AuthData.loginError;
      }

      return Config.needsOtpVerification
          ? AuthData.loginSuccessOtp
          : AuthData.loginSuccess;
    });
  }

  @override
  Future<ApiResponse> google() {
    // TODO: implement googleLogin
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse> facebook() {
    // TODO: implement facebook
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse> github() {
    // TODO: implement github
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse> register({required Map<String, dynamic> body}) async {
    return await 300.milliseconds.delay(() => AuthData.registerSuccess);
  }

  @override
  Future<ApiResponse> verifyOtp({required Map<String, dynamic> body}) async {
    return await 300.milliseconds.delay(() => AuthData.loginSuccess);
  }

  @override
  Future<ApiResponse> updateUserDeviceToken(
      {required Map<String, dynamic> body}) async {
    return await 300.milliseconds.delay(() => AuthData.loginSuccess);
  }

  @override
  Future<ApiResponse> loginWithPhone({required Map<String, dynamic> body}) {
    // TODO: implement loginWithPhone
    throw UnimplementedError();
  }
}
