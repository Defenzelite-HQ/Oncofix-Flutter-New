/*
@category ZStarter Flutter
@ref     Defenzelite Product
@author  <Defenzelite hq@defenzelite.com>
@license <https://www.defenzelite.com Defenzelite Private Limited>
@version <zStarter: 202310-V1.2>
@link    <https://www.defenzelite.com>
*/

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ui_x/helpers/Toastr.dart';

import '../../../../config/Config.dart';
import '../../../helpers/Global.dart';
import '../../../helpers/Request.dart';
import '../../../models/ApiResponse.dart';
import '../../../models/UserModel.dart';
import '../../../shared/controllers/FCMController.dart';
import '../../../shared/shared.dart';
import '../../Modules.dart';

class LoginController extends AppController {
  /// Creating Global Instance
  static LoginController get instance {
    if (!Get.isRegistered<LoginController>()) Get.put(LoginController());
    return Get.find<LoginController>();
  }

  /// Initialise [AttendanceService] service
  final AuthService _authService = AuthService.instance;

  /// Initialize For Global Usage (Once per app run)
  final FCMController fcmController = Get.find();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  /// --- System Handlers ---
  /// Observables & Getters

  // Add Scoped Var Here...

  /// --- Functionality Handlers ---
  /// Observables & Getters
  var _user = UserModel().obs;

  UserModel get user => this._user.value;

  var _selectedRole = "Patient".obs;

  String get selectedRole => this._selectedRole.value;

  final TextEditingController identifierInput = TextEditingController();
  final TextEditingController passwordInput = TextEditingController();
  final TextEditingController usernameInput = TextEditingController();
  final TextEditingController emailInput = TextEditingController();
  final TextEditingController phoneInput = TextEditingController();
  final TextEditingController confirmPasswordInput = TextEditingController();
  final TextEditingController referralCodeInput = TextEditingController();

  @override
  void onInit() async {
    super.onInit();
    if (await storage.read('identifier') != null) {
      emailInput.text = await storage.read(
        'identifier',
      );
    }
    if (await storage.read('password') != null) {
      passwordInput.text = await storage.read(
        'password',
      );
    }
    // auth.getUser();
  }

  /// --- Core Functionalities Methods ---
  Future<void> submit() async {
    if (!formKey.currentState!.validate()) return;

    try {
      await storage.write('identifier', emailInput.text);
      await storage.write('password', passwordInput.text);

      /// Prepare form data to be sent to server.
      Map<String, dynamic> body = {
        "email": emailInput.text,
        "password": passwordInput.text,
      };

      /// Init API Request Server.
      _authService.init();

      /// Call api to login user.
      ApiResponse response = await _authService.login(body: body);

      /// Check for any errors.
      if (response.hasError()) {
        Toastr.show(message: "${response.message}");
        return;
      }
      await updateUserDeviceToken();
      log.w(response.data);

      /// No need to verify OTP
      if (!Config.needsOtpVerification) {
        /// Assign the user data to user object and store locally.
        await auth.setUserData(response.data['user']);
        await auth.setUserToken(response.data['access_token']);
        // Toastr.show(message: "${response.message}");
        Get.offAllNamed(DashboardRoutes.dashboard);
      } else {
        /// Need to verify OTP
        ///
        /// Redirect to Verify OTP Page with identifier
        Get.toNamed(AuthRoutes.verifyOtp,
            parameters: {"identifier": identifierInput.text});
      }

      /// Close API Request Server
      _authService.close();
    } on Exception catch (e) {
      Get.to(() => ServerErrorPage(message: "${e.toString()}"));
    }
  }

  Future<void> register() async {
    if (!formKey.currentState!.validate()) {
      Toastr.show(message: "Please fill all required fields to continue!");
      return;
    }

    Map<String, dynamic> body = {
      "name": usernameInput.text,
      "email": emailInput.text,
      "role": _selectedRole.value,
      "refferal_code": referralCodeInput.text,
      "phone": phoneInput.text,
      "password": passwordInput.text,
      "password_confirmation": confirmPasswordInput.text,
    };

    setBusy(true);
    ApiResponse response = await Request.post('/register', body: body);

    if (response.hasError()) {
      log.w(response.data);

      Toastr.show(message: "${response.message}");
      setBusy(false);
      return;
    }
    // ShowSnack.toast(message: "${response.message}");
    Get.offAllNamed(AuthRoutes.login);
    setBusy(false);
  }

  Future<void> updateUserDeviceToken() async {
    Map<String, dynamic> body = {"fcm_token": fcmController.deviceToken};
    if (await auth.check()) {
      await _authService.updateUserDeviceToken(body: body);
    }
  }

  /// --- Common Functionalities Methods ---
// Here you can add a scoped method...

  /// --- Supporting Functionalities Methods ---
  void onSelectedRole(String value) {
    _selectedRole(value);
  }

  /// --- Form Functionalities Methods ---
// Here you can add a scoped method...
}
