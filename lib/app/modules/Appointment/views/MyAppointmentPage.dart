import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_x/helpers/ColorPalette.dart';
import 'package:ui_x/helpers/Sizes.dart';
import 'package:oncofix/app/modules/Appointment/views/widgets/AppointmentCardWidget.dart';
import '../../../shared/views/layouts/MasterLayout.dart';
import '../../../shared/views/widgets/Loading.dart';
import '../controllers/MyAppointmentController.dart';
import '../models/AppointmentModel.dart';

class MyAppointmentPage extends StatelessWidget {
  final MyAppointmentController controller = Get.put(MyAppointmentController());

  @override
  Widget build(BuildContext context) {
    final Size screen = Get.size;
    return Obx(
      () => controller.isBusy
          ? Loading()
          : DefaultTabController(
              length: 2,
              child: MasterLayout(
                title: 'My Appointments',
                leading: IconButton(
                  icon: Icon(
                    Icons.west,
                    size: spacer7,
                  ),
                  onPressed: () {
                    Get.back();
                  },
                ),
                preferredSize: PreferredSize(
                  child: TabBar(
                    isScrollable: true,
                    unselectedLabelColor: kcOffWhite,
                    indicatorColor: kcWhite,
                    indicatorWeight: 3.0,
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: kcWhite,
                    tabs: [
                      Container(
                        width: screen.width / 3,
                        child: Tab(
                          child: Text('Upcoming'),
                        ),
                      ),
                      Container(
                        width: screen.width / 3,
                        child: Tab(
                          child: Text('Past'),
                        ),
                      ),
                    ],
                    onTap: (index) => controller.onTabChanged(index),
                  ),
                  preferredSize: Size.fromHeight(50.0),
                ),
                body: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    Obx(
                      () => controller.isLoading
                          ? Loading()
                          : controller.upcomingAppointments.length <= 0
                              ? Container(
                                  height: screen.height,
                                  child: Text("No data"),
                                  alignment: Alignment.center,
                                )
                              : SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      ...List.generate(
                                          controller.upcomingAppointments
                                              .length, (index) {
                                        MyAppointmentModel myAppointment =
                                            controller
                                                .upcomingAppointments[index];
                                        return AppointmentCardWidget(
                                          myAppointment: myAppointment,
                                          onTap: () {
                                            Get.toNamed('/message',
                                                parameters: {
                                                  "workstream_id": myAppointment
                                                      .id
                                                      .toString()
                                                });
                                          },
                                        );
                                      }),
                                    ],
                                  ),
                                ),
                    ),
                    Obx(
                      () => controller.isLoading
                          ? Loading()
                          : controller.pastAppointments.length <= 0
                              ? Container(
                                  height: screen.height,
                                  child: Text("No data"),
                                  alignment: Alignment.center,
                                )
                              : SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      ...List.generate(
                                          controller.pastAppointments.length,
                                          (index) {
                                        MyAppointmentModel myAppointment =
                                            controller.pastAppointments[index];
                                        return AppointmentCardWidget(
                                          myAppointment: myAppointment,
                                          onTap: () {
                                            Get.toNamed('/message',
                                                parameters: {
                                                  "appointment_id":
                                                      myAppointment.id
                                                          .toString()
                                                });
                                          },
                                        );
                                      }),
                                    ],
                                  ),
                                ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
