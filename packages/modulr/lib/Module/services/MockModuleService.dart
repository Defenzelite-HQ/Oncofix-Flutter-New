const String stub = """
import '../../../models/ApiResponse.dart';
import '{MODULE}Service.dart';
import 'package:get/get.dart';
import 'dataset/{MODULE}Data.dart';

class Mock{MODULE}Service implements {MODULE}Service {
  /// Start the server request
  @override
  void init() => null;

  /// Stop the server request
  @override
  void close() => null;
  
  @override
  Future<ApiResponse> index() async {
    return await 300.milliseconds.delay(() => {MODULE}Data.{CAMEL_MODULE});
  }

  @override
  Future<ApiResponse> show({required int id}) async {
    return await 300.milliseconds.delay(() => {MODULE}Data.{CAMEL_MODULE});
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
""";
