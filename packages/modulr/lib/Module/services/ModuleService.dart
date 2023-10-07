const String stub = """
import '../../../models/ApiResponse.dart';
import 'package:get/get.dart';

import 'Api{MODULE}Service.dart';
import 'Mock{MODULE}Service.dart';

abstract class {MODULE}Service {
  /// Configure if Mock is enabled or not @accepts[true|false]
  static const MOCK_ENABLED = true;

  /// Create and get the instance of [{MODULE}Service]
  static {MODULE}Service get instance {
    if (!Get.isRegistered<{MODULE}Service>()) Get.lazyPut<{MODULE}Service>(() => MOCK_ENABLED ? Mock{MODULE}Service() : Api{MODULE}Service());
    return Get.find<{MODULE}Service>();
  }
  
  /// Start the server request
  void init();

  /// Stop the server request
  void close();

 /// Index
 Future<ApiResponse> index();

  /// Show
  Future<ApiResponse> show({required int id});
  
  /// Create
  Future<ApiResponse> create({required Map<String, dynamic> body});
  
  /// Store
  Future<ApiResponse> store({required Map<String, dynamic> body});
 
  /// Edit
  Future<ApiResponse> edit({required Map<String, dynamic> body, required int id});

 /// Update
  Future<ApiResponse> patch({required Map<String, dynamic> body, required int id});
 
  /// Delete
  Future<ApiResponse> delete({required int id});
}
""";
