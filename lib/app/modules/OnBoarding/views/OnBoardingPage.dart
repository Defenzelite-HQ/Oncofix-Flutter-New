import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:ui_x/ui_x.dart';

import '../../../helpers/Global.dart';
import '../../../shared/views/errors/NotConnectedErrorPage.dart';
import '../../../shared/views/layouts/MasterLayout.dart';
import '../../../shared/views/widgets/LoadingIconWidget.dart';
import '../controllers/OnBoardingController.dart';

class OnBoardingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnBoardingController>(
      init: OnBoardingController(),
      builder: (OnBoardingController controller) {
        return !controller.isConnected
            ? NotConnectedErrorPage()
            : controller.isBusy
                ? LoadingIconWidget(message: "Please wait...")
                : SafeArea(
                    child: Scaffold(
                      backgroundColor: bodyBackgroundColor,
                      body: SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 30, horizontal: 30),
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
                                  Text(
                                      "One Stop solution for all your cancer related needs !",
                                      style: TextStyl.title!.copyWith(
                                        fontWeight: FontWeight.w700,
                                        fontSize: spacer6,
                                      )),
                                  SizedBox(height: 25),
                                  Text("How it works !",
                                      style: TextStyl.body!.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: kcBlue.withOpacity(0.5),
                                      )),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Html(
                                    data:
                                        '<iframe width="560" height="250" src="https://www.youtube.com/embed/kOuUHSdpmvM" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>',
                                  ),
                                  // GestureDetector(
                                  //   child: Image.asset(
                                  //     "assets/icons/works2.jpg",
                                  //   ),
                                  //   onTap: () {
                                  //     playVideo;
                                  //   },
                                  // ),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  Button.block(
                                      key: UniqueKey(),
                                      label: 'Get Started',
                                      onTap: (set) async {
                                        set.setBusy(true).setDisabled(true);
                                        await controller.onGetStarted();
                                        set.setBusy(false).setDisabled(false);
                                      }),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
      },
    );
  }
}
