import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:oncofix/app/modules/Appointment/AppointmentModule.dart';
import 'package:oncofix/app/modules/Modules.dart';
import 'package:ui_x/helpers/ColorPalette.dart';
import 'package:ui_x/helpers/Sizes.dart';
import 'package:ui_x/helpers/TextStyl.dart';
import '../../../../config/Config.dart';
import '../../../helpers/Global.dart';
import '../../../helpers/Webview.dart';


class
BottomNavigationBarWidget extends StatelessWidget {
  final String route;

  BottomNavigationBarWidget({
    Key? key,
    required this.route,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<bool> showExitPopup() async {
      return await showDialog(
        context: context,
        builder: (context) => Dialog(
          backgroundColor: kcWhite,
          child: Container(
            padding: const EdgeInsets.symmetric(
                vertical: spacer8, horizontal: spacer)
                .copyWith(bottom: 4),
            decoration: BoxDecoration(
              color: kcWhite,
              borderRadius: BorderRadius.circular(spacer2),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Exit App",
                  style: TextStyl.subtitle?.copyWith(fontSize: 18),
                ),
                const SizedBox(height: spacer1),
                Text(
                  "Do you want to exit an App?",
                  style: TextStyl.bodySm?.copyWith(color: kcDarkAlt),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: spacer5),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.transparent),
                        child: Text(
                          "Cancel",
                          style:
                          TextStyl.button?.copyWith(color: kcDarkAlt),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                      ),
                    ),
                    const SizedBox(width: spacer3),
                    Expanded(
                      child: TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.transparent),
                        child: Text(
                          "Exit",
                          style: TextStyl.button?.copyWith(color: kcDanger),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ) ??
          false;
    }
    return WillPopScope(
        onWillPop: showExitPopup,
      child: Stack(
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
            EdgeInsets.symmetric(vertical: spacer3, horizontal: spacer1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                NavBarWidget(
                  active: "home",
                  onTap: () => Get.toNamed(DashboardRoutes.dashboard),
                  route: route,
                  image: "assets/icons/unfill_home.png",
                  fillImage: "assets/icons/fill_home.png",
                ),
                Config.isDoctor()
                    ? NavBarWidget(
                  active: "patient",
                  onTap: () => webViewOnTap("patient"),
                  route: route,
                  image: "assets/icons/myCases.png",
                  fillImage: "assets/icons/myCases.png",
                )
                    : NavBarWidget(
                  active: "doctors",
                  onTap: () => webViewOnTap("doctor_list"),
                  route: route,
                  image: "assets/icons/unfill_doctor.png",
                  fillImage: "assets/icons/fill_doctor.png",
                ),

                Text(""),
                Config.isDoctor()
                    ? NavBarWidget(
                  active: "my-appointments",
                  onTap: () => webViewOnTap("doctor_appointments"),
                  route: route,
                  image: "assets/icons/unfill_calendar-clock.png",
                  fillImage: "assets/icons/fill_calendar-clock.png",
                )
                    : NavBarWidget(
                  active: "cases",
                  onTap: () => webViewOnTap("my_cases"),
                  // onTap: () => Get.toNamed(
                  //   CasesRoutes.cases,
                  // ),
                  route: route,
                  image: "assets/icons/caseUnfill.png",
                  fillImage: "assets/icons/caseFill.png",
                ),
                InkWell(
                  child: Image.asset(
                    "assets/icons/user.png",
                    height: 25,
                    color: kcSecondary,
                  ),
                  onTap: () {
                    webViewOnTap('profile');
                  },
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 25,
            child: Config.isDoctor()
                ? new FloatingActionButton(
              elevation: 10.0,
              child: Icon(
                Icons.qr_code_scanner_sharp,
                size: 30,
              ),
              onPressed: () {
                final DashboardController dashboardController =
                Get.put(DashboardController());
                dashboardController.scanQR();
              },
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
        ]),
    );



  }
}

/// NavBar Widget

class NavBarWidget extends StatelessWidget {
  const NavBarWidget({
    super.key,
    required this.route,
    required this.active,
    required this.onTap,
    this.imageExtension = "png",
    this.image,
    this.iconData,
    this.fillIconData,
    this.fillImage,
  });

  final String route;
  final String active;
  final VoidCallback onTap;
  final String imageExtension;
  final String? image;
  final String? fillImage;
  final IconData? iconData;
  final IconData? fillIconData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: imageExtension == "icon"
          ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),
            child: Icon(
                route == active ? fillIconData : iconData,
                color: route == active ? kcBottomBar : kcSecondary,
                size: spacer5,
              ),
          )
          : imageExtension == "svg"
              ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                child: SvgPicture.asset(
                    route == active ? "$fillImage" : "$image",
                    color: route == active ? kcBottomBar : kcSecondary,
                    height: spacer5,
                  ),
              )
              : Padding(
                padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                child: Image.asset(
                            route == active ? "$fillImage" : "$image",
                            color: route == active ? kcBottomBar : kcSecondary,
                            height: spacer5,
                          ),
              ),
      onTap: onTap,
    );
  }
}

/// More Widget
class MoreWidget extends StatelessWidget {
  const MoreWidget({super.key, required this.route});

  final String route;

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
              height: screen.height * 0.25,
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
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
                        Get.toNamed(AppointmentRoutes.appointment,
                            parameters: {"doctor_id": auth.user.id.toString()});
                      },
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    // GestureDetector(
                    //   child: Container(
                    //     color: kcWhite,
                    //     child: Row(
                    //       children: [
                    //         Icon(
                    //           Icons.shopping_cart,
                    //           color: kcSecondary,
                    //           size: spacer5,
                    //         ),
                    //         SizedBox(
                    //           width: 10,
                    //         ),
                    //         Text(
                    //           "Orders",
                    //           style: TextStyl.title!.copyWith(
                    //             color: kcSecondary,
                    //             fontWeight: FontWeight.w500,
                    //             fontSize: spacer4,
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    //   onTap: () {
                    //     Get.back();
                    //     Get.toNamed('/my-orders');
                    //   },
                    // ),
                    // SizedBox(
                    //   height: 25,
                    // ),
                    GestureDetector(
                      child: Container(
                        color: kcWhite,
                        child: Row(
                          children: [
                            Icon(
                              Icons.person,
                              color: kcSecondary,
                              size: spacer5,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Profile",
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
                        Get.toNamed(SettingRoutes.setting);
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
    );
  }
}
