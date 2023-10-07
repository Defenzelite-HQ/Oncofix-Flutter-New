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
            body: SafeArea(
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
                              FormInput.password(
                                controller: controller.passwordInput,
                                placeholder: "Password",
                                leading: Icon(Icons.lock_outline),
                                validator: (value) =>
                                    Validator("password", value!)
                                        .required()
                                        .validate(),
                              ),
                              SizedBox(height: 25),
                            Button.block(
                                    key: UniqueKey(),
                                    label: "Login",
                                    onTap: (set) {
                                      set.setBusy(true).setDisabled(true);
                                      controller.submit();
                                      set.setBusy(false).setDisabled(false);
                                    }),
                              SizedBox(height: 16),
                              GestureDetector(
                                onTap: () => Get.offNamed(AuthRoutes.register),
                                child: Text.rich(
                                  TextSpan(
                                    text: "Don't have an account?",
                                    style: TextStyl.button
                                        ?.copyWith(color: Theme.of(context)
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
          );
        });
  }
}
