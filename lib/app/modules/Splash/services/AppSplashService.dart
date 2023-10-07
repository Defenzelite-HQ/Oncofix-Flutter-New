import '../../../models/ApiResponse.dart';
import '../../../helpers/Request.dart';
import 'SplashService.dart';

class AppSplashService implements SplashService {
  /// Start the server request
  @override
  void init() => Request.start();

  /// Stop the server request
  @override
  void close() => Request.close();
  
  @override
  Future<ApiResponse> doSomething() async {
    // TODO: implement googleLogin
    throw UnimplementedError();
  }
}

