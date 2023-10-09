import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_x/helpers/ColorPalette.dart';
import 'package:ui_x/helpers/Sizes.dart';
import 'package:ui_x/helpers/TextStyl.dart';
import 'package:ui_x/widgets/LoadingIcon.dart';
import 'package:ui_x/widgets/forms/FormInput.dart';
import 'package:ui_x/widgets/forms/FormLabel.dart';
import 'package:ui_x/widgets/forms/FormSelect.dart';

import '../../../helpers/Global.dart';
import '../../../shared/views/errors/NotConnectedErrorPage.dart';
import '../../../shared/views/widgets/LoadingIconWidget.dart';
import '../controllers/SettingController.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingController>(
      init: SettingController(),
      builder: (SettingController controller) {
        return !controller.isConnected
            ? NotConnectedErrorPage()
            : controller.isBusy
                ? LoadingIconWidget(message: "Please wait...")
                : Obx(
                    () => controller.isBusy
                        ? LoadingIconWidget()
                        : Scaffold(
                            backgroundColor: kcWhite,
                            appBar: AppBar(
                              backgroundColor: Color(0xff0C1B32),
                              leading: IconButton(
                                icon: Icon(
                                  Icons.west,
                                  color: Color(0xffF4F5F5),
                                  size: 28,
                                ),
                                onPressed: () {
                                  Get.back();
                                },
                              ),
                              centerTitle: true,
                              title: Text(
                                "Profile",
                                style: TextStyl.title?.copyWith(
                                  fontSize: spacer5,
                                  color: kcWhite,
                                ),
                              ),
                              actions: [
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: GestureDetector(
                                      child: Obx(
                                        () => controller.updating
                                            ? LoadingIcon(color: kcWhite)
                                            : Text(
                                                "Save",
                                                style:
                                                    TextStyl.subtitle?.copyWith(
                                                  fontSize: spacer4,
                                                  color: kcWhite,
                                                ),
                                              ),
                                      ),
                                      onTap: () {
                                        if (!controller.updating) {
                                          controller.updateUser();
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            body: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Container(
                                    height: 150,
                                    width: screen.width,
                                    color: kcLightGray,
                                    child: Stack(
                                      children: [
                                        Align(
                                          alignment: Alignment.center,
                                          child: controller
                                                      .selectedAvatar.length >=
                                                  1
                                              ? CircleAvatar(
                                                  radius: 50,
                                                  foregroundImage: FileImage(
                                                      controller.selectedAvatar
                                                          .first),
                                                )
                                              : CircleAvatar(
                                                  backgroundImage: NetworkImage(
                                                      "${auth.user.avatar}"),
                                                  radius: 50,
                                                ),
                                        ),
                                        SizedBox(
                                          height: 50,
                                        ),
                                        Positioned(
                                          left: 220,
                                          top: 90,
                                          child: SizedBox(
                                            height: 40,
                                            width: 40,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: kcDanger,
                                                shape: BoxShape.circle,
                                              ),
                                              child: IconButton(
                                                onPressed: () async {
                                                  // TODO: File picker package used
                                                  FilePickerResult? result =
                                                      await FilePicker.platform
                                                          .pickFiles(
                                                    allowMultiple: false,
                                                    type: FileType.custom,
                                                    allowedExtensions: [
                                                      'jpg',
                                                      'png',
                                                      'jpeg'
                                                    ],
                                                  );

                                                  if (result != null) {
                                                    controller.onAvatarSelect(
                                                        File(result.files.first
                                                            .path!));
                                                  } else {}
                                                },
                                                icon: Icon(
                                                  Icons.camera_alt_outlined,
                                                  color: kcWhite,
                                                  size: spacer5,
                                                ),
                                                padding:
                                                    const EdgeInsets.all(4),
                                                iconSize: 22,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(24.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        FormLabel(
                                          label: "Name",
                                          color: kcDarkAlt,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        FormInput.text(
                                          controller: controller.userNameInput,
                                          placeholder: "Prakash Thakur",
                                        ),
                                        SizedBox(height: 20),
                                        FormLabel(
                                          label: "Email Address",
                                          color: kcDarkAlt,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        FormInput.text(
                                          controller: controller.emailInput,
                                          placeholder: "prakashseoni@gmail.com",
                                        ),
                                        SizedBox(height: 20),
                                        FormLabel(
                                          label: "Phone Number",
                                          color: kcDarkAlt,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        FormInput.text(
                                          controller:
                                              controller.phoneNumberInput,
                                          placeholder: "9876543200",
                                        ),
                                        SizedBox(height: 20),
                                        FormLabel(
                                          label: "Gender",
                                          color: kcDarkAlt,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        FormSelect(
                                          value: controller.selectedGender,
                                          options: [
                                            DropdownMenuItem(
                                              child: Text('Select Gender'),
                                              value: '',
                                            ),
                                            DropdownMenuItem(
                                              child: Text('Male'),
                                              value: 'male',
                                            ),
                                            DropdownMenuItem(
                                              child: Text('Female'),
                                              value: 'female',
                                            )
                                          ],
                                          onChanged: (value) =>
                                              controller.onGenderSelect(value),
                                        ),
                                        SizedBox(height: 20),
                                        FormLabel(
                                          label: "Date of Birth",
                                          color: kcDarkAlt,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        FormInput.text(
                                          controller: controller.dobInput,
                                          placeholder: "28-04-2022",
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                  );
      },
    );
  }
}
