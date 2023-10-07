/*
@category ZStarter Flutter
@ref     Defenzelite Product
@author  <Defenzelite hq@defenzelite.com>
@license <https://www.defenzelite.com Defenzelite Private Limited>
@version <zStarter: 202310-V1.2>
@link    <https://www.defenzelite.com>
*/

import 'package:get/get.dart';
import 'package:zstarter_flutter/app/modules/Modules.dart';

import '../../../../config/Config.dart';
import '../../../shared/controllers/AppController.dart';
import '../../../shared/controllers/AuthState.dart';

class SplashController extends AppController {
  /// Creating Global Instance
  static SplashController get instance {
    if (!Get.isRegistered<SplashController>()) Get.put(SplashController());
    return Get.find<SplashController>();
  }

  /// Initialize For Global Usage (Once per app run)
  final AuthState auth = AuthState.instance;

  @override
  void onInit() {
    super.onInit();
    redirectUser();
  }

  /// --- Core Functionalities Methods ---

  Future<void> redirectUser() async {
    if (Config.authRequired) {
      if (await auth.check()) {
        await 5.delay(() => Get.offAllNamed(Config.homeUrl));
      } else {
        await 5.delay(() => Get.offAllNamed(AuthRoutes.login));
      }
    } else {
      await 5.delay(() => Get.offAllNamed(Config.homeUrl));
    }
  }

  /// --- Common Functionalities Methods ---
// Here you can add a scoped method...

  /// --- Supporting Functionalities Methods ---
// Here you can add a scoped method...

  /// --- Form Functionalities Methods ---
// Here you can add a scoped method...
}
