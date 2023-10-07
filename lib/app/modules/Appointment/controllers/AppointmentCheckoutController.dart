import 'dart:convert';
import 'package:get/get.dart';
import 'package:ui_x/helpers/Toastr.dart';
import '../../../helpers/Request.dart';
import '../../../models/ApiResponse.dart';
import '../../../shared/controllers/AppController.dart';
import '../models/AppointmentModel.dart';

class AppointmentCheckoutController extends AppController {
  var _appointment = MyAppointmentModel().obs;
  var _checkingOut = false.obs;

  MyAppointmentModel get appointment => this._appointment.value;

  bool get checkingOut => this._checkingOut.value;

  @override
  void onInit() {
    super.onInit();
    _appointment(MyAppointmentModel.fromJson(
        jsonDecode(Get.parameters['appointment'].toString())));
  }

  Future<void> checkout() async {
    _checkingOut(true);
    Map<String, dynamic> body = {
      "appointment_id": _appointment.value.id.toString(),
    };

    ApiResponse response = await Request.post('/appointments/checkout',
        body: body, authenticate: true);

    if (response.hasError()) {
      Toastr.show(message: "${response.message}");
      _checkingOut(false);
      return;
    }

    Get.toNamed("/my-appointments");
   Toastr.show(message: "Appointment booked successfully!");

    _checkingOut(false);
  }
}
