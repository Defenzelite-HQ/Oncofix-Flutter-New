import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:ui_x/helpers/ColorPalette.dart';
import 'package:ui_x/helpers/Sizes.dart';
import 'package:ui_x/helpers/TextStyl.dart';

import '../../../app/modules/Appointment/models/AppointmentModel.dart';

class AppointmentCardWidget extends StatelessWidget {
  const AppointmentCardWidget(
      {Key? key, required this.myAppointment, required this.onTap})
      : super(key: key);
  final MyAppointmentModel myAppointment;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    Size screen = Get.size;

    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        color: kcWhite,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (myAppointment.doctor?.avatar != "" &&
                  myAppointment.doctor?.avatar != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    '${myAppointment.doctor?.avatar}',
                    width: 90,
                    height: 90,
                    fit: BoxFit.cover,
                  ),
                ),
              SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (myAppointment.doctor?.name != "" &&
                      myAppointment.doctor?.name != null)
                    Text(
                      "${myAppointment.doctor?.name}",
                      style: TextStyl.title?.copyWith(
                        fontSize: 14,
                        color: kcSecondary,
                      ),
                    ),
                  if (myAppointment.doctor?.specializations != "" &&
                      myAppointment.doctor?.specializations != null)
                    Text(
                      "${myAppointment.doctor?.specializations}",
                      style: TextStyl.caption?.copyWith(
                        fontSize: spacer3,
                      ),
                    ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.date_range,
                        size: spacer4,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "${Jiffy(DateTime.parse(myAppointment.dateTime!).toString()).format('MMM do, yyyy')}",
                        style: TextStyl.title?.copyWith(
                          fontSize: spacer3,
                          color: kcSecondary,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.schedule,
                        size: spacer4,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "${Jiffy(DateTime.parse(myAppointment.dateTime!).toString()).format('hh:mm a')} - ${Jiffy(DateTime.parse(myAppointment.dateEndTime!).toString()).format('hh:mm a')}",
                        style: TextStyl.title?.copyWith(
                          fontSize: spacer3,
                          color: kcSecondary,
                        ),
                      ),
                      myAppointment.appointmentType == "1"
                          ? SizedBox(
                              width: screen.width * 0.25,
                            )
                          : SizedBox(
                              width: screen.width * 0.2,
                            ),
                      Container(
                        height: 25.0,
                        // width: double.infinity,
                        child: myAppointment.appointmentType == "1"
                            ? ElevatedButton(
                                onPressed: () {},
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 12.0,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xffe95150),
                                  onPrimary: Color(0xffDFE8F9),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        3.0), // <-- Radius
                                  ),
                                ),
                              )
                            : ElevatedButton(
                                onPressed: () {},
                                child: Text(
                                  'Reschedule',
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 12.0,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: kcInfo,
                                  onPrimary: Color(0xffDFE8F9),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        3.0), // <-- Radius
                                  ),
                                ),
                              ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
