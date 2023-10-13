import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_x/ui_x.dart';
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
            backgroundColor: bodyBackgroundColor,
            body: Obx(
                ()=> SafeArea(
                child: SingleChildScrollView(
                  child: GestureDetector(
                    onTap: () => Keyboard.hide(context),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                      color: Colors.transparent,
                      width: double.infinity,
                      height: screen.height - 55,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 60),
                              Container(
                                child: Image.asset(
                                  image('logo.png'),
                                  height: 50,
                                ),
                              ),
                              SizedBox(height: 15),
                              Text("Welcome Back,",
                                  style: TextStyl.title!
                                      .copyWith(fontWeight: FontWeight.w700)),
                              SizedBox(height: 5),
                              Text("Sign in to continue",
                                  style: TextStyl.body!
                                      .copyWith(fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Form(
                            key: controller.formKey,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            child: Column(
                              children: [
                                if (controller.hide)
                                FormInput.email(
                                  controller: controller.emailInput,
                                  placeholder: "Email",
                                  leading: Icon(Icons.person_outline),
                                  validator: (value) => Validator("email", value!)
                                      .email()
                                      .required()
                                      .validate(),
                                ),
                                SizedBox(height: 25),
                                if (controller.hide)
                                FormInput.password(
                                  controller: controller.passwordInput,
                                  placeholder: "Password",
                                  leading: Icon(Icons.lock_outline),
                                  validator: (value) =>
                                      Validator("password", value!)
                                          .required()
                                          .validate(),
                                ),
                                if (controller.show)
                                  FormInput.number(
                                    // controller: controller.phoneNumberInput,
                                    // focusNode: controller.passwordFocusNode,
                                    placeholder: "Phone Number",
                                    leading: Icon(Icons.phone),
                                    validator: (value) => Validator("Phone", value!).required().max(12).min(10).validate(),
                                    maxLength: 13,
                                    action: TextInputAction.done,
                                  ),
                                SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        controller.hide ? controller.onHide(false) : controller.onHide(true);
                                        controller.show ? controller.onShow(false) : controller.onShow(true);
                                      },
                                      child: Text.rich(
                                        TextSpan(
                                          text: "Login with ",
                                          style: TextStyl.button?.copyWith(color: Theme.of(context).primaryColor),
                                          children: [
                                            TextSpan(
                                              text: controller.show ? "Password" : "Mobile Number",
                                              style: TextStyl.button?.copyWith(color: Theme.of(context).primaryColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 15),
                                if (controller.hide)
                                Button.block(
                                    key: UniqueKey(),
                                    label: "Login",
                                    onTap: (set) async {
                                      set.setBusy(true).setDisabled(true);
                                      await controller.submit();
                                      set.setBusy(false).setDisabled(false);
                                    }),
                                if (controller.show)
                                Button.block(
                                    key: UniqueKey(),
                                    label: "Continue",
                                    onTap: (set) async {
                                      set.setBusy(true).setDisabled(true);
                                      Get.toNamed(AuthRoutes.verifyOtp);
                                      set.setBusy(false).setDisabled(false);
                                    }),
                                SizedBox(height: 16),
                                GestureDetector(
                                  onTap: () => Get.offNamed(AuthRoutes.register),
                                  child: Text.rich(
                                    TextSpan(
                                      text: "Don't have an account?",
                                      style: TextStyl.button?.copyWith(
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyText1
                                              ?.color),
                                      children: [
                                        TextSpan(
                                          text: " Join Now",
                                          style: TextStyl.button?.copyWith(
                                              color:
                                                  Theme.of(context).primaryColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
