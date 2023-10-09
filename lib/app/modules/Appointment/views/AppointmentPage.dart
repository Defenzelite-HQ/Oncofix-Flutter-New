import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ui_x/helpers/Sizes.dart';
import 'package:ui_x/widgets/LoadingIcon.dart';
import 'package:ui_x/widgets/buttons/Button.dart';
import '../../../shared/views/layouts/MasterLayout.dart';
import '../controllers/AppointmentController.dart';
import '../models/ScheduleModel.dart';

class AppointmentPage extends StatelessWidget {
  final AppointmentController controller = Get.put(AppointmentController());
  final DateFormat dateFormat = DateFormat("HH:mm");

  @override
  Widget build(BuildContext context) {
    final Size screen = Get.size;
    return MasterLayout(
      title: 'Appointment',
      leading: IconButton(
        icon: Icon(
          Icons.west,
          size: spacer7,
        ),
        onPressed: () {
          Get.back();
        },
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "Select your Date of Appointment",
                        style: TextStyle(
                          color: Color(0xff3B3D56),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Card(
                      color: Color(0xffffffff),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DatePicker(
                          DateTime.now(),
                          initialSelectedDate: DateTime.now(),
                          selectionColor: Color(0xff265ED7),
                          selectedTextColor: Color(0xffDFE8F9),
                          onDateChange: (date) {
                            controller.onDateSelect(date);
                          },
                          height: 90,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "Available Slots",
                        style: TextStyle(
                          color: Color(0xff3B3D56),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    controller.isBusy
                        ? Center(
                            child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 72),
                                child: LoadingIcon()))
                        : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Wrap(
                              direction: Axis.horizontal,
                              spacing: 4,
                              children: [
                                ...List.generate(controller.schedules.length,
                                    (index) {
                                  ScheduleModel schedule =
                                      controller.schedules[index];
                                  return Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 4),
                                    child: Container(
                                      height: 35,
                                      child: schedule.booked!
                                          ? Opacity(
                                              opacity: 0.3,
                                              child: Button.danger(
                                                key: UniqueKey(),
                                                label: "${schedule.startTime}",
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 8,
                                                        horizontal: 16),
                                              ),
                                            )
                                          : controller.selectedStartTime ==
                                                  schedule.startTime
                                              ? Button.success(
                                                  key: UniqueKey(),
                                                  label:
                                                      "${schedule.startTime}",
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 8,
                                                      horizontal: 16),
                                                  onTap: (set) {
                                                    if (!schedule.booked!)
                                                      controller
                                                          .onTimeDeselect();
                                                  })
                                              : Button.light(
                                                  key: UniqueKey(),
                                                  label:
                                                      "${schedule.startTime}",
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 8,
                                                      horizontal: 16),
                                                  onTap: (set) {
                                                    if (!schedule.booked!)
                                                      controller.onTimeSelect(
                                                          schedule.startTime!,
                                                          schedule.endTime!);
                                                  },
                                                ),
                                    ),
                                  );
                                }),
                              ],
                            ),
                          ),
                    // Expanded(
                    //   child: ListView.separated(
                    //     separatorBuilder: (context, int) {
                    //       return Divider(
                    //         color: kcWhite,
                    //       );
                    //     },
                    //     // shrinkWrap: true,
                    //     itemBuilder: (BuildContext context, int index) {
                    //       ScheduleModel schedule =
                    //       controller.schedules[index];
                    //       return GridView.count(
                    //         shrinkWrap: true,
                    //         crossAxisCount: 2,
                    //         childAspectRatio: 3.0,
                    //         children: List.generate(
                    //             controller.schedules.length, (index) {
                    //           return Center(
                    //             child: Container(
                    //               height: 35.0.h,
                    //               child: ElevatedButton(
                    //                 onPressed: () {},
                    //                 child: Text(
                    //                   '${schedule.startTime} - ${schedule.endTime}',
                    //                   style: TextStyle(
                    //                     fontWeight: FontWeight.bold,
                    //                   ),
                    //                 ),
                    //                 style: ButtonStyle(
                    //                   foregroundColor:
                    //                   MaterialStateProperty
                    //                       .resolveWith<Color>(
                    //                         (Set<MaterialState> states) {
                    //                       if (states.contains(
                    //                           MaterialState.pressed))
                    //                         return Color(0xffffffff);
                    //                       return Color(
                    //                           0xff3B3D56); // Use the component's default.
                    //                     },
                    //                   ),
                    //                   backgroundColor:
                    //                   MaterialStateProperty
                    //                       .resolveWith<Color>(
                    //                         (Set<MaterialState> states) {
                    //                       if (states.contains(
                    //                           MaterialState.pressed))
                    //                         return Color(0xff265ed7);
                    //                       return Color(
                    //                           0xffffffff); // Use the component's default.
                    //                     },
                    //                   ),
                    //                 ),
                    //               ),
                    //             ),
                    //           );
                    //         }),
                    //       );
                    //     },
                    //     itemCount: controller.schedules.length,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Button.block(
              key: UniqueKey(),
              label: 'Confirm Appointment',
              onTap: (set) async {
                set.setBusy(true).setDisabled(true);
                await controller.bookAppointment();
                set.setBusy(false).setDisabled(false);
              },
            ),
          ),
        ],
      ),
    );
  }
}
