/*
@category ZStarter Flutter
@ref     Defenzelite Product
@author  <Defenzelite hq@defenzelite.com>
@license <https://www.defenzelite.com Defenzelite Private Limited>
@version <zStarter: 202310-V1.2>
@link    <https://www.defenzelite.com>
*/

import 'package:flutter/material.dart';
import 'package:flutter_countr/Countr.dart';
import 'package:get/get.dart';

import '../../../helpers/Global.dart';
import '../../../shared/controllers/AppController.dart';
import '../../Modules.dart';

class ForgotOtpController extends AppController {
  /// Creating Global Instance
  static ForgotOtpController get instance {
    if (!Get.isRegistered<ForgotOtpController>())
      Get.put(ForgotOtpController());
    return Get.find<ForgotOtpController>();
  }

  /// Initialise [AuthService] service
  final AuthService _authService = AuthService.instance;

  /// Initialize For Global Usage (Once per app run)
  CountrController? countrController;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  /// --- System Handlers ---
  /// Observables & Getters

  var _otp = "".obs;

  String get otp => _otp.value;
  var _start = '20'.obs;

  String get start => _start.value;
  var _timeUp = true.obs;

  bool get timeUp => _timeUp.value;

  /// --- Functionality Handlers ---
  /// Observables & Getters


  final TextEditingController phoneNumber = TextEditingController();

  @override
  onInit() async {
    super.onInit();
    countrController = CountrController(
        endTime: int.parse(_start.value).seconds, initialize: true);
    if (await storage.read('phone') != null) {
      phoneNumber.text = await storage.read('phone');
    }
  }


/// --- Core Functionalities Methods ---
// Here you can add a scoped method...

/// --- Common Functionalities Methods ---
// Here you can add a scoped method...


/// --- Supporting Functionalities Methods ---

  void resentTime() {
    countrController!.startTimer();
  }

  void setTimeUp() {
    _timeUp.value = false;
  }

  void setStartTimeUp() {
    _timeUp.value = true;
  }

/// --- Form Functionalities Methods ---
// Here you can add a scoped method...
}
