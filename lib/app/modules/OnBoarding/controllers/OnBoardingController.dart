/*
@category ZStarter Flutter
@ref     Defenzelite Product
@author  <Defenzelite hq@defenzelite.com>
@license <https://www.defenzelite.com Defenzelite Private Limited>
@version <zStarter: 202310-V1.2>
@link    <https://www.defenzelite.com>
*/

import 'package:get/get.dart';
import 'package:oncofix/app/modules/Auth/AuthModule.dart';
import 'package:oncofix/app/modules/Dashboard/DashboardModule.dart';
import '../../../../config/Config.dart';
import '../../../shared/controllers/AppController.dart';
import '../../../helpers/Global.dart';
import '../../../models/ApiResponse.dart';
import '../services/OnBoardingService.dart';
import '../models/OnBoardingModel.dart';

// Third Party Packages
import 'package:flutter/cupertino.dart';
import 'package:ui_x/helpers/Toastr.dart';

class OnBoardingController extends AppController {
  /// Creating Global Instance
  static OnBoardingController get instance {
    if (!Get.isRegistered<OnBoardingController>())
      Get.put(OnBoardingController());
    return Get.find<OnBoardingController>();
  }

  /// Initialise [OnBoardingService] service
  final OnBoardingService _onboardingService = OnBoardingService.instance;

  /// Initialize For Global Usage (Once per app run)
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  /// --- System Handlers ---
  /// Observables & Getters

  // Add Scoped Var Here...

  /// --- Functionality Handlers ---
  /// Observables & Getters

  @override
  void onInit() {
    super.onInit();
  }

  /// --- Core Functionalities Methods ---

  Future<void> onGetStarted() async {
    storage.write('initiated', 1);

    if (await auth.check()) {
      Get.offNamed(Config.homeUrl);
    } else {
      Get.offNamed(AuthRoutes.login);
    }
  }

  /// --- Common Functionalities Methods ---
// Here you can add a scoped method...

  /// --- Supporting Functionalities Methods ---
// Here you can add a scoped method...

  /// --- Form Functionalities Methods ---
// Here you can add a scoped method...
}
