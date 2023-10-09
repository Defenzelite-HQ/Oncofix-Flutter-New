import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_x/ui_x.dart';
import 'package:jiffy/jiffy.dart';
import '../../../shared/views/errors/NotConnectedErrorPage.dart';
import '../../../shared/views/layouts/MasterLayout.dart';
import '../../../shared/views/widgets/Loading.dart';
import '../../../shared/views/widgets/LoadingIconWidget.dart';
import '../../../shared/views/widgets/NoDataWidget.dart';
import '../controllers/NotificationController.dart';
import '../models/NotificationModel.dart';

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationController>(
      init: NotificationController(),
      builder: (NotificationController controller) {
        return !controller.isConnected
            ? NotConnectedErrorPage()
            : controller.isBusy
                ? LoadingIconWidget(message: "Please wait...")
                : MasterLayout(
                    title: 'Notifications',
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
                        : controller.indexData.isEmpty
                            ? Center(
                                child: NoDataWidget(
                                    message: "No Notification Data Found!"))
                            : Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      ...List.generate(
                                           controller.indexData.length,
                                          (index) {
                                        NotificationModel indexData =
                                            controller.indexData[index];
                                        return Container(
                                          padding: const EdgeInsets.all(8.0),
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color: kcDarkAlt
                                                          .withOpacity(0.2)))),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Flexible(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "${indexData.title}",
                                                      style: TextStyl.title

                                                          ?.copyWith(
                                                        fontSize: spacer4,
                                                        color: kcSecondary,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5.0,
                                                    ),
                                                    Text(
                                                      "${indexData.notification}",
                                                      style: TextStyl.caption
                                                          ?.copyWith(
                                                        fontSize: spacer4 / 1.2,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                "${Jiffy(indexData.createdAt.toString()).format("MMM dd yyyy hh:mm:ss")}",
                                                style: TextStyl.caption
                                                    ?.copyWith(
                                                  fontSize: spacer3,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }),
                                    ],
                                  ),
                                ),
                              ),
                  );
      },
    );
  }
}
