import 'package:oncofix/app/models/ApiResponse.dart';

class DoctorData {
  /// Doctor Responses
  static ApiResponse get doctor => ApiResponse(
    status: "success",
    message: "Sliders are here.",
    data: {
    "first_name": "Mayank",
    "last_name": "Sarathe",
    }
  );
}

