import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oncofix/app/modules/Setting/views/widget/SettingPageWidget.dart';

import '../../../shared/views/errors/NotConnectedErrorPage.dart';
import '../../../shared/views/layouts/MasterLayout.dart';
import '../../../shared/views/widgets/LoadingIconWidget.dart';
import '../controllers/SettingController.dart';
import '../route/SettingRoutes.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingController>(
      init: SettingController(),
      builder: (SettingController controller) {
        return !controller.isConnected
            ? NotConnectedErrorPage()
            : controller.isBusy
                ? LoadingIconWidget(message: "Please wait...")
                : MasterLayout(
                    title: "Settings",
                    body: SafeArea(
                      minimum:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SettingPageWidget(
                              title: 'Account',
                              subTitle:
                                  'Manage your public profile and private information',
                              image: 'assets/icons/portrait.svg',
                            ),
                            SettingPageWidget(
                              title: 'Security',
                              subTitle:
                                  'Manage your password and 2-step verification preferences',
                              image: 'assets/icons/lock.svg',
                              onTap: () => Get.toNamed(
                                  SettingRoutes.settingChangePassword),
                            ),
                            SettingPageWidget(
                              title: 'Plan & Billing',
                              subTitle:
                                  'Manage your subscription plan, payment method and billing information',
                              image: 'assets/icons/briefcase.svg',
                              onTap: () => Get.toNamed(
                                  SettingRoutes.settingSubscriptionPlan),
                            ),
                            SettingPageWidget(
                              title: 'Notifications',
                              subTitle:
                                  "Manage when you'll be notified on which channels",
                              image: 'assets/icons/bell.svg',
                              onTap: () => Get.toNamed(
                                  SettingRoutes.settingNotification),
                            ),
                            SettingPageWidget(
                              title: 'Address',
                              subTitle:
                                  "Manage your existing team and change roles/permissions",
                              image: 'assets/icons/users-alt.svg',
                            ),
                            SettingPageWidget(
                              title: 'Payout Info',
                              subTitle:
                                  'Manage your bank detail & Upi detail information',
                              image: 'assets/icons/portrait.svg',
                              // onTap: () => Get.toNamed(PayoutRoutes.addPayout),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
      },
    );
  }
}
