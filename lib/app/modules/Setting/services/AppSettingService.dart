import '../../../helpers/Request.dart';
import '../../../models/ApiResponse.dart';
import 'SettingService.dart';

class AppSettingService implements SettingService {
  /// Start the server request
  @override
  void init() => Request.start();

  /// Stop the server request
  @override
  void close() => Request.close();

  @override
  Future<ApiResponse> doSomething() async {
    ///  implement googleLogin
    throw UnimplementedError();
  }

  /// [State and City]
  Future<ApiResponse> getState() async {
    return await Request.post('/get-states', authenticate: true);
  }

  Future<ApiResponse> getCity({required stateID}) async {
    return await Request.post('/get-cities?state_id=$stateID', authenticate: true);
  }

  ///  [App Account Service]
  @override
  Future<ApiResponse> updateAccount({required Map<String, dynamic> body}) async {
    return await Request.post('/update-profile', body: body);
  }

  /// [App Address Service]

  @override
  Future<ApiResponse> createAddress({required Map<String, dynamic> body}) async {
    return await Request.post('/user-addresses/create', body: body, authenticate: true);
  }

  Future<ApiResponse> getAddressList() async {
    return await Request.get('/user-addresses/index', authenticate: true);
  }

  Future<ApiResponse> updateAddress({required Map<String, dynamic> body, required int id}) async {
    return await Request.post('/user-addresses/edit/$id', body: body, authenticate: true);
  }

  Future<ApiResponse> deleteAddress({required int id}) async {
    return await Request.get('/user-addresses/delete/$id', authenticate: true);
  }

  /// [Change Password]
  @override
  Future<ApiResponse> changePassword({required Map<String, dynamic> body}) async {
    return await Request.post('/change-password', body: body,authenticate: true);
  }

  /// [Subscription Plan]
  @override
  Future<ApiResponse> getPlans() async {
    return await Request.get('/subscriptions/user/plans',authenticate: true);
  }

  Future<ApiResponse> checkout({required int id}) async {
    return await Request.post('/subscriptions/user/plan/$id/checkout',authenticate: true);
  }

}
