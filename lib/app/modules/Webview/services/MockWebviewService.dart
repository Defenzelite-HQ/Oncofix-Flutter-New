import '../../../models/ApiResponse.dart';
import 'WebviewService.dart';

class MockWebviewService implements WebviewService {
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

