import '../../../helpers/Request.dart';
import '../../../models/ApiResponse.dart';
import 'GlobalAuthService.dart';

class AppGlobalAuthService implements GlobalAuthService {

  /// Start the server request
  @override
  void init() => null;

  /// Stop the server request
  @override
  void close() => null;

  @override
  Future<ApiResponse> getUser() async {
    return await Request.get('/profile', authenticate: true);
  }

  @override
  Future<ApiResponse> logout() async {
    return await Request.get('/logout', authenticate: true);
  }
}
