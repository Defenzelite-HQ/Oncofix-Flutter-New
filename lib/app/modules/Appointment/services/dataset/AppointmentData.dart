import 'package:oncofix/app/models/ApiResponse.dart';

class AppointmentData {
  /// Appointment Responses
  static ApiResponse get appointment => ApiResponse(
    status: "success",
    message: "Sliders are here.",
    data: {
    "first_name": "Mayank",
    "last_name": "Sarathe",
    }
  );
}

