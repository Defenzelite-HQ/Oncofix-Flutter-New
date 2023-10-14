import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_x/ui_x.dart';
import 'package:oncofix/app/modules/Auth/AuthModule.dart';
import '../../../helpers/Global.dart';
import '../../../shared/views/layouts/AuthLayout.dart';
import '../../../shared/views/widgets/TabPillWidget.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screen = Get.size;

    return GetBuilder(
        init: LoginController(),
        builder: (LoginController controller) {
          return AuthLayout(
            backgroundColor: bodyBackgroundColor,
            body: SafeArea(
              child: SingleChildScrollView(
                child: GestureDetector(
                  onTap: () => Keyboard.hide(context),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                    color: Colors.transparent,
                    width: double.infinity,
                    height: screen.height,
                    child: ListView(
                      physics: PageScrollPhysics(),
                      // crossAxisAlignment: CrossAxisAlignment.stretch,
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // mainAxisSize: MainAxisSize.max,
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
                            Text(
                              "Welcome,",
                              style: TextStyl.title!
                                  .copyWith(fontWeight: FontWeight.w700),
                            ),
                            SizedBox(height: 5),
                            Text("Create an account to continue.",
                                style: TextStyl.body!
                                    .copyWith(fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Form(
                          key: controller.formKey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 15),
                              Text("Select Role.",
                                  style: TextStyl.body!
                                      .copyWith(fontWeight: FontWeight.bold)),
                              SizedBox(height: 5),
                              Obx(
                                () => Row(
                                  children: [
                                    TabPillWidget(
                                      label: "Patient",
                                      active:
                                          controller.selectedRole == "Patient",
                                      onTap: () =>
                                          controller.onSelectedRole("Patient"),
                                    ),
                                    TabPillWidget(
                                      label: "Doctor",
                                      active:
                                          controller.selectedRole == "Doctor",
                                      onTap: () =>
                                          controller.onSelectedRole("Doctor"),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 15),
                              Column(
                                children: [ 
                                  Obx(
                                    () => controller.selectedRole == "Patient"
                                        ? Column(
                                            children: [
                                              FormInput.text(
                                                controller:
                                                    controller.usernameInput,
                                                placeholder: "Name",
                                                leading:
                                                    Icon(Icons.person_outline),
                                                validator: (value) =>
                                                    Validator("Name", value!)
                                                        .required()
                                                        .validate(),
                                              ),
                                              SizedBox(height: 15),
                                              FormInput.email(
                                                controller:
                                                    controller.emailInput,
                                                placeholder: "Email",
                                                leading:
                                                    Icon(Icons.email_outlined),
                                                validator: (value) =>
                                                    Validator("Email", value!)
                                                        .email()
                                                        .required()
                                                        .validate(),
                                              ),
                                              SizedBox(height: 15),
                                              FormInput.number(
                                                controller:
                                                    controller.phoneInput,
                                                placeholder: "Phone",
                                                leading: Icon(Icons.phone),
                                                validator: (value) => Validator("Phone", value!).required().max(12).min(10).validate(),
                                                maxLength: 13,
                                              ),
                                              SizedBox(height: 15),
                                              FormInput.password(
                                                controller:
                                                    controller.passwordInput,
                                                placeholder: "Password",
                                                leading:
                                                    Icon(Icons.lock_outline),
                                                validator: (value) => Validator(
                                                        "Password", value!)
                                                    .required()
                                                    .validate(),
                                              ),
                                              SizedBox(height: 15),
                                              FormInput.password(
                                                controller: controller
                                                    .confirmPasswordInput,
                                                placeholder: "Confirm Password",
                                                leading: Icon(Icons
                                                    .visibility_off_outlined),
                                                validator: (value) => Validator(
                                                        "Confirm Password",
                                                        value!)
                                                    .required()
                                                    .validate(),
                                              ),
                                              SizedBox(height: 15),
                                              FormInput.email(
                                                controller: controller
                                                    .referralCodeInput,
                                                placeholder: "Referral Code",
                                                leading:
                                                    Icon(Icons.numbers_rounded),
                                              ),
                                              SizedBox(height: 15),
                                              Button.block(
                                                  key: UniqueKey(),
                                                  label: "Register",
                                                  onTap: (set) async {
                                                    set
                                                        .setBusy(true)
                                                        .setDisabled(true);
                                                    await controller.register();
                                                    set
                                                        .setBusy(false)
                                                        .setDisabled(false);
                                                  }),
                                            ],
                                          )
                                        : Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            SizedBox(height: 120),
                                            Text(
                                              "Due to heavy uses currently we temporary blocked Doctor onboarding\nPlease contact Oncofix customer desk for more information ",
                                              style: TextStyl.bodySm
                                              ?.copyWith(
                                                  fontWeight:
                                                      FontWeight.w500,
                                                  fontSize: 15,),textAlign: TextAlign.center,
                                            ),
                                            // Image.asset("assets/icons/alert.png", height: 40),
                                          ],
                                        ),
                                  )
                                ],
                              ),
                              SizedBox(height: 120),
                              Center(
                                child: GestureDetector(
                                  onTap: () => Get.offNamed(AuthRoutes.login),
                                  child: Text.rich(
                                    TextSpan(
                                      text: "Already have an account?",
                                      style: TextStyl.button?.copyWith(
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyText1
                                              ?.color),
                                      children: [
                                        TextSpan(
                                          text: " Login",
                                          style: TextStyl.button?.copyWith(
                                              color:
                                                  Theme.of(context).primaryColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 15),
                            ],
                          ),
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
