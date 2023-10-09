import 'package:oncofix/app/models/ApiResponse.dart';

class DashboardData {
  /// Dashboard Responses
  static ApiResponse get dashboard =>
      ApiResponse(status: "success", message: "Sliders are here.", data: {
        "doctor": [
          {
            "id": "about_cancer",
            "image": "assets/icons/doctor_slider_banner.jpg",
          },
          {
            "id": "money_matters",
            "image": "assets/icons/doctor_slider_banner1.jpg",
          },
          {
            "id": "clinical_trial",
            "image": "assets/icons/doctor_slider_banner.jpg",
          },
          {
            "id": "oncofix_screening",
            "image": "assets/icons/doctor_slider_banner1.jpg",
          },
        ],
        "patient": [
          {
            "id": "about_cancer",
            "image": "assets/icons/home-banner-07.jpg",
          },
          {
            "id": "money_matters",
            "image": "assets/icons/home-banner-3.png",
          },
          {
            "id": "oncofix_screening",
            "image": "assets/icons/home-banner-5.png",
          },
        ],
      });
}
