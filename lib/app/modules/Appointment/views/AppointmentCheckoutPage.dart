import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_x/helpers/ColorPalette.dart';
import 'package:ui_x/helpers/Sizes.dart';
import 'package:ui_x/helpers/TextStyl.dart';
import 'package:ui_x/widgets/buttons/Button.dart';

import '../../../shared/views/layouts/MasterLayout.dart';
import '../controllers/AppointmentCheckoutController.dart';

class AppointmentCheckoutPage extends StatelessWidget {
  final AppointmentCheckoutController controller = Get.put(AppointmentCheckoutController());

  @override
  Widget build(BuildContext context) {
    final Size screen = Get.size;
    return MasterLayout(
      title: 'Checkout',
      leading: IconButton(
        icon: Icon(
          Icons.west,
          size: spacer7,
        ),
        onPressed: () {
          Get.back();
        },
      ),
      body: Obx(() => Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Image.network(
                            '${controller.appointment.doctor?.avatar}',
                            width: Get.size.width,
                            height: 250,
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                          ),
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    kcBlack.withOpacity(0),
                                    kcBlack.withOpacity(1),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                              decoration: BoxDecoration(),
                              width: screen.width,
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: screen.width,
                                    child: Text(
                                      "${controller.appointment.doctor?.name}",
                                      style: TextStyl.subtitle?.copyWith(
                                        color: kcOffWhite,
                                      ),
                                    ),
                                  ),
                                  // const SizedBox(height: 2),
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.start,
                                  //   children: [
                                  //     Text(
                                  //       "Demo",
                                  //       style: TextStyl.caption(context)?.copyWith(
                                  //         fontSize: spacer3,
                                  //         color: kcGray,
                                  //       ),
                                  //     ),
                                  //     const SizedBox(width: 12),
                                  //     Text(
                                  //       "Year: ${Jiffy(DateTime.now()).format('yyyy')}",
                                  //       style: TextStyl.caption(context)?.copyWith(
                                  //         fontSize: spacer3,
                                  //         color: kcGray,
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: screen.width,
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        decoration: BoxDecoration(
                          color: kcWhite,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Appointment information",
                              style: TextStyl.body?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: kcSecondary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            // Text(
                            //   "Date: ${Jiffy(DateTime.parse(controller.appointment.dateTime!)).format('MMM do, yyyy')}",
                            //   style: TextStyl.bodySm(context)?.copyWith(
                            //     color: kcDarkAlt,
                            //   ),
                            // ),
                            // Text(
                            //   "Time: ${Jiffy(DateTime.parse(controller.appointment.dateTime!)).format('hh:mm a')} - ${Jiffy(DateTime.parse(controller.appointment.dateEndTime!)).format('hh:mm a')}",
                            //   style: TextStyl.bodySm(context)?.copyWith(
                            //     color: kcDarkAlt,
                            //   ),
                            // ),
                            const SizedBox(height: 8),
                            Text(
                              "Pay \$${controller.appointment.paidPrice} to continue.",
                              style: TextStyl.body?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: kcSecondary,
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
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Obx(
                () => Button.block(
                  label: 'Checkout now',
                  onTap: (set) {
                    controller.checkout();
                    // Get.toNamed('/my-appointments');
                  },
                  key: UniqueKey(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
