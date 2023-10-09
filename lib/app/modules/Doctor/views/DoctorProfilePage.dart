import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:oncofix/app/modules/Appointment/AppointmentModule.dart';
import 'package:ui_x/helpers/ColorPalette.dart';
import 'package:ui_x/helpers/Sizes.dart';
import 'package:ui_x/helpers/TextStyl.dart';
import 'package:ui_x/widgets/LoadingIcon.dart';
import 'package:ui_x/widgets/buttons/Button.dart';

import '../../../helpers/Global.dart';
import '../../../shared/views/layouts/MasterLayout.dart';
import '../../../shared/views/widgets/Loading.dart';
import '../../../shared/views/widgets/NoDataWidget.dart';
import '../controllers/DoctorShowController.dart';
import '../models/MeetingModel.dart';

class DoctorProfilePage extends StatelessWidget {
  final ShowDoctorController controller = Get.put(ShowDoctorController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => DefaultTabController(
        length: 3,
        child: MasterLayout(
          title: controller.isBusy
              ? LoadingIcon(
                  color: kcWhite,
                )
              : Text('${controller.showData.name ?? ""}'),
          leading: IconButton(
            icon: Icon(
              Icons.west,
              size: spacer7,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          body: controller.isBusy
              ? Loading()
              : controller.showData.id == null
                  ? Center(
                      child: Container(
                        child: Text("No data"),
                      ),
                    )
                  : SafeArea(
                      child: Container(
                        height: screen.height,
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                child: CircleAvatar(
                                  radius: 75,
                                  backgroundColor: Colors.grey[200],
                                  child: CircleAvatar(
                                    backgroundColor: kcWhite,
                                    backgroundImage: NetworkImage(
                                        "${controller.showData.avatar}"),
                                    radius: 75,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 50.0,
                              child: AppBar(
                                backgroundColor: kcWhite,
                                bottom: TabBar(
                                  isScrollable: true,
                                  unselectedLabelColor: kcSecondary,
                                  indicatorColor: kcPrimary,
                                  indicatorWeight: 3.0,
                                  indicatorSize: TabBarIndicatorSize.tab,
                                  labelColor: kcPrimary,
                                  tabs: [
                                    Container(
                                      width: screen.width / 4,
                                      child: Tab(
                                        text: 'Overview',
                                      ),
                                    ),
                                    Container(
                                      width: screen.width / 4,
                                      child: Tab(
                                        text: 'Event',
                                      ),
                                    ),
                                    Container(
                                      width: screen.width / 4,
                                      child: Tab(
                                        text: 'Feedback',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: TabBarView(
                                children: [
                                  SingleChildScrollView(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "About Me",
                                            style: TextStyl.title?.copyWith(
                                              fontSize: 16,
                                              color: kcDarkAlt,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          Text(
                                            "${controller.showData.bio ?? ""}",
                                            style: TextStyl.bodySm?.copyWith(
                                              fontSize: 14,
                                              color: kcSecondary,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                            "Specializations",
                                            style: TextStyl.title?.copyWith(
                                              fontSize: 16,
                                              color: kcDarkAlt,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.east,
                                                size: spacer4,
                                                color: kcSecondary,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                "${controller.showData.specializations ?? ""}",
                                                style:
                                                    TextStyl.bodySm?.copyWith(
                                                  fontSize: 14,
                                                  color: kcSecondary,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SingleChildScrollView(
                                    child: controller.meetings.length <= 0
                                        ? NoDataWidget(
                                            message: "No Events Yet!")
                                        : Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ...List.generate(
                                                  controller.meetings.length,
                                                  (index) {
                                                MeetingModel meeting =
                                                    controller.meetings[index];
                                                return Column(
                                                  children: [
                                                    Container(
                                                      color: kcWhite,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              12),
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Image.asset(
                                                                "assets/icons/loading-circular.gif",
                                                                width: 60,
                                                              ),
                                                              const SizedBox(
                                                                  width: 12),
                                                              Expanded(
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      "${meeting.name}",
                                                                      style: TextStyl.subtitle?.copyWith(
                                                                          fontSize:
                                                                              16,
                                                                          color:
                                                                              kcDark),
                                                                    ),
                                                                    Html(
                                                                      data:
                                                                          "${meeting.description}",
                                                                      style: {
                                                                        "p":
                                                                            Style(
                                                                          // margin: const EdgeInsets.all(0),
                                                                          lineHeight:
                                                                              LineHeight.percent(25),
                                                                          fontSize:
                                                                              FontSize.xSmall,
                                                                        ),
                                                                      },
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                              height: 8),
                                                          Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Icon(Icons
                                                                      .calendar_today_outlined),
                                                                  const SizedBox(
                                                                      width: 8),
                                                                  // Text(
                                                                  //   "${Jiffy(DateTime.parse(meeting.createdAt.toString())).format('MMM do, yyyy')}",
                                                                  //   style: TextStyl.bodySm,
                                                                  // ),
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Icon(Icons
                                                                      .schedule),
                                                                  const SizedBox(
                                                                      width: 8),
                                                                  // Text("${Jiffy(DateTime.parse(meeting.dateTime.toString())).format('hh:mm a')}"),
                                                                  //
                                                                ],
                                                              ),
                                                              Button.outline(
                                                                key:
                                                                    UniqueKey(),
                                                                label:
                                                                    "Join Now",
                                                                onTap: (set) {},
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    vertical: 4,
                                                                    horizontal:
                                                                        12),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    if (index !=
                                                        controller.meetings
                                                                .length -
                                                            1)
                                                      Divider(height: 1),
                                                  ],
                                                );
                                              }),
                                            ],
                                          ),
                                  ),
                                  SingleChildScrollView(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: controller.feedback.doctorId ==
                                              null
                                          ? NoDataWidget(
                                              message: "No Feedbacks Yet!")
                                          : Text(
                                              "${controller.feedback.feedback}",
                                              style: TextStyl.title!.copyWith(
                                                color: kcPrimary,
                                                fontWeight: FontWeight.w500,
                                                fontSize: spacer4,
                                              ),
                                            ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.all(16.0),
                            //   child: Column(
                            //     children: [
                            //       Button.outlineBlock(
                            //         label: 'Book Appointment',
                            //         labelStyle: TextStyl.body!.copyWith(
                            //           fontWeight: FontWeight.bold,
                            //           color: kcPrimary,
                            //         ),
                            //         onTap: () {
                            //           Get.toNamed('/appointments', parameters: {"user_id": controller.showData.id.toString()});
                            //         },
                            //       ),
                            //       SizedBox(
                            //         height: 15,
                            //       ),
                            //       Button.block(
                            //         label: 'Ask Second Opinion',
                            //         labelStyle: TextStyl.body!.copyWith(
                            //           fontWeight: FontWeight.bold,
                            //           color: kcWhite,
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    child: Container(
                                      height: 40,
                                      color: kcPrimary,
                                      child: Center(
                                          child: Text(
                                        "Book Appointment",
                                        style: TextStyl.bodySm
                                            ?.copyWith(color: kcWhite),
                                      )),
                                    ),
                                    onTap: () {
                                      Get.toNamed(AppointmentRoutes.appointment,
                                          parameters: {
                                            "doctor_id": controller.showData.id
                                                .toString()
                                          });
                                    },
                                  ),
                                ),
                                VerticalDivider(
                                  width: 1,
                                ),
                                Expanded(
                                  child: Container(
                                    height: 40,
                                    color: kcOffWhite,
                                    child: Center(
                                        child: Text("Ask Second Opinion")),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
        ),
      ),
    );
  }
}
