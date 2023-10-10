import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:oncofix/app/modules/Dashboard/views/widget/HomeExploreCardWidget.dart';
import 'package:oncofix/app/modules/Doctor/DoctorModule.dart';
import 'package:oncofix/app/modules/Modules.dart';
import 'package:ui_x/ui_x.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../config/Config.dart';
import '../../../helpers/Global.dart';
import '../../../helpers/Webview.dart';
import '../../../models/CategoryElementModel.dart';
import '../../../shared/views/errors/NotConnectedErrorPage.dart';
import '../../../shared/views/layouts/MasterLayout.dart';
import '../../../shared/views/widgets/AppDrawer.dart';
import '../../../shared/views/widgets/BottomNavigationBarWidget.dart';
import '../../../shared/views/widgets/LoadingIconWidget.dart';
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
                              SizedBox(
                                width: 15,
                              ),
                              GestureDetector(
                                  onTap: () {
                                    webViewOnTap("notification_doctor");
                                    // Get.toNamed(
                                    //
                                    //     NotificationRoutes.notification);
                                  },
                                  child: SvgPicture.asset(
                                      "assets/icons/bell.svg",
                                      height: spacer5,
                                      color: kcWhite)),
                              SizedBox(
                                width: 15,
                              ),
                              // Config.isDoctor()
                              //     ? Row(
                              //         children: [
                              //           GestureDetector(
                              //               onTap: () =>
                              //                   webViewOnTap("add_patient"),
                              //               child: Icon(
                              //                 Icons.person_add,
                              //                 size: 23,
                              //               )),
                              //           SizedBox(
                              //             width: 15,
                              //           ),
                              //         ],
                              //       )
                              //     : SizedBox.shrink(),
                              Config.isDoctor()
                                  ? GestureDetector(
                                      onTap: () {
                                        webViewOnTap("search_patient");
                                      },
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Icon(
                                          Icons.search,
                                          size: spacer7,
                                        ),
                                      ),
                                    )
                                  : SizedBox.shrink(),
                            ],

                            /// ++++++++++++++++++++++++++++++++++++
                            /// App Drawer Start
                            /// ++++++++++++++++++++++++++++++++++++
                            drawer: appDrawer(context, controller),

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
                                                "Seoni, Madhya Pradesh",
                                                // "${controller.locationData.currentLocation?.address}",
                                                style: TextStyl.label!.copyWith(
                                                  color: kcWhite,
                                                  fontSize: spacer3 / 1.2,
                                                  fontWeight: FontWeight.w800,
                                                ),
                                              ),
                                              Spacer(),
                                              GestureDetector(
                                                onTap:  () {
                                                  webViewOnTap(
                                                      "doctor_profile");
                                                },
                                                child: Text(
                                                  "Change",
                                                  style: TextStyl.label!.copyWith(
                                                    color:
                                                        kcWhite.withOpacity(0.8),
                                                    fontSize: spacer3 / 1.2,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      : SizedBox.shrink(),
                                  Config.isPatient()
                                      ? Container(
                                          height: 175,
                                          child: Swiper(
                                            autoplay: true,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              Map<String, String> slider =
                                                  controller
                                                      .imageListPatient[index];
                                              return GestureDetector(
                                                  child: Image.asset(
                                                    "${slider["image"]}",
                                                    width: double.maxFinite,
                                                    fit: BoxFit.cover,
                                                  ),
                                                  onTap: () {
                                                    webViewOnTap(
                                                        "${slider["id"]}");
                                                  });
                                            },
                                            itemCount: controller
                                                .imageListPatient.length,
                                            autoplayDelay: 10000,
                                            viewportFraction: 1.0,
                                            scale: 1.0,
                                          ),
                                        )
                                      : Container(
                                          height: 175,
                                          child: Swiper(
                                            autoplay: true,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              Map<String, String> slider =
                                                  controller
                                                      .imageListDoctor[index];
                                              return GestureDetector(
                                                  child: Image.asset(
                                                    "${slider["image"]}",
                                                    width: double.maxFinite,
                                                    fit: BoxFit.cover,
                                                  ),
                                                  onTap: () {
                                                    webViewOnTap(
                                                        "${slider["id"]}");
                                                  });
                                            },
                                            itemCount: controller
                                                .imageListDoctor.length,
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
                                                  label: "Total\nPatients",
                                                  maxLines: 2,
                                                  onTap: () {
                                                    webViewOnTap("patient");
                                                  },
                                                ),
                                              ),
                                              Flexible(
                                                child: HomeExploreCardWidget(
                                                  width: screen.width,
                                                  color: kcAccent
                                                      .withOpacity(0.08),
                                                  count:
                                                      "${auth.user.todayAppointments}",
                                                  label:
                                                      "Today's\nAppointments",
                                                  maxLines: 2,
                                                  onTap: () {
                                                    webViewOnTap(
                                                        "today_appointments");
                                                  },
                                                ),
                                              ),
                                              Flexible(
                                                  child: GestureDetector(
                                                child: Container(
                                                  margin:
                                                      const EdgeInsets.all(3.0),
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 15,
                                                      vertical: 6),
                                                  decoration: BoxDecoration(
                                                    color: kcSuccess
                                                        .withOpacity(0.08),
                                                    // border: Border.all(
                                                    //   color: kcGray
                                                    //       .withOpacity(0.5),
                                                    // ),
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(
                                                            6.0) //                 <--- border radius here
                                                        ),
                                                  ),
                                                  width: screen.width,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons.person_add,
                                                          size: 22,
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          "Add\nPatient",
                                                          style: TextStyl.label!
                                                              .copyWith(
                                                                  color:
                                                                      kcSecondary,
                                                                  fontSize:
                                                                      spacer4 /
                                                                          1.3,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis),
                                                          textAlign:
                                                              TextAlign.center,
                                                          maxLines: 2,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                onTap: () =>
                                                    webViewOnTap("add_patient"),
                                              )),
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
                                        Config.isPatient()
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Expanded(
                                                    child:
                                                        HomeExploreCardWidget(
                                                      imageColor: kcDeepOrange,
                                                      image:
                                                          "assets/icons/myCases.png",
                                                      label: "My Cases",
                                                      onTap: () {
                                                        webViewOnTap(
                                                            "my_cases");
                                                      },
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child:
                                                        HomeExploreCardWidget(
                                                      imageColor: kcPurple,
                                                      image:
                                                          "assets/icons/unfill_calendar-clock.png",
                                                      label: "Appointments",
                                                      onTap: () {
                                                        webViewOnTap(
                                                            "doctor_appointments");
                                                      },
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child:
                                                        HomeExploreCardWidget(
                                                      imageColor: kcBrown,
                                                      image:
                                                          "assets/icons/pro.png",
                                                      label: "PRO",
                                                      onTap: () {
                                                        webViewOnTap(
                                                            "patient_pro");
                                                      },
                                                    ),
                                                  )
                                                ],
                                              )
                                            : Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Expanded(
                                                        child:
                                                            HomeExploreCardWidget(
                                                          imageColor: kcInfo,
                                                          image:
                                                              "assets/icons/my_patient.png",
                                                          label: "My Patients",
                                                          onTap: () {
                                                            webViewOnTap(
                                                                'patient');
                                                          },
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child:
                                                            HomeExploreCardWidget(
                                                          imageColor: kcSuccess,
                                                          image:
                                                              "assets/icons/attendance.png",
                                                          label: "Attendance",
                                                          onTap: () {
                                                            webViewOnTap(
                                                                "patient_attendance");
                                                          },
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child:
                                                            HomeExploreCardWidget(
                                                          imageColor: kcPurple,
                                                          image:
                                                              "assets/icons/tumour_board.png",
                                                          label: "Tumour Board",
                                                          maxLines: 1,
                                                          onTap: () {
                                                            webViewOnTap(
                                                                "tumour_board_meetings");
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Expanded(
                                                        child:
                                                            HomeExploreCardWidget(
                                                          imageColor:
                                                              kcDeepPurple,
                                                          image:
                                                              "assets/icons/become_host.png",
                                                          label: "Become Host",
                                                          onTap: () {
                                                            webViewOnTap(
                                                                "my_events");
                                                          },
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child:
                                                            HomeExploreCardWidget(
                                                          imageColor:
                                                              kcDeepOrange,
                                                          image:
                                                              "assets/icons/report.png",
                                                          label: "Report",
                                                          onTap: () {
                                                            webViewOnTap(
                                                                "report");
                                                          },
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child:
                                                            HomeExploreCardWidget(
                                                          imageColor: kcBrown,
                                                          image:
                                                              "assets/icons/pro.png",
                                                          label: "PRO",
                                                          onTap: () {
                                                            Config.isDoctor()
                                                                ? webViewOnTap(
                                                                    "doctor_pro")
                                                                : webViewOnTap(
                                                                    "patient_pro");
                                                          },
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
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
                                                          "Find doctor by cause",
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
                                                                  DoctorRoutes
                                                                      .doctor,
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
                                                                    DoctorRoutes
                                                                        .doctor);
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
                                                                            DoctorRoutes.doctorProfile,
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
                                  Config.isPatient() ?
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
                                  )
                                    : SizedBox.shrink(),
                                  Config.isDoctor() ?
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
                                                "assets/icons/small-bnr1.jpg",
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
                                                "assets/icons/small-bnr2.jpg",
                                                width: screen.width,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ) : SizedBox.shrink()
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
