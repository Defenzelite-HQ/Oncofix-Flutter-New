import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ui_x/ui_x.dart';

import '../../../../config/Config.dart';
import '../../../helpers/Global.dart';
import '../../../shared/views/layouts/AuthLayout.dart';
import '../../Modules.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
        init: LoginController(),
        builder: (LoginController controller) {
          return AuthLayout(
            body: SafeArea(
              child: GestureDetector(
                onTap: () => Keyboard.hide(context),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  color: Colors.transparent,
                  width: double.infinity,
                  height: screen.height - 65,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Spacer(),
                                InkWell(
                                  onTap: () {

                                  },
                                  child: SvgPicture.asset(
                                    'assets/icons/helpdesk.svg',
                                    color: kcBlack.withOpacity(0.7),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 30),
                            Container(
                              child: Image.asset(
                               "assets/systems/logo.png",
                                width: 55,
                              ),
                            ),
                            const SizedBox(height: spacer2),
                            Text("Welcome Back,", style: TextStyl.title!.copyWith(fontWeight: FontWeight.w700)),
                            Text(
                              "Sign in to continue.",
                              style: TextStyl.body,
                            ),
                            // Text("Sign in to continue", style: TextStyl.body!.copyWith(fontWeight: FontWeight.bold)),
                          ],
                        ),
                        //  SizedBox(height: 10),
                        Form(
                          key: controller.formKey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("${Config.hasEmail ? "Email" : Config.hasPhone ? "Phone" : "Username"} *"),
                              SizedBox(height: 5),
                              FormInput(
                                controller: controller.identifierInput,
                                placeholder: "${Config.hasEmail ? "Email" : Config.hasPhone ? "Phone" : "Username"}",
                                leading: Icon(FeatherIcons.user),
                                type: Config.hasEmail
                                    ? TextInputType.emailAddress
                                    : Config.hasPhone
                                        ? TextInputType.number
                                        : TextInputType.text,
                                validator: (value) => Validator("Email / Phone / Username", value!).required().validate(),
                              ),
                              SizedBox(height: 15),
                              if (Config.hasPasswordLogin) Text("Password *"),
                              if (Config.hasPasswordLogin) SizedBox(height: 5),
                              if (Config.hasPasswordLogin)
                                FormInput.password(
                                  controller: controller.passwordInput,
                                  placeholder: "Password",
                                  leading: Icon(Icons.lock_outline),
                                  validator: (value) => Validator("password", value!).required().validate(),
                                  action: TextInputAction.done,
                                ),
                              if (Config.allowForgotPassword)
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        onTap: () => Get.toNamed('/forgotPassword'),
                                        child: Text(
                                          'Forgot Password?',
                                          style: TextStyl.button?.copyWith(color: kcPrimary.withOpacity(0.7), fontSize: 12),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              SizedBox(height: 4),
                              Button.block(
                                key: UniqueKey(),
                                variant: ButtonVariant.PRIMARY,
                                label: Config.needsOtpVerification ? "Get OTP" : "Sign in",
                                onTap: (btn) async {
                                  btn.setBusy(true).setDisabled(true);
                                  await controller.submit();
                                  btn.setBusy(false).setDisabled(false);
                                },
                              ),
                              SizedBox(height: 10),
                              if (Config.acceptRegistration)
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: GestureDetector(
                                    onTap: () => Get.offNamed("/register"),
                                    child: Text.rich(
                                      TextSpan(
                                        text: "Don't have an account?",
                                        style: TextStyl.button?.copyWith(color: Theme.of(context).textTheme.bodyText1?.color),
                                        children: [
                                          TextSpan(
                                            text: " Sign up",
                                            style: TextStyl.button?.copyWith(color: kcPrimary.withOpacity(0.7)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                              SizedBox(height: 10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Or Continue with",
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: screen.height * 0.05,
                                    width: screen.width * 0.25,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: kcGray, width: 1.0),
                                      borderRadius: BorderRadius.all(Radius.circular(20.0) //                 <--- border radius here
                                          ),
                                    ),
                                    child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Image.asset(
                                          "assets/icons/facebook.png",
                                          color: kcDarkAlt,
                                        )),
                                  ),
                                  Container(
                                    height: screen.height * 0.05,
                                    width: screen.width * 0.25,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: kcGray, width: 1.0),
                                      borderRadius: BorderRadius.all(Radius.circular(20.0) //                 <--- border radius here
                                          ),
                                    ),
                                    child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Image.asset(
                                          "assets/icons/twitter.png",
                                          color: kcDarkAlt,
                                        )),
                                  ),
                                  Container(
                                    height: screen.height * 0.05,
                                    width: screen.width * 0.25,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: kcGray, width: 1.0),
                                      borderRadius: BorderRadius.all(Radius.circular(20.0) //                 <--- border radius here
                                          ),
                                    ),
                                    child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Image.asset(
                                          "assets/icons/linkedin.png",
                                          color: kcDarkAlt,
                                        )),
                                  ),
                                ],
                              ),

                              // if (Config.acceptRegistration)
                              //   GestureDetector(
                              //     onTap: () => Get.offNamed("/register"),
                              //     child: Text.rich(
                              //       TextSpan(
                              //         text: "Don't have an account?",
                              //         style: TextStyl.button?.copyWith(color: Theme.of(context).textTheme.bodyText1?.color),
                              //         children: [
                              //           TextSpan(
                              //             text: " Join Now",
                              //             style: TextStyl.button?.copyWith(color: Theme.of(context).primaryColor),
                              //           ),
                              //         ],
                              //       ),
                              //     ),
                              //   ),
                            ],
                          ),
                        ),

                        Column(
                          children: [
                            Text(
                              "Made in India",
                              style: TextStyle(color: kcDarkAlt, fontSize: 10),
                            ),
                            Text(
                              "v1.1",
                              style: TextStyle(color: kcDarkAlt, fontSize: 10),
                            ),
                          ],
                        )
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
