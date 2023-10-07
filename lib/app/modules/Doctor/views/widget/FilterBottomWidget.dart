import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:ui_x/helpers/ColorPalette.dart';
import 'package:ui_x/helpers/Sizes.dart';
import 'package:ui_x/helpers/Str.dart';
import 'package:ui_x/helpers/TextStyl.dart';
import 'package:ui_x/widgets/forms/FormInput.dart';

import '../../../../helpers/Global.dart';
import '../../../../models/CategoryElementModel.dart';
import '../../controllers/DoctorController.dart';

class FilterBottomWidget extends StatelessWidget {
  const FilterBottomWidget({Key? key, required this.controller})
      : super(key: key);

  final DoctorController controller;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => Container(
          height: screen.height * 0.9,
          decoration: new BoxDecoration(
            color: kcWhite,
            borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(40.0),
              topRight: const Radius.circular(40.0),
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
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
                      height: 15,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Apply Filter",
                        style: TextStyl.title!.copyWith(
                          color: kcSecondary,
                          fontWeight: FontWeight.bold,
                          fontSize: spacer5,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    FormInput.text(
                      controller: controller.nameInput,
                      leading: Icon(
                        Icons.search,
                        size: spacer6,
                      ),
                      placeholder: "Search By Name",
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        "Gender",
                        style: TextStyl.title!.copyWith(
                          color: kcSecondary,
                          fontWeight: FontWeight.bold,
                          fontSize: spacer4,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Obx(
                      () => Column(
                        children: [
                          GestureDetector(
                            onTap: () => controller.onGenderSelect('male'),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: controller.selectedGender == 'male'
                                    ? kcPrimary.withOpacity(0.15)
                                    : kcWhite,
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "${Str.ucFirst("male")}",
                                    style: TextStyl.title!.copyWith(
                                      color: kcSecondary,
                                      fontWeight: FontWeight.w500,
                                      fontSize: spacer4,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Divider(height: 1),
                          GestureDetector(
                            onTap: () => controller.onGenderSelect('female'),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: controller.selectedGender == 'female'
                                    ? kcPrimary.withOpacity(0.15)
                                    : kcWhite,
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "${Str.ucFirst("female")}",
                                    style: TextStyl.title!.copyWith(
                                      color: kcSecondary,
                                      fontWeight: FontWeight.w500,
                                      fontSize: spacer4,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Divider(height: 1),
                          GestureDetector(
                            onTap: () => controller.onGenderSelect('both'),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: controller.selectedGender == 'both'
                                    ? kcPrimary.withOpacity(0.15)
                                    : kcWhite,
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "${Str.ucFirst("both")}",
                                    style: TextStyl.title!.copyWith(
                                      color: kcSecondary,
                                      fontWeight: FontWeight.w500,
                                      fontSize: spacer4,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "Select Specialist",
                        style: TextStyl.title!.copyWith(
                          color: kcSecondary,
                          fontWeight: FontWeight.bold,
                          fontSize: spacer4,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ...List.generate(controller.categories.length, (index) {
                      CategoryElementModel specialist =
                          controller.categories[index];
                      return Obx(
                        () => GestureDetector(
                          onTap: () => controller
                              .onSpecialistSelect(specialist.id.toString()),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: controller.selectedSpecialist ==
                                          specialist.id.toString()
                                      ? kcPrimary.withOpacity(0.15)
                                      : kcWhite,
                                ),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 16, horizontal: 16),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${specialist.name}",
                                      style: TextStyl.title!.copyWith(
                                        color: kcSecondary,
                                        fontWeight: FontWeight.w500,
                                        fontSize: spacer4,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (index != controller.categories.length - 1)
                                Divider(height: 1),
                            ],
                          ),
                        ),
                      );
                    }),
                    // Padding(
                    //   padding: const EdgeInsets.all(12.0),
                    //   child: Row(
                    //     children: [
                    //       Button.primary(
                    //         label: 'Apply Filter',
                    //         labelStyle: TextStyl.body(context)!.copyWith(
                    //           fontWeight: FontWeight.bold,
                    //           color: kcWhite,
                    //         ),
                    //       ),
                    //       SizedBox(
                    //         height: 10,
                    //       ),
                    //       Button.outline(
                    //         label: 'Reset Filter',
                    //         labelStyle: TextStyl.body(context)!.copyWith(
                    //           fontWeight: FontWeight.bold,
                    //           color: kcPrimary,
                    //         ),
                    //         leading: Icon(
                    //           Icons.refresh,
                    //           color: kcPrimary,
                    //           size: spacer7,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      child: Container(
                        height: 40,
                        color: kcPrimary,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.filter_alt_outlined,
                              size: spacer5,
                              color: kcWhite,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Apply Filter",
                              style: TextStyl.body(context)
                                  ?.copyWith(color: kcWhite, fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Get.back();
                        controller.getDoctors();
                      },
                    ),
                  ),
                  VerticalDivider(
                    width: 1,
                  ),
                  Expanded(
                    child: GestureDetector(
                      child: Container(
                        height: 40,
                        color: kcOffWhite,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.refresh_outlined,
                              size: spacer5,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Reset Filter",
                              style: TextStyl.body(context)
                                  ?.copyWith(color: kcSecondary, fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Get.back();
                        controller.resetFilter();
                      },
                    ),
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
