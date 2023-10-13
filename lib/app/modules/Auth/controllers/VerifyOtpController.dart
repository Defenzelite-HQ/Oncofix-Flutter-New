/*
@category ZStarter Flutter
@ref     Defenzelite Product
@author  <Defenzelite hq@defenzelite.com>
@license <https://www.defenzelite.com Defenzelite Private Limited>
@version <zStarter: 202310-V1.2>
@link    <https://www.defenzelite.com>
*/

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_countr/Countr.dart';
import 'package:get/get.dart';
import 'package:ui_x/helpers/Toastr.dart';

import '../../../helpers/Global.dart';
import '../../../models/ApiResponse.dart';
import '../../../shared/controllers/AppController.dart';
import '../../Modules.dart';

class VerifyOtpController extends AppController {
  /// Creating Global Instance
  static VerifyOtpController get instance {
    if (!Get.isRegistered<VerifyOtpController>())
      Get.put(VerifyOtpController());
    return Get.find<VerifyOtpController>();
  }

  /// Initialise [AuthService] service
  final _authService = AuthService.instance;

  /// Initialize For Global Usage (Once per app run)
  CountrController? countrController;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  /// --- System Handlers ---
  /// Observables & Getters

  // Add Scoped Var Here...

  /// --- Functionality Handlers ---
  /// Observables & Getters
  var _otp = "".obs;

  String get otp => _otp.value;
  var _start = '20'.obs;

  String get start => _start.value;
  var _timeUp = true.obs;

  bool get timeUp => _timeUp.value;

  /// Variables

  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController emailInput = TextEditingController();

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
  ///
  Future<void> submitOtp() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    // try {
    /// Prepare form data to be sent to server
    Map<String, dynamic> body = {
      "email": emailInput.text,
      "otp": _otp.value,
    };

    /// Call api to login user
    ApiResponse response = await _authService.verifyOtp(body: body);

    if (response.hasValidationErrors()) {
      Toastr.show(message: "${response.validationError}");
      return;
    }
    if (response.hasError()) {
      Toastr.show(message: "${response.message}");
      Get.offAllNamed('/dashboard');
      return;
    }

    await auth.setUserData(response.data['user']);
    // await auth.setUserToken(response.data['token']);

    // if (int.parse(auth.user.progress!) < 1) {
    //   Get.offAllNamed('/profile');
    //   log.w(response.data);
    // } else if (int.parse(auth.user.progress!) < 2) {
    //   Get.offAllNamed('/clinicProfile');
    // } else if (int.parse(auth.user.progress!) < 3) {
    //   if (storage.read('onboarded') != null) {
    //     Get.offAllNamed('/dashboard');
    //   } else {
    //     Get.offAllNamed('/onboarding');
    //   }
    // } else {
    // Get.offAllNamed('/dashboard');
    // }
    // } on Exception catch (e) {
    //   Get.to(() => ServerErrorPage(message: "${e.toString()}"));
    // }
  }

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
