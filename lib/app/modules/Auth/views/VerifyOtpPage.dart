import 'package:flutter/material.dart';
import 'package:flutter_countr/Countr.dart';
import 'package:flutter_countr/CountrDuration.dart';
import 'package:get/get.dart';
import 'package:oncofix/app/modules/Dashboard/DashboardModule.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:ui_x/ui_x.dart';
import '../../../helpers/Global.dart';
import '../../../shared/views/layouts/AuthLayout.dart';
import '../controllers/VerifyOtpController.dart';

class VerifyOtpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screen = Get.size;
    return GetBuilder<VerifyOtpController>(
        init: VerifyOtpController(),
        builder: (VerifyOtpController controller) {
          return AuthLayout(
            backgroundColor: kcWhite,
            body: SafeArea(
              child: SingleChildScrollView(
                child: GestureDetector(
                  onTap: () => Keyboard.hide(context),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 90, horizontal: 30),
                    color: Colors.transparent,
                    width: double.infinity,
                    height: screen.height - 75,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(height: 20),
                        Container(
                          child: Image.asset(
                            image('logo.png'),
                            height: 50,
                          ),
                        ),
                        const SizedBox(height: spacer),
                        Text("Verify OTP,", style: TextStyl.subtitle!.copyWith(fontWeight: FontWeight.bold, fontSize: 20)),
                        const SizedBox(height: spacer1),
                        Text("Please enter the OTP sent to", style: TextStyl.bodySm!.copyWith(fontWeight: FontWeight.w500, fontSize: 14)),
                        Text("admin@test.com ${controller.phoneNumber.text}", style: TextStyl.subtitle!.copyWith(fontSize: 15, color: kcBlack.withOpacity(0.5))),
                        const SizedBox(height: 70),
                        Center(
                          child: PinFieldAutoFill(
                            currentCode: controller.otp,
                            codeLength: 4,
                            decoration: UnderlineDecoration(
                                colorBuilder: FixedColorBuilder(kcDarkAlt), gapSpace: 20, textStyle: TextStyle(color: kcDarkAlt, fontSize: 35, height: -0.0010)),
                            onCodeSubmitted: (code) {},
                          ),
                        ),
                        const SizedBox(height: 20),
                        Obx(
                          () => controller.timeUp == true
                              ? Row(
                                  children: [
                                    Spacer(),
                                    Text(
                                      'RESENDING CODE IN',
                                      style: TextStyl.subtitle!.copyWith(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Countr(
                                        controller: controller.countrController!,
                                        onTimerComplete: () {
                                          controller.setTimeUp();
                                        },
                                        builder: (BuildContext context, CountrDuration remainingTime) {
                                          return Container(
                                            child: Text(
                                              "${remainingTime.minutes}:${remainingTime.seconds}",
                                              style: TextStyl.bodySm?.copyWith(color: kcBlack, fontWeight: FontWeight.bold),
                                            ),
                                          );
                                        })
                                  ],
                                )
                              : Row(
                                  children: [
                                    Spacer(),
                                    GestureDetector(
                                      onTap: () async {
                                        //controller.resentTime();
                                        controller.setStartTimeUp();
                                      },
                                      child: Text(
                                        'Resent Code',
                                        style: TextStyl.bodySm,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                        const SizedBox(height: 20),
                        Button.block(
                          key: UniqueKey(),
                          label: "Verify OTP",
                          onTap: (btn) async {
                            btn.setBusy(true).setDisabled(true);
                            Get.toNamed(DashboardRoutes.dashboard);
                            btn.setBusy(false).setDisabled(false);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
