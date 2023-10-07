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
import '../../../models/ApiResponse.dart';
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
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  /// --- System Handlers ---
  /// Observables & Getters

  // Add Scoped Var Here...

  /// --- Functionality Handlers ---
  /// Observables & Getters
  final TextEditingController identifierInput = TextEditingController();
  final TextEditingController passwordInput = TextEditingController();

  @override
  void onInit() async {
    super.onInit();
    if (await storage.read('identifier') != null) {
      identifierInput.text = await storage.read(
        'identifier',
      );
    }
    if (await storage.read('password') != null) {
      passwordInput.text = await storage.read(
        'password',
      );
    }
  }

  /// --- Core Functionalities Methods ---
  Future<void> submit() async {
    if (!formKey.currentState!.validate()) return;

    try {
      await storage.write('identifier', identifierInput.text);
      await storage.write('password', passwordInput.text);

      /// Prepare form data to be sent to server.
      Map<String, dynamic> body = {
        "identifier": identifierInput.text,
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

      /// No need to verify OTP
      if (!Config.needsOtpVerification) {
        /// Assign the user data to user object and store locally.
        await auth.setUserData(response.data['user']);
        await auth.setUserToken(response.data['token']);
        Toastr.show(message: "${response.message}");
        // Get.offAllNamed(DashboardRoutes.dashboard);
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

  /// --- Common Functionalities Methods ---
// Here you can add a scoped method...

  /// --- Supporting Functionalities Methods ---
// Here you can add a scoped method...

  /// --- Form Functionalities Methods ---
// Here you can add a scoped method...
}
