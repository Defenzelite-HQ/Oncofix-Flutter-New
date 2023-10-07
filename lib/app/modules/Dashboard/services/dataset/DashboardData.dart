import 'package:zstarter_flutter/app/models/ApiResponse.dart';

class DashboardData {
  /// Dashboard Responses
  static ApiResponse get dashboard => ApiResponse(
    status: "success",
    message: "Sliders are here.",
    data: {
    "first_name": "Mayank",
    "last_name": "Sarathe",
    }
  );
}

