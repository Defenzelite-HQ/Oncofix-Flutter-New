import '../../../models/ApiResponse.dart';
import 'SettingService.dart';

class MockSettingService implements SettingService {
  /// Start the server request
  @override
  void init() => null;

  /// Stop the server request
  @override
  void close() => null;

  @override
  Future<ApiResponse> doSomething() async {
    throw UnimplementedError();
  }

  /// [State and City]

  Future<ApiResponse> getState() {
    throw UnimplementedError();
  }

  Future<ApiResponse> getCity({required stateID}) {
    throw UnimplementedError();
  }

/// [Mock Account Service]

  Future<ApiResponse> updateAccount({required Map<String, dynamic> body}) {
    /// implement verifyOtp
    throw UnimplementedError();
  }

  /// [Mock Address Service]

  @override
  Future<ApiResponse> createAddress({required Map<String, dynamic> body}) {
    throw UnimplementedError();
  }

  Future<ApiResponse> getAddressList() {
    throw UnimplementedError();
  }

  Future<ApiResponse> updateAddress({required Map<String, dynamic> body, required int id}) {
    throw UnimplementedError();
  }

  Future<ApiResponse> deleteAddress({required int id}) {
    throw UnimplementedError();
  }

  /// [Change Password]
  @override
  Future<ApiResponse> changePassword({required Map<String, dynamic> body}) {
    /// implement verifyOtp
    throw UnimplementedError();
  }

  // [Subscription Plan]
    @override
    Future<ApiResponse> getPlans(){
      /// implement verifyOtp
      throw UnimplementedError();
    }
    Future<ApiResponse> checkout({required int id}){
      /// implement verifyOtp
      throw UnimplementedError();
    }

}
