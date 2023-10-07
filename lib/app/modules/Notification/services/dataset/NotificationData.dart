import 'package:zstarter_flutter/app/models/ApiResponse.dart';

class NotificationData {
  /// Notification Responses
  static ApiResponse get notification => ApiResponse(
    status: "success",
    message: "Sliders are here.",
    data: {
    "first_name": "Mayank",
    "last_name": "Sarathe",
    }
  );
}

