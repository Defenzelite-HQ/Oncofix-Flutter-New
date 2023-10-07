const String stub = """
import 'package:zstarter_flutter/app/models/ApiResponse.dart';

class {MODULE}Data {
  /// {MODULE} Responses
  static ApiResponse get {CAMEL_MODULE} => ApiResponse(
    status: "success",
    message: "Sliders are here.",
    data: {
    "first_name": "Mayank",
    "last_name": "Sarathe",
    }
  );
}
""";
