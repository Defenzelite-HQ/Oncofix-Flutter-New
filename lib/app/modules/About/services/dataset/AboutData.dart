import 'package:zstarter_flutter/app/models/ApiResponse.dart';

class AboutData {
  /// About Responses
  static ApiResponse get about => ApiResponse(
    status: "success",
    message: "Sliders are here.",
    data: {
    "first_name": "Mayank",
    "last_name": "Sarathe",
    }
  );
}

