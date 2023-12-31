import '../../../models/ApiResponse.dart';
import '../../../helpers/Request.dart';
import 'CasesService.dart';

class ApiCasesService implements CasesService {
  /// Start the server request
  @override
  void init() => Request.start();

  /// Stop the server request
  @override
  void close() => Request.close();
  
 @override
  Future<ApiResponse> index() async {
    return await Request.get('/url', authenticate: true);
  }

  @override
  Future<ApiResponse> show({required int id}) async {
    return await Request.get('/url', authenticate: true);
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
  Future<ApiResponse> edit({required Map<String, dynamic> body, required int id}) async {
    return await Request.post('/url', body: body, authenticate: true);
  }

  @override
  Future<ApiResponse> patch({required Map<String, dynamic> body, required int id}) async {
    return await Request.post('/url', body: body, authenticate: true);
  }

  @override
  Future<ApiResponse> delete({required int id}) async {
    return await Request.get('/url', authenticate: true);
  }
}

