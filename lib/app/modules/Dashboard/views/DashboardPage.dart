import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:oncofix/app/modules/Dashboard/views/widget/HomeExploreCardWidget.dart';
import 'package:oncofix/app/modules/Doctor/DoctorModule.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:ui_x/ui_x.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../config/Config.dart';
import '../../../helpers/Global.dart';
import '../../../helpers/Webview.dart';
import '../../../models/CategoryElementModel.dart';
import '../../../shared/views/errors/NotConnectedErrorPage.dart';
import '../../../shared/views/layouts/MasterLayout.dart';
import '../../../shared/views/widgets/BottomNavigationBarWidget.dart';
import '../../../shared/views/widgets/LoadingIconWidget.dart';
import '../controllers/DashboardController.dart';
import '../models/FeaturedDoctorModel.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      init: DashboardController(),
      builder: (DashboardController controller) {
        return !controller.isConnected
            ? NotConnectedErrorPage()
            : controller.isBusy
                ? LoadingIconWidget(message: "Please wait...")
                : Obx(
                    () => controller.isBusy
                        ? LoadingIconWidget()
                        : MasterLayout(
                            title: Image.asset(
                              "assets/icons/oncofixlogo.png",
                              height: 28,
                            ),
                            leading: Builder(
                              builder: (context) => IconButton(
                                icon: Icon(
                                  Icons.notes,
                                  size: spacer7,
                                ),
                                onPressed: () =>
                                    Scaffold.of(context).openDrawer(),
                              ),
                            ),
                            action: [
                              Config.isDoctor()
                                  ? GestureDetector(
                                      onTap: () {
                                        webViewOnTap("search_patient");
                                      },
                                      child: Icon(
                                        Icons.search,
                                        size: spacer7,
                                      ))
                                  : SizedBox.shrink(),
                              SizedBox(
                                width: 15,
                              ),
                              GestureDetector(
                                  onTap: () {
                                    Get.toNamed('/notifications');
                                  },
                                  child: SvgPicture.asset(
                                      "assets/icons/bell.svg",
                                      height: spacer5,
                                      color: kcWhite)),
                              SizedBox(
                                width: 15,
                              ),
                              Config.isDoctor()
                                  ? Row(
                                      children: [
                                        GestureDetector(
                                            onTap: () {
                                              controller.scanQR();
                                            },
                                            child: Icon(
                                              Icons.qr_code_scanner_sharp,
                                              size: spacer6,
                                            )),
                                        SizedBox(
                                          width: 15,
                                        ),
                                      ],
                                    )
                                  : SizedBox.shrink()
                            ],

                            /// ++++++++++++++++++++++++++++++++++++
                            /// App Drawer Start
                            /// ++++++++++++++++++++++++++++++++++++
                            drawer: Drawer(
                              child: Obx(
                                () => Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Stack(
                                      children: [
                                        Image.asset(
                                          'assets/icons/oncofixbnr.jpg',
                                          width: double.infinity,
                                          height: 120,
                                          fit: BoxFit.cover,
                                        ),
                                        GestureDetector(
                                          child: Container(
                                            height: 200,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Container(height: 80),
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
                                                  child:
                                                      auth.user.avatar == null
                                                          ? Image.asset(
                                                              'assets/icons/dr6.jpg',
                                                              width: 50,
                                                              height: 50,
                                                              fit: BoxFit.cover,
                                                            )
                                                          : CircleAvatar(
                                                              backgroundColor:
                                                                  kcWhite,
                                                              backgroundImage:
                                                                  NetworkImage(
                                                                      "${auth.user.avatar}"),
                                                              radius: 35,
                                                            ),
                                                ),
                                                // CircleAvatar(
                                                //   radius: 32,
                                                //   backgroundColor: Colors.grey[200],
                                                //   child: CircleAvatar(
                                                //     backgroundColor: kcWhite,
                                                //     backgroundImage:
                                                //         NetworkImage("${auth.user.avatar}"),
                                                //     radius: 32,
                                                //   ),
                                                // ),
                                                Container(height: 2),
                                                Text(
                                                  "${auth.user.name}",
                                                  style: TextStyle(
                                                      color: kcSecondary,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                Text("${auth.user.email}",
                                                    style: TextStyle(
                                                        color: Colors
                                                            .blueGrey[800],
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 12))
                                              ],
                                            ),
                                          ),
                                          onTap: () {
                                            Get.offAndToNamed('/settings');
                                          },
                                        ),
                                      ],
                                    ),
                                    Config.isPatient()
                                        ? Obx(
                                            () => QrImageView(
                                              data: controller.qrcode,
                                              version: QrVersions.auto,
                                              size: 120,
                                              gapless: true,
                                              padding: EdgeInsets.only(
                                                  bottom: 10, top: 10),
                                            ),
                                          )
                                        : SizedBox.shrink(),
                                    Expanded(
                                      child: SingleChildScrollView(
                                        child: Container(
                                          color: kcWhite,
                                          child: Column(
                                            children: [
                                              GestureDetector(
                                                onTap: () =>
                                                    Navigator.of(context).pop(),
                                                child: Container(
                                                  width: double.maxFinite,
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 14,
                                                      horizontal: 24),
                                                  color: kcWhite,
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.home,
                                                        color: kcSecondary,
                                                        size: spacer5,
                                                      ),
                                                      SizedBox(width: 8),
                                                      Text(
                                                        'Home',
                                                        style: TextStyl.subtitle
                                                            ?.copyWith(
                                                                fontSize: 14,
                                                                color:
                                                                    kcSecondary),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),

                                              /// +++++++++++++++++++++++
                                              /// About Cancer
                                              /// +++++++++++++++++++++++
                                              GestureDetector(
                                                onTap: () => webViewOnTap(
                                                    "about_cancer"),
                                                child: Container(
                                                  width: double.maxFinite,
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 14,
                                                      horizontal: 24),
                                                  color: kcWhite,
                                                  child: Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                        "assets/icons/ribbon.svg",
                                                        height: spacer5,
                                                        color: kcSecondary,
                                                      ),
                                                      SizedBox(width: 8),
                                                      Text(
                                                        'About Cancer',
                                                        style: TextStyl.subtitle
                                                            ?.copyWith(
                                                                fontSize: 14,
                                                                color:
                                                                    kcSecondary),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),

                                              /// +++++++++++++++++++++++
                                              /// Financial Advice
                                              /// +++++++++++++++++++++++
                                              GestureDetector(
                                                onTap: () => webViewOnTap(
                                                    "financial_advice"),
                                                child: Container(
                                                  width: double.maxFinite,
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 14,
                                                      horizontal: 24),
                                                  color: kcWhite,
                                                  child: Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                        "assets/icons/advice.svg",
                                                        height: spacer5,
                                                        color: kcSecondary,
                                                      ),
                                                      SizedBox(width: 8),
                                                      Text(
                                                        'Financial Advices',
                                                        style: TextStyl.subtitle
                                                            ?.copyWith(
                                                                fontSize: 14,
                                                                color:
                                                                    kcSecondary),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),

                                              /// +++++++++++++++++++++++
                                              /// Consent Forms
                                              /// +++++++++++++++++++++++
                                              GestureDetector(
                                                onTap: () =>
                                                    Get.offAndToNamed("/about"),
                                                child: Container(
                                                  width: double.maxFinite,
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 14,
                                                      horizontal: 24),
                                                  color: kcWhite,
                                                  child: Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                        "assets/icons/blog.svg",
                                                        height: spacer5,
                                                        color: kcSecondary,
                                                      ),
                                                      SizedBox(width: 8),
                                                      Text(
                                                        'Consent Forms',
                                                        style: TextStyl.subtitle
                                                            ?.copyWith(
                                                                fontSize: 14,
                                                                color:
                                                                    kcSecondary),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),

                                              /// +++++++++++++++++++++++
                                              /// Refer & Earn
                                              /// +++++++++++++++++++++++
                                              GestureDetector(
                                                onTap: () => Get.offAndToNamed(
                                                    "/about-cancer"),
                                                child: Container(
                                                  width: double.maxFinite,
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 14,
                                                      horizontal: 24),
                                                  color: kcWhite,
                                                  child: Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                        "assets/icons/refer.svg",
                                                        height: spacer5,
                                                        color: kcSecondary,
                                                      ),
                                                      SizedBox(width: 8),
                                                      Text(
                                                        'Refer & Earn',
                                                        style: TextStyl.subtitle
                                                            ?.copyWith(
                                                                fontSize: 14,
                                                                color:
                                                                    kcSecondary),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),

                                              // GestureDetector(
                                              //   onTap: () => Get.offAndToNamed("/about-cancer"),
                                              //   child: Container(
                                              //     width: double.maxFinite,
                                              //     padding: const EdgeInsets.symmetric(
                                              //         vertical: 14, horizontal: 24),
                                              //     color: kcWhite,
                                              //     child: Row(
                                              //       children: [
                                              //         SvgPicture.asset("assets/icons/clip.svg",height: spacer5,color: kcSecondary,),
                                              //         SizedBox(width: 8),
                                              //         Text(
                                              //           'Attachments',
                                              //           style: TextStyl.subtitle(context)
                                              //               ?.copyWith(
                                              //                   fontSize: 14,
                                              //                   color: kcSecondary),
                                              //         ),
                                              //       ],
                                              //     ),
                                              //   ),
                                              // ),
                                              /// +++++++++++++++++++++++
                                              /// Doctors Recourse
                                              /// +++++++++++++++++++++++
                                              GestureDetector(
                                                onTap: () => webViewOnTap(
                                                    "doctors_recourse"),
                                                child: Container(
                                                  width: double.maxFinite,
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 14,
                                                      horizontal: 24),
                                                  color: kcWhite,
                                                  child: Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                        "assets/icons/doctor.svg",
                                                        height: spacer5,
                                                        color: kcSecondary,
                                                      ),
                                                      SizedBox(width: 8),
                                                      Text(
                                                        'Doctors Recourse',
                                                        style: TextStyl.subtitle
                                                            ?.copyWith(
                                                                fontSize: 14,
                                                                color:
                                                                    kcSecondary),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),

                                              /// +++++++++++++++++++++++
                                              /// Doctors Recourse
                                              /// +++++++++++++++++++++++
                                              GestureDetector(
                                                onTap: () =>
                                                    webViewOnTap("blogs"),
                                                child: Container(
                                                  width: double.maxFinite,
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 14,
                                                      horizontal: 24),
                                                  color: kcWhite,
                                                  child: Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                        "assets/icons/blog.svg",
                                                        height: spacer5,
                                                        color: kcSecondary,
                                                      ),
                                                      SizedBox(width: 8),
                                                      Text(
                                                        'Blogs',
                                                        style: TextStyl.subtitle
                                                            ?.copyWith(
                                                                fontSize: 14,
                                                                color:
                                                                    kcSecondary),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Divider(),
                                              GestureDetector(
                                                onTap: () =>
                                                    Get.toNamed("/about"),
                                                child: Container(
                                                  width: double.maxFinite,
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 14,
                                                      horizontal: 24),
                                                  color: kcWhite,
                                                  child: Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                        "assets/icons/info.svg",
                                                        height: spacer5,
                                                        color: kcSecondary,
                                                      ),
                                                      SizedBox(width: 8),
                                                      Text(
                                                        'About Oncofix',
                                                        style: TextStyl.subtitle
                                                            ?.copyWith(
                                                                fontSize: 14,
                                                                color:
                                                                    kcSecondary),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "OncoFix v1.1",
                                          style: TextStyl.bodySm?.copyWith(
                                            fontSize: spacer2,
                                            color: kcSecondary,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            /// ++++++++++++++++++++++++++++++++++++
                            /// Body Start
                            /// ++++++++++++++++++++++++++++++++++++
                            body: SingleChildScrollView(
                              child: Column(
                                children: [
                                  /// Search Location
                                  Config.isPatient()
                                      ? Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 2, horizontal: 10),
                                          decoration:
                                              BoxDecoration(color: kcTabBar),
                                          child: Row(
                                            children: [
                                              SvgPicture.asset(
                                                "assets/icons/marker.svg",
                                                height: 12,
                                                color: kcPrimaryLight,
                                              ),
                                              SizedBox(width: 5),
                                              Text(
                                                "Seoni, MadhyaPradesh",
                                                style: TextStyl.label!.copyWith(
                                                  color: kcWhite,
                                                  fontSize: spacer3 / 1.2,
                                                  fontWeight: FontWeight.w800,
                                                ),
                                              ),
                                              Spacer(),
                                              Text(
                                                "Change",
                                                style: TextStyl.label!.copyWith(
                                                  color:
                                                      kcWhite.withOpacity(0.8),
                                                  fontSize: spacer3 / 1.2,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      : SizedBox.shrink(),

                                  Container(
                                    height: 175,
                                    child: Swiper(
                                      autoplay: true,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return GestureDetector(
                                            child: Image.asset(
                                              Config.isPatient()
                                                  ? controller
                                                      .imageListPatient[index]
                                                  : controller
                                                      .imageListDoctor[index],
                                              width: double.maxFinite,
                                              fit: BoxFit.cover,
                                            ),
                                            onTap: () {
                                              switch (index) {
                                                case 1:
                                                  Get.toNamed(
                                                      DoctorRoutes.doctor);
                                                  break;
                                                case 2:
                                                  webViewOnTap("shop");
                                                  break;
                                              }
                                            });
                                      },
                                      itemCount: Config.isPatient()
                                          ? controller.imageListPatient.length
                                          : controller.imageListDoctor.length,
                                      autoplayDelay: 10000,
                                      viewportFraction: 1.0,
                                      scale: 1.0,
                                    ),
                                  ),

                                  Config.isDoctor()
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8, right: 8, top: 8),
                                          child: Row(
                                            children: [
                                              Flexible(
                                                child: HomeExploreCardWidget(
                                                  width: screen.width,
                                                  color:
                                                      kcInfo.withOpacity(0.08),
                                                  count:
                                                      "${auth.user.patients}",
                                                  label: "Total\nPatient",
                                                  maxLines: 2,
                                                  onTap: () {
                                                    webViewOnTap("patient");
                                                  },
                                                ),
                                              ),
                                              Flexible(
                                                child: HomeExploreCardWidget(
                                                  width: screen.width,
                                                  color: kcSuccess
                                                      .withOpacity(0.08),
                                                  count:
                                                      "${auth.user.todayAppointments}",
                                                  label: "Today\nAppointments",
                                                  maxLines: 2,
                                                  onTap: () {
                                                    webViewOnTap(
                                                        "clinical_trial");
                                                  },
                                                ),
                                              ),
                                              // Flexible(
                                              //   child: HomeExploreCardWidget(
                                              //     width: screen.width,
                                              //     count: "${auth.user.investigation}",
                                              //     color: kcWarning.withOpacity(0.08),
                                              //     label: "Total\nInvestigation",
                                              //     maxLines: 2,
                                              //     onTap: () {
                                              //       webViewOnTap("clinical_trial");
                                              //     },
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                        )
                                      : SizedBox.shrink(),

                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 8,
                                      right: 8,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Config.isDoctor()
                                            ? Column(
                                                children: [
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  InkWell(
                                                    onTap: () => webViewOnTap(
                                                        "oncofix_screening"),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      child: Image.asset(
                                                        "assets/icons/getstarted.jpg",
                                                        height: screen.height *
                                                            0.14,
                                                        fit: BoxFit.fill,
                                                        width: screen.width,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : SizedBox.shrink(),

                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 5, top: 8),
                                          child: Text(
                                            "Explore",
                                            style: TextStyl.title!.copyWith(
                                              color: kcSecondary,
                                              fontSize: spacer3,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Config.isPatient()
                                                ? Expanded(
                                                    child:
                                                        HomeExploreCardWidget(
                                                      image:
                                                          "assets/icons/case-report.png",
                                                      label: "My Cases",
                                                      onTap: () {
                                                        Get.toNamed('/cases');
                                                      },
                                                    ),
                                                  )
                                                : SizedBox.shrink(),
                                            Config.isDoctor()
                                                ? Expanded(
                                                    child:
                                                        HomeExploreCardWidget(
                                                      image:
                                                          "assets/icons/patient_attendance.png",
                                                      label: "Attendance",
                                                      onTap: () {
                                                        webViewOnTap(
                                                            "patient_attendance");
                                                      },
                                                    ),
                                                  )
                                                : SizedBox.shrink(),
                                            Config.isDoctor()
                                                ? Expanded(
                                                    child:
                                                        HomeExploreCardWidget(
                                                      image:
                                                          "assets/icons/health-report.png",
                                                      label: "Report",
                                                      onTap: () {
                                                        webViewOnTap("report");
                                                      },
                                                    ),
                                                  )
                                                : Expanded(
                                                    child:
                                                        HomeExploreCardWidget(
                                                      image:
                                                          "assets/icons/money-matters.png",
                                                      label: "Money Matter",
                                                      onTap: () {
                                                        webViewOnTap(
                                                            "money_matters");
                                                      },
                                                    ),
                                                  ),
                                            Expanded(
                                              child: HomeExploreCardWidget(
                                                image:
                                                    "assets/icons/events.png",
                                                label: "Events",
                                                onTap: () {
                                                  Config.isDoctor()
                                                      ? webViewOnTap(
                                                          "my_events")
                                                      : webViewOnTap("events");
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Config.isDoctor()
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Expanded(
                                                    child:
                                                        HomeExploreCardWidget(
                                                      image:
                                                          "assets/icons/report_pro.png",
                                                      label: "PRO",
                                                      onTap: () {
                                                        webViewOnTap(
                                                            "money_matters");
                                                      },
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child:
                                                        HomeExploreCardWidget(
                                                      image:
                                                          "assets/icons/clipboard.png",
                                                      label: "Tumour Board",
                                                      maxLines: 1,
                                                      onTap: () {
                                                        webViewOnTap(
                                                            "tumour_board_meetings");
                                                      },
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child:
                                                        HomeExploreCardWidget(
                                                      image:
                                                          "assets/icons/schedule.png",
                                                      label: "Schedules",
                                                      onTap: () {
                                                        webViewOnTap(
                                                            "my_schedule");
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : SizedBox.shrink(),

                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Expanded(
                                              child: HomeExploreCardWidget(
                                                image:
                                                    "assets/icons/clinical-trails.png",
                                                label: "Clinical Trials",
                                                onTap: () {
                                                  webViewOnTap(
                                                      "clinical_trial");
                                                },
                                              ),
                                            ),
                                            Expanded(
                                              child: HomeExploreCardWidget(
                                                image: "assets/icons/forum.png",
                                                label: "Support Group",
                                                onTap: () {
                                                  webViewOnTap("support_group");
                                                },
                                              ),
                                            ),
                                            Expanded(
                                              child: HomeExploreCardWidget(
                                                image: "assets/icons/risk.png",
                                                label: "Risk Assessment",
                                                onTap: () {
                                                  webViewOnTap(
                                                      "oncofix_screening");
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        Config.isPatient()
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Expanded(
                                                    child:
                                                        HomeExploreCardWidget(
                                                      image:
                                                          "assets/icons/schedule.png",
                                                      label: "Appointments",
                                                      onTap: () {
                                                        webViewOnTap(
                                                            "doctor_appointments");
                                                      },
                                                    ),
                                                  ),
                                                  Expanded(child: Text("")),
                                                  Expanded(child: Text("")),
                                                ],
                                              )
                                            : SizedBox.shrink(),

                                        /// Patient
                                        Config.isPatient()
                                            ? Column(
                                                children: [
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  InkWell(
                                                    onTap: () => webViewOnTap(
                                                        "oncofix_screening"),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      child: Image.asset(
                                                          "assets/icons/getstarted.jpg"),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 5),
                                                        child: Text(
                                                          "Categories",
                                                          style: TextStyl.title!
                                                              .copyWith(
                                                            color: kcSecondary,
                                                            fontSize: spacer3,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                      // InkWell(
                                                      //   child: Text(
                                                      //     "See All",
                                                      //     style: TextStyl.caption!.copyWith(
                                                      //       fontSize: spacer3,
                                                      //       fontWeight: FontWeight.w500,
                                                      //     ),
                                                      //   ),
                                                      //   onTap: () {
                                                      //     Get.toNamed('/categories');
                                                      //   },
                                                      // ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 110,
                                                    child: ListView.separated(
                                                        separatorBuilder:
                                                            (BuildContext
                                                                    context,
                                                                int index) {
                                                          return SizedBox(
                                                            width: 0,
                                                          );
                                                        },
                                                        shrinkWrap: true,
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        itemCount: controller
                                                            .categories.length,
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context,
                                                                int index) {
                                                          CategoryElementModel
                                                              category =
                                                              controller
                                                                      .categories[
                                                                  index];
                                                          return GestureDetector(
                                                            child: Container(
                                                              width: 122,
                                                              child: Card(
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            12.0)),
                                                                color: kcWhite,
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      ClipOval(
                                                                        child:
                                                                            Material(
                                                                          // color:
                                                                          //     kcPrimary, // Button color
                                                                          child:
                                                                              Image.network(
                                                                            "${category.icon}",
                                                                            height:
                                                                                45,
                                                                            width:
                                                                                45,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            5,
                                                                      ),
                                                                      Text(
                                                                        "${category.name}",
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        maxLines:
                                                                            1,
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: TextStyl
                                                                            .label!
                                                                            .copyWith(
                                                                          color:
                                                                              kcSecondary,
                                                                          fontSize:
                                                                              spacer4 / 1.2,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            onTap: () {
                                                              Get.toNamed(
                                                                  '/doctors',
                                                                  parameters: {
                                                                    "category_id":
                                                                        category
                                                                            .id
                                                                            .toString()
                                                                  });
                                                              final DoctorController
                                                                  doctorsController =
                                                                  Get.put(
                                                                      DoctorController());
                                                              // TODO: Filter Add To Add Doctor filter Method
                                                              // doctorsController
                                                              //     .getFilter();
                                                            },
                                                          );
                                                        }),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  if (controller.featuredDoctors
                                                          .length >
                                                      0)
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              "Featured Doctors",
                                                              style: TextStyl
                                                                  .title!
                                                                  .copyWith(
                                                                color:
                                                                    kcSecondary,
                                                                fontSize:
                                                                    spacer4,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            InkWell(
                                                              child: Text(
                                                                "See All",
                                                                style: TextStyl
                                                                    .caption!
                                                                    .copyWith(
                                                                  fontSize:
                                                                      spacer3,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                              onTap: () {
                                                                Get.toNamed(
                                                                    '/doctors');
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        SizedBox(
                                                          height: 180,
                                                          child: ListView
                                                              .separated(
                                                                  separatorBuilder:
                                                                      (BuildContext
                                                                              context,
                                                                          int
                                                                              index) {
                                                                    return SizedBox(
                                                                      width: 5,
                                                                    );
                                                                  },
                                                                  shrinkWrap:
                                                                      true,
                                                                  scrollDirection:
                                                                      Axis
                                                                          .horizontal,
                                                                  itemCount:
                                                                      controller
                                                                          .featuredDoctors
                                                                          .length,
                                                                  itemBuilder:
                                                                      (BuildContext
                                                                              context,
                                                                          int index) {
                                                                    FeaturedDoctorModel
                                                                        featuredDoctor =
                                                                        controller
                                                                            .featuredDoctors[index];
                                                                    return GestureDetector(
                                                                      child:
                                                                          Card(
                                                                        shape: RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(12.0)),
                                                                        color:
                                                                            kcWhite,
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Padding(
                                                                              padding: const EdgeInsets.all(12.0),
                                                                              child: Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Text("${featuredDoctor.name}", style: TextStyle(color: Color(0xff4c4c63), fontSize: 16, fontWeight: FontWeight.bold)),
                                                                                  Text(
                                                                                    "${featuredDoctor.category?.name}",
                                                                                    style: TextStyle(
                                                                                      color: Color(0xff595a6f),
                                                                                      fontSize: 12,
                                                                                      fontWeight: FontWeight.normal,
                                                                                    ),
                                                                                  ),
                                                                                  Spacer(),
                                                                                  featuredDoctor.rating == null
                                                                                      ? Text("No ratings yet!")
                                                                                      : RatingBar.builder(
                                                                                          itemSize: 12,
                                                                                          initialRating: featuredDoctor.rating ?? 0.0,
                                                                                          minRating: 1,
                                                                                          direction: Axis.horizontal,
                                                                                          allowHalfRating: true,
                                                                                          itemCount: 5,
                                                                                          itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                                                                                          itemBuilder: (context, _) => Icon(
                                                                                            Icons.star,
                                                                                            color: Colors.amber,
                                                                                          ),
                                                                                          onRatingUpdate: (rating) {
                                                                                            print(rating);
                                                                                          },
                                                                                        ),
                                                                                  Spacer(),
                                                                                  Text("Experience", style: TextStyle(color: Color(0xffc2c2ca), fontSize: 14, fontWeight: FontWeight.bold)),
                                                                                  Text("8 Years", style: TextStyle(color: Color(0xff595a6f), fontSize: 14, fontWeight: FontWeight.bold)),
                                                                                  Spacer(),
                                                                                  Text("Patient", style: TextStyle(color: Color(0xffc2c2ca), fontSize: 14, fontWeight: FontWeight.bold)),
                                                                                  Text("${featuredDoctor.patientCount}", style: TextStyle(color: Color(0xff595a6f), fontSize: 14, fontWeight: FontWeight.bold)),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: Column(
                                                                                children: [
                                                                                  ClipRRect(
                                                                                    borderRadius: BorderRadius.circular(8.0),
                                                                                    child: Image.network(
                                                                                      "${featuredDoctor.avatar}",
                                                                                      height: 150,
                                                                                      width: 100,
                                                                                      fit: BoxFit.cover,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      onTap:
                                                                          () {
                                                                        Get.toNamed(
                                                                            '/doctor-profile',
                                                                            parameters: {
                                                                              "doctor_id": featuredDoctor.id.toString()
                                                                            });
                                                                      },
                                                                    );
                                                                  }),
                                                        ),
                                                      ],
                                                    )
                                                ],
                                              )
                                            : SizedBox.shrink()
                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8, top: 8),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: InkWell(
                                            onTap: () => webViewOnTap("blogs"),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: Image.asset(
                                                "assets/icons/blog-banner.png",
                                                width: screen.width,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: InkWell(
                                            onTap: () => launchUrl(
                                                Uri.parse(
                                                    "https://www.youtube.com/channel/UCb24CCIAUNHbF9PAuAK9s7g"),
                                                mode: LaunchMode
                                                    .externalApplication),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: Image.asset(
                                                "assets/icons/youtube-banner.png",
                                                width: screen.width,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                            // floatingActionButton: Container(
                            //   height: 50,
                            //   width: 50,
                            //   decoration: BoxDecoration(
                            //     borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            //   ),
                            //   child: new FloatingActionButton(
                            //     elevation: 20.0,
                            //     child: CircleAvatar(
                            //       backgroundColor: kcPrimary,
                            //       backgroundImage: AssetImage("assets/icons/onco.png"),
                            //       radius: 25,
                            //     ),
                            //     onPressed: () =>
                            //         controller.appController.webViewOnTap("doctor_chat"),
                            //   ),
                            // ),
                            bottomNavigationBar: BottomNavigationBarWidget(
                              route: 'home',
                            ),
                          ),
                  );
      },
    );
  }
}
