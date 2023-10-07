import 'package:oncofix/app/models/ApiResponse.dart';

class CasesData {
  /// Cases Responses
  static ApiResponse get cases => ApiResponse(
    status: "success",
    message: "Sliders are here.",
    data: {
    "first_name": "Mayank",
    "last_name": "Sarathe",
    }
  );
}

