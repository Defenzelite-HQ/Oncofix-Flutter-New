import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:ui_x/ui_x.dart';
import 'package:oncofix/app/modules/Doctor/views/widget/FilterBottomWidget.dart';

import '../../../helpers/Global.dart';
import '../../../shared/views/errors/NotConnectedErrorPage.dart';
import '../../../shared/views/layouts/MasterLayout.dart';
import '../../../shared/views/widgets/BottomNavigationBarWidget.dart';
import '../../../shared/views/widgets/Loading.dart';
import '../../../shared/views/widgets/LoadingIconWidget.dart';
import '../../../shared/views/widgets/NoDataWidget.dart';
import '../controllers/DoctorController.dart';
import '../models/DoctorModel.dart';

class DoctorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DoctorController>(
      init: DoctorController(),
      builder: (DoctorController controller) {
        return !controller.isConnected
            ? NotConnectedErrorPage()
            : controller.isBusy
                ? LoadingIconWidget(message: "Please wait...")
                : Obx(
              () => controller.isBusy
              ? Loading()
              : WillPopScope(
            onWillPop: () async {
              Get.delete<DoctorController>();
              return true;
            },
            child: MasterLayout(
              title:
              "${controller.categoryName != "" ? controller.categoryName : "Doctors"}",
              leading: IconButton(
                icon: Icon(
                  Icons.west,
                  size: spacer7,
                ),
                onPressed: () {
                  Get.delete<DoctorController>();
                  Get.back();
                },
              ),
              action: [
                IconButton(
                  icon: Icon(
                    Icons.filter_list_alt,
                    size: spacer5,
                  ),
                  onPressed: () {
                    Get.bottomSheet(
                    FilterBottomWidget(controller: controller),
                      barrierColor: kcPrimaryLight.withOpacity(0.2),
                      isDismissible: true,
                      enableDrag: true,
                      isScrollControlled: true,
                      ignoreSafeArea: false,
                    );
                  },
                ),
              ],
              body: controller.indexData.length <= 0
                  ? Center(
                child: Container(
                  child: Text("No data"),
                ),
              )
                  : Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      controller: controller.scrollController,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ...List.generate(controller.indexData.length,
                                    (index) {
                                  DoctorModel doctor =
                                  controller.indexData[index];
                                  return GestureDetector(
                                    onTap: () {
                                      Get.toNamed('/doctor-profile',
                                          parameters: {
                                            "doctor_id":
                                            doctor.id.toString()
                                          });
                                    },
                                    child: Card(
                                      margin: EdgeInsets.symmetric(
                                          vertical: 5.0, horizontal: 5.0),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(12.0)),
                                      color: kcWhite,
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  8.0),
                                              child: Image.network(
                                                '${doctor.avatar}',
                                                width: 90,
                                                height: 90,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: screen.width * 0.5,
                                                  child: Text(
                                                    "${doctor.name}",
                                                    style: TextStyl.title
                                                        ?.copyWith(
                                                        fontSize: 14,
                                                        color:
                                                        kcSecondary,
                                                        overflow:
                                                        TextOverflow
                                                            .ellipsis),
                                                    maxLines: 1,
                                                  ),
                                                ),
                                                doctor.category != null
                                                    ? Text(
                                                  "${doctor.category!.name}",
                                                  style: TextStyl
                                                      .caption
                                                      ?.copyWith(
                                                      fontSize:
                                                      spacer3,
                                                      overflow:
                                                      TextOverflow
                                                          .ellipsis),
                                                  maxLines: 1,
                                                )
                                                    : Text(
                                                  "Default Cat",
                                                  style: TextStyl
                                                      .caption
                                                      ?.copyWith(
                                                    fontSize: spacer3,
                                                  ),
                                                ),
                                                if (doctor.rating != null)
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                if (doctor.rating != null)
                                                  RatingBar.builder(
                                                    itemSize: 10,
                                                    initialRating:
                                                    doctor.rating ??
                                                        0.0,
                                                    minRating: 1,
                                                    direction:
                                                    Axis.horizontal,
                                                    allowHalfRating: true,
                                                    itemCount: 5,
                                                    itemPadding: EdgeInsets
                                                        .symmetric(
                                                        horizontal:
                                                        2.0),
                                                    itemBuilder:
                                                        (context, _) =>
                                                        Icon(
                                                          Icons.star,
                                                          color: Colors.amber,
                                                        ),
                                                    onRatingUpdate:
                                                        (rating) {
                                                      print(rating);
                                                    },
                                                  ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Experience:",
                                                      style: TextStyl.title
                                                          ?.copyWith(
                                                        fontSize: spacer3,
                                                        color: kcGray,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),

                                                    /// TODO: make it dynamic
                                                    Text(
                                                      "5 Years",
                                                      style: TextStyl.title
                                                          ?.copyWith(
                                                        fontSize:
                                                        spacer4 / 1.2,
                                                        color: kcSecondary,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Spacer(),
                                            Icon(
                                              Icons.navigate_next,
                                              color: kcPrimary,
                                              size: spacer7,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                            // ListView.builder(
                            //   itemCount: controller.doctors.length+1,
                            //   itemBuilder: (context,index){
                            //     if(index == controller.doctors.length)
                            //       LoadingIconWidget();
                            //     DoctorModel doctor = controller.doctors[index];
                            //     return  GestureDetector(
                            //       onTap: () {
                            //         Get.toNamed('/doctor-profile', parameters: {"doctor_id": doctor.id.toString()});
                            //       },
                            //       child: Card(
                            //         margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                            //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                            //         color: kcWhite,
                            //         child: Padding(
                            //           padding: const EdgeInsets.all(12.0),
                            //           child: Row(
                            //             mainAxisAlignment: MainAxisAlignment.start,
                            //             crossAxisAlignment: CrossAxisAlignment.center,
                            //             children: [
                            //               ClipRRect(
                            //                 borderRadius: BorderRadius.circular(8.0),
                            //                 child: Image.network(
                            //                   '${doctor.avatar}',
                            //                   width: 90,
                            //                   height: 90,
                            //                   fit: BoxFit.cover,
                            //                 ),
                            //               ),
                            //               SizedBox(
                            //                 width: 10,
                            //               ),
                            //               Column(
                            //                 mainAxisAlignment: MainAxisAlignment.start,
                            //                 crossAxisAlignment: CrossAxisAlignment.start,
                            //                 children: [
                            //                   Text(
                            //                     "${doctor.name}",
                            //                     style: TextStyl.title(context)?.copyWith(
                            //                       fontSize: 14,
                            //                       color: kcSecondary,
                            //                     ),
                            //                   ),
                            //                   doctor.category != null
                            //                       ? Text(
                            //                     "${doctor.category!.name}",
                            //                     style: TextStyl.caption(context)?.copyWith(
                            //                       fontSize: spacer3,
                            //                     ),
                            //                   )
                            //                       : Text(
                            //                     "Default Cat",
                            //                     style: TextStyl.caption(context)?.copyWith(
                            //                       fontSize: spacer3,
                            //                     ),
                            //                   ),
                            //                   SizedBox(
                            //                     height: 10,
                            //                   ),
                            //                   RatingBar.builder(
                            //                     itemSize: 10,
                            //                     initialRating: 3,
                            //                     minRating: 1,
                            //                     direction: Axis.horizontal,
                            //                     allowHalfRating: true,
                            //                     itemCount: 5,
                            //                     itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                            //                     itemBuilder: (context, _) => Icon(
                            //                       Icons.star,
                            //                       color: Colors.amber,
                            //                     ),
                            //                     onRatingUpdate: (rating) {
                            //                       print(rating);
                            //                     },
                            //                   ),
                            //                   SizedBox(
                            //                     height: 10,
                            //                   ),
                            //                   Row(
                            //                     children: [
                            //                       Text(
                            //                         "Experience:",
                            //                         style: TextStyl.title(context)?.copyWith(
                            //                           fontSize: spacer3,
                            //                           color: kcGray,
                            //                         ),
                            //                       ),
                            //                       SizedBox(
                            //                         width: 5,
                            //                       ),
                            //
                            //                       /// TODO: make it dynamic
                            //                       Text(
                            //                         "5 Years",
                            //                         style: TextStyl.title(context)?.copyWith(
                            //                           fontSize: spacer4 / 1.2,
                            //                           color: kcSecondary,
                            //                         ),
                            //                       ),
                            //                     ],
                            //                   ),
                            //                 ],
                            //               ),
                            //               Spacer(),
                            //               Icon(
                            //                 Icons.navigate_next,
                            //                 color: kcPrimary,
                            //                 size: spacer7,
                            //               ),
                            //             ],
                            //           ),
                            //         ),
                            //       ),
                            //     );
                            //   },
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (controller.loadingMore)
                    Container(
                      width: double.maxFinite,
                      // height: 40,
                      decoration: BoxDecoration(
                        color: kcWhite,
                        boxShadow: [
                          BoxShadow(
                            color: kcBlack.withOpacity(0.1),
                            blurRadius: 5,
                            spreadRadius: -2,
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: LoadingIcon(),
                    ),
                ],
              ),
              bottomNavigationBar: BottomNavigationBarWidget(
                route: 'doctors',
              ),
            ),
          ),
        );
      },
    );
  }
}

