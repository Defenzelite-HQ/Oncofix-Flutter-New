/*
@category ZStarter Flutter
@ref     Defenzelite Product
@author  <Defenzelite hq@defenzelite.com>
@license <https://www.defenzelite.com Defenzelite Private Limited>
@version <zStarter: 202310-V1.2>
@link    <https://www.defenzelite.com>
*/

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_x/ui_x.dart';

import '../../../models/ApiResponse.dart';
import '../../../shared/shared.dart';
import '../../Modules.dart';

class RegisterController extends AppController {
  /// Creating Global Instance
  static RegisterController get instance {
    if (!Get.isRegistered<RegisterController>()) Get.put(RegisterController());
    return Get.find<RegisterController>();
  }

  /// Initialise [AuthService] service
  final _authService = AuthService.instance;

  /// Initialize For Global Usage (Once per app run)

  /// --- System Handlers ---
  /// Observables & Getters

  // Add Scoped Var Here...

  /// --- Functionality Handlers ---
  /// Observables & Getters
  var _selectedState = 0.obs;

  int get selectedState => _selectedState.value;
  var _selectedDob = DateTime.now().obs;

  DateTime get selectedDob => _selectedDob.value;
  var _selectedGender = "0".obs;

  String get selectedGender => _selectedGender.value;


  /// Variables
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController firstNameInput = TextEditingController();
  final TextEditingController lastNameInput = TextEditingController();
  final TextEditingController usernameInput = TextEditingController();
  final TextEditingController emailInput = TextEditingController();
  final TextEditingController phoneInput = TextEditingController();
  final TextEditingController passwordInput = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  /// --- Core Functionalities Methods ---

  Future<void> submit() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    try {
      /// Prepare form data to be sent to server.
      Map<String, dynamic> body = {
        "first_name": firstNameInput.text.trim().toString(),
        "last_name": lastNameInput.text.trim().toString(),
        "username": usernameInput.text.trim().toString(),
        "email": emailInput.text.trim().toString(),
        "phone": phoneInput.text.trim().toString(),
        "password": passwordInput.text.trim().toString(),
        "gender": _selectedGender.value,
        "dob":
            "${_selectedDob.value.year}/${_selectedDob.value.month}/${_selectedDob.value.day}",
      };

      /// Call Service to Get API Response
      ApiResponse response = await _authService.register(body: body);

      /// Checking Validation Errors
      if (response.hasValidationErrors()) {
        Toastr.show(message: "${response.validationError}");
        return;
      }

      /// Checking Response Error
      if (response.hasError()) {
        Toastr.show(message: "${response.message}");
        return;
      }
      Get.offAllNamed(AuthRoutes.login);
    } on Exception catch (e) {
      Get.to(() => ServerErrorPage(message: "${e.toString()}"));
    }
  }

  /// --- Common Functionalities Methods ---
  // Here you can add a scoped method...

  /// --- Supporting Functionalities Methods ---
  void onStateSelect(int state) {
    _selectedState(state);
  }

  void onGenderSelect(String value) {
    _selectedGender(value);
  }

  void onDobSelect(DateTime? newDate) {
    _selectedDob(newDate);
  }

  /// --- Form Functionalities Methods ---
// Here you can add a scoped method...
}
