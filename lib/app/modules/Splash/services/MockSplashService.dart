import '../../../models/ApiResponse.dart';
import 'SplashService.dart';

class MockSplashService implements SplashService {
  /// Start the server request
  @override
  void init() => null;

  /// Stop the server request
  @override
  void close() => null;
  
  @override
  Future<ApiResponse> doSomething() async {
    // TODO: implement googleLogin
    throw UnimplementedError();
  }
}

