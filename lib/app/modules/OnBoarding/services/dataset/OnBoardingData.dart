import 'package:oncofix/app/models/ApiResponse.dart';

class OnBoardingData {
  /// OnBoarding Responses
  static ApiResponse get onboarding => ApiResponse(
    status: "success",
    message: "Sliders are here.",
    data: {
    "first_name": "Mayank",
    "last_name": "Sarathe",
    }
  );
}

