import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:oncofix/app/modules/Dashboard/controllers/DashboardController.dart';
import 'package:ui_x/helpers/ColorPalette.dart';
import 'package:ui_x/helpers/Sizes.dart';
import 'package:ui_x/helpers/TextStyl.dart';

import '../../../../config/Config.dart';
import '../../../helpers/Global.dart';
import '../../../helpers/Webview.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  final String route;

  BottomNavigationBarWidget({Key? key, required this.route, }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
              color: kcWhite,
              border: Border(
                top: BorderSide(color: kcBlack.withOpacity(0.05), width: 1),
              ),
            ),
            padding:
                EdgeInsets.symmetric(vertical: spacer2, horizontal: spacer1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.home,
                        color: route == 'home' ? kcBottomBar : kcSecondary,
                        size: spacer5,
                      ),
                      SizedBox(height: spacer1),
                      Text(
                        "Home",
                        style: TextStyl.title!.copyWith(
                            color: route == 'home' ? kcBottomBar : kcSecondary,
                            fontWeight: FontWeight.bold,
                            fontSize: spacer3),
                      ),
                    ],
                  ),
                  onTap: () {
                    Get.toNamed('/home');
                  },
                ),
                Config.isDoctor()
                    ? InkWell(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.person,
                              color: route == 'patient'
                                  ? kcBottomBar
                                  : kcSecondary,
                              size: spacer5,
                            ),
                            SizedBox(height: spacer1),
                            Text(
                              "Patient",
                              style: TextStyl.title!.copyWith(
                                  color: route == 'patient'
                                      ? kcBottomBar
                                      : kcSecondary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: spacer3),
                            ),
                          ],
                        ),
                        onTap: () {
                          webViewOnTap("patient");
                        },
                      )
                    : InkWell(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              "assets/icons/doctor.svg",
                              color: route == 'doctors'
                                  ? kcBottomBar
                                  : kcSecondary,
                              height: spacer5,
                            ),
                            // Icon(
                            //   Icons.medication,
                            //   color: route == 'my-appointments'
                            //       ? kcBottomBar
                            //       : kcSecondary,
                            //   size: spacer5,
                            // ),
                            SizedBox(height: spacer1),
                            Text(
                              "Doctor",
                              // "${Config.authRole}",
                              style: TextStyl.title!.copyWith(
                                  color: route == 'doctors'
                                      ? kcBottomBar
                                      : kcSecondary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: spacer3),
                            ),
                          ],
                        ),
                        onTap: () async {
                          Get.toNamed('/doctors');
                        },
                      ),
                Text(""),
                // InkWell(
                //   child: Column(
                //     mainAxisSize: MainAxisSize.min,
                //     children: [
                //       Icon(
                //         Icons.forum,
                //         color: route == 'forum' ? kcBottomBar : kcSecondary,
                //         size: spacer5,
                //       ),
                //       SizedBox(height: spacer1),
                //       Text(
                //         "EMR",
                //         style: TextStyl.title!.copyWith(
                //             color: route == 'forum' ? kcBottomBar : kcSecondary,
                //             fontWeight: FontWeight.bold,
                //             fontSize: spacer3),
                //       ),
                //     ],
                //   ),
                //   onTap: () {
                //     Get.toNamed('/webview', parameters: {
                //       "url": "https://oncofix.com/erm",
                //       "title": "EMR"
                //     });
                //   },
                // ),
                Config.isDoctor()
                    ? InkWell(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Image.asset("assets/icons/book-alt.png",
                            //   color: route == 'my-appointments'
                            //   ? kcBottomBar
                            //       : kcSecondary,
                            //   height: spacer5,
                            // ),

                            Icon(
                              Icons.medication,
                              color: route == 'my-appointments'
                                  ? kcBottomBar
                                  : kcSecondary,
                              size: spacer5,
                            ),
                            SizedBox(height: spacer1),
                            Text(
                              "Apts",
                              style: TextStyl.title!.copyWith(
                                  color: route == 'my-appointments'
                                      ? kcBottomBar
                                      : kcSecondary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: spacer3),
                            ),
                          ],
                        ),
                        onTap: () {
                          // Get.toNamed('/appointments');
                          webViewOnTap("doctor_appointments");
                        },
                      )
                    : InkWell(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              "assets/icons/cases.svg",
                              color:
                                  route == 'cases' ? kcBottomBar : kcSecondary,
                              height: spacer5,
                            ),
                            // Icon(
                            //   Icons.cases_outlined,
                            //   color: route == 'cases' ? kcBottomBar : kcBottomBarLight,
                            //   size: spacer5,
                            // ),
                            SizedBox(height: spacer1),
                            Text(
                              "Cases",
                              style: TextStyl.title!.copyWith(
                                  color: route == 'cases'
                                      ? kcBottomBar
                                      : kcSecondary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: spacer3),
                            ),
                          ],
                        ),
                        onTap: () {
                          Get.toNamed(
                            '/cases',
                          );
                        },
                      ),
                InkWell(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.menu,
                        color: route == 'more' ? kcBottomBar : kcSecondary,
                        size: spacer5,
                      ),
                      SizedBox(height: spacer1),
                      Text(
                        "More",
                        style: TextStyl.title!.copyWith(
                            color: route == 'more' ? kcBottomBar : kcSecondary,
                            fontWeight: FontWeight.bold,
                            fontSize: spacer3),
                      ),
                    ],
                  ),
                  onTap: () {
                    Get.bottomSheet(
                      SafeArea(
                        child: Container(
                          height: screen.height * 0.3,
                          decoration: new BoxDecoration(
                            color: kcWhite,
                            borderRadius: new BorderRadius.only(
                              topLeft: const Radius.circular(40.0),
                              topRight: const Radius.circular(40.0),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: ListView(
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    height: 5,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        color: kcGray,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                  ),
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                GestureDetector(
                                  child: Container(
                                    color: kcWhite,
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.pending_actions,
                                          color: kcSecondary,
                                          size: spacer5,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "My Appointments",
                                          style: TextStyl.title!.copyWith(
                                            color: kcSecondary,
                                            fontWeight: FontWeight.w500,
                                            fontSize: spacer4,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    Get.back();
                                    Get.toNamed('/my-appointments');
                                  },
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                GestureDetector(
                                  child: Container(
                                    color: kcWhite,
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.shopping_cart,
                                          color: kcSecondary,
                                          size: spacer5,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Orders",
                                          style: TextStyl.title!.copyWith(
                                            color: kcSecondary,
                                            fontWeight: FontWeight.w500,
                                            fontSize: spacer4,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    Get.back();
                                    Get.toNamed('/my-orders');
                                  },
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                GestureDetector(
                                  child: Container(
                                    color: kcWhite,
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.settings,
                                          color: kcSecondary,
                                          size: spacer5,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Settings",
                                          style: TextStyl.title!.copyWith(
                                            color: kcSecondary,
                                            fontWeight: FontWeight.w500,
                                            fontSize: spacer4,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    Get.back();
                                    Get.toNamed('/settings');
                                  },
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                GestureDetector(
                                  child: Container(
                                    color: kcWhite,
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.logout,
                                          color: kcSecondary,
                                          size: spacer5,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Logout",
                                          style: TextStyl.title!.copyWith(
                                            color: kcSecondary,
                                            fontWeight: FontWeight.w500,
                                            fontSize: spacer4,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  onTap: () => auth.logout(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      barrierColor: kcPrimaryLight.withOpacity(0.2),
                      isDismissible: true,
                      enableDrag: true,
                      isScrollControlled: true,
                      ignoreSafeArea: false,
                    );
                  },
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 28,
            child: Config.isDoctor()
                ? Container(
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                    child: new FloatingActionButton(
                      elevation: 20.0,
                      child: Icon(
                        Icons.qr_code_scanner_sharp,
                        size: 23,
                      ),
                      onPressed: () {
                            // controller.scanQR()
                      },
                    ),
                  )
                : Container(
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                    child: new FloatingActionButton(
                      elevation: 20.0,
                      child: CircleAvatar(
                        backgroundColor: kcPrimary,
                        backgroundImage: AssetImage("assets/icons/onco.png"),
                        radius: 45,
                      ),
                      onPressed: () => webViewOnTap("doctor_chat"),
                    ),
                  ),
          ),
        ]);
  }
}

