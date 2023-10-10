import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:ui_x/helpers/Helpers.dart';

import 'Global.dart';

/// WebView Method to redirect to web
///
/// Example:
///    onTap: () => webViewOnTap("about_cancer"),
///
void webViewOnTap(String id) {
  /// Find the map in webViewItemList where the 'id' matches the provided 'id'
  Map<String, Object> webViewItem =
      webViewItemList.firstWhere((t) => t["id"] == id);

  /// Check if the webViewItem is found and contains the 'url' property
  if (webViewItem.containsKey("url")) {
    String url = webViewItem["url"].toString();
    String token = auth.user.accessCode;
    String appUrlToken;
    if (url.contains('?')) {
      // If the URL already has query parameters, add the token with an ampersand
      appUrlToken = url + '&ref=app&token=$token';
    } else {
      // Otherwise, add the token with a question mark
      appUrlToken = url + '?ref=app&token=$token';
    }

    // String appUrlToken = url + "?ref=app&token=${storage.read("token")}";
    String title = webViewItem["title"].toString();

    log.w("Url::::$appUrlToken");
    log.w("Title::::$title");

    /// And Redirect to WebView
    Get.toNamed("/webview", parameters: {"url": appUrlToken, "title": title});
  } else {
    Toastr.show(message: "Invalid 'id' or missing 'url' property");
  }
}

/// List of Web view
List<Map<String, Object>> webViewItemList = [
  {
    "id": "about_cancer",
    "title": "About Cancer",
    "url": "https://oncofix.com/learn/116",
  },
  {
    "id": "about_us",
    "title": "About Us",
    "url": "https://oncofix.com/about-us",
  },
  {
    "id": "terms_&_condition",
    "title": "Terms & Condition",
    "url": "https://oncofix.com/page/terms?src=app",
  },
  {
    "id": "privacy_policy",
    "title": "Privacy Policy",
    "url": "https://oncofix.com/page/privacy",
  },
  {
    "id": "return_policy",
    "title": "Return Policy",
    "url": "https://oncofix.com/page/privacy",
  },
  {
    "id": "doctors_recourse",
    "title": "Doctors Recourse",
    "url": "https://oncofix.com/doctor",
  },
  {
    "id": "blogs",
    "title": "Blogs",
    "url": "https://oncofix.com/blog",
  },
  {
    "id": "shop",
    "title": "Shop",
    "url": "https://oncofix.com/shop?sp=nhf",
  },
  {
    "id": "support_group",
    "title": "Support Group",
    "url": "https://oncofix.com/forums",
  },
  {
    "id": "events",
    "title": "Events",
    "url": "https://oncofix.com/event?sp=nhf",
  },
  {
    "id": "clinical_trial",
    "title": "Clinical Trial",
    "url": "https://oncofix.com/clinical-trial",
  },
  {
    "id": "money_matters",
    "title": "Money Matters",
    "url": "https://oncofix.com/money-mattress",
  },
  {
    "id": "oncofix_screening",
    "title": "Screening",
    "url": "https://screening.oncofix.com/assessment",
  },
  {
    "id": "oncofix_youtube",
    "title": "Oncofix",
    "url": "https://www.yaoutube.com/channel/UCb24CCIAUNHbF9PAuAK9s7g",
  },
  {
    "id": "doctor_chat",
    "title": "Dr.Onco",
    "url": "https://chatbot.oncofix.com/chat?id=12",
  },
  {
    "id": "patient",
    "title": "Patients",
    "url": "https://oncofix.com/panel/patient/index",
  },
  {
    "id": "add_patient",
    "title": "Add Patient",
    "url": "https://oncofix.com/panel/patient/create",
  },
  {
    "id": "search_patient",
    "title": "Search Patient",
    "url": "https://oncofix.com/panel/patient/create?active=search",
  },
  {
    "id": "patient_report",
    "title": "Report",
    "url": "https://oncofix.com/panel/patient/report?cancer=396",
  },
  {
    "id": "report",
    "title": "Report",
    "url": "https://oncofix.com/panel/report?from=&to=&type=age&cancer=396",
  },
  {
    "id": "tumour_board_meetings",
    "title": "Tumour Board",
    "url": "https://oncofix.com/panel/tumour-board",
  },
  {
    "id": "my_events",
    "title": "Become Host",
    "url": "https://oncofix.com/panel/constant-management/consultant-meeting",
  },
  {
    "id": "events",
    "title": "Events",
    "url": "https://oncofix.com/event",
  },
  {
    "id": "doctor_appointments",
    "title": "Appointments",
    "url": "https://oncofix.com/panel/appointment",
  },
  {
    "id": "doctor_profile",
    "title": "profile",
    "url": "https://oncofix.com/panel/user-profile",
  },
  {
    "id": "today_appointments",
    "title": "Appointments",
    "url": "https://oncofix.com/panel/appointment?date=${Jiffy(DateTime.now().toString()).format("yyyy-MM-dd")}",
  },
  {
    "id": "my_schedule",
    "title": "My Schedule",
    "url": "https://oncofix.com/panel/doctor/my-schedule",
  },
  {
    "id": "patient_attendance",
    "title": "Attendance ",
    "url": "https://oncofix.com/panel/patient_attendance",
  },
  {
    "id": "doctor_list",
    "title": "Doctors ",
    "url": "https://oncofix.com/doctor",
  },
  {
    "id": "qrcode",
    "title": "QRcode",
    "url": "https://oncofix.com/qrcode",
  },
  {
    "id": "my_cases",
    "title": "My Cases",
    "url": "https://oncofix.com/panel/patient/case",
  },
  {
    "id": "doctor_pro",
    "title": "PRO",
    "url": "https://oncofix.com/panel/doctor/standard-pro",
  },
  {
    "id": "patient_pro",
    "title": "PRO",
    "url": "https://oncofix.com/panel/patient/standard-pro/list",
  },
  {
    "id": "notification_doctor",
    "title": "Notification",
    "url": "https://oncofix.com/panel/constant-management/notification",
  },
];
