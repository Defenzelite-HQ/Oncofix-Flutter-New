import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:oncofix/app/modules/Modules.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:ui_x/helpers/Helpers.dart';
import 'package:oncofix/app/helpers/Global.dart';
import '../../../../config/Config.dart';
import '../../../helpers/Webview.dart';



Drawer appDrawer(BuildContext context, DashboardController controller) {
  return Drawer(
    child: Obx(
      () => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              Image.asset(
                'assets/icons/bg-bnr-onco-01.jpg',
                width: double.infinity,
                height: 120,
                fit: BoxFit.cover,
              ),
              GestureDetector(
                child: Container(
                  height: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(height: 80),
                      CircleAvatar(
                        radius: 32,
                        backgroundColor: Colors.grey[200],
                        child: CircleAvatar(
                          backgroundColor: kcWhite,
                          backgroundImage:
                              NetworkImage("${auth.user.avatar}"),
                          radius: 32,
                        ),
                      ),
                      Container(height: 2),
                      Text(
                        "${auth.user.name}",
                        style: TextStyle(
                            color: kcSecondary, fontWeight: FontWeight.w600),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text("${auth.user.email}",
                          style: TextStyle(
                              color: Colors.blueGrey[800],
                              fontWeight: FontWeight.w500,
                              fontSize: 12))
                    ],
                  ),
                ),
                onTap: () {
                  Get.offAndToNamed(SettingRoutes.setting);
                },
              ),
            ],
          ),
          Config.isPatient()
              ? Obx(
                  () => Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    margin: EdgeInsets.only(top: 10,bottom: 10),
                    width: screen.width* 0.4,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: kcSecondary)
                    ),
                    child: QrImageView(
                      data: controller.qrcode,
                      version: QrVersions.auto,
                      size: 110,
                      gapless: true,
                    ),
                  ),
                )
              : SizedBox.shrink(),
          Config.isPatient() ?
              Text("Your Oncofix Smart Card", style: TextStyl.subtitle
                  ?.copyWith(fontSize: 12),)
              : SizedBox.shrink(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    color: kcWhite,
                    child: Column(
                      children: [
                        BottomWidget(
                          onTap: () => Navigator.of(context).pop(),
                          image: "assets/icons/fill_home.png",
                          label: "Home",
                        ),
                        /// +++++++++++++++++++++++
                        /// About Cancer
                        /// +++++++++++++++++++++++
                        // BottomWidget(
                        //   onTap: () => webViewOnTap("about_cancer"),
                        //   image: "assets/icons/ribbon.svg",
                        //   imageExtension: "svg",
                        //   label: "About Cancer",
                        // ),
                        /// +++++++++++++++++++++++
                        /// Financial Advice
                        /// +++++++++++++++++++++++
                        // BottomWidget(
                        //   onTap: () => webViewOnTap("financial_advice"),
                        //   image: "assets/icons/advice.svg",
                        //   imageExtension: "svg",
                        //   label: "Financial Advices",
                        // ),
                        /// +++++++++++++++++++++++
                        /// Refer & Earn
                        /// +++++++++++++++++++++++
                        Config.isPatient() ?
                        BottomWidget(
                          onTap: () => webViewOnTap("refer_earn_patient"),
                          image: "assets/icons/refer.svg",
                          imageExtension: "svg",
                          label: "Refer & Earn",
                        ) :
                        Config.isDoctor() ?
                        BottomWidget(
                          onTap: () => webViewOnTap("refer_earn_doctor"),
                          image: "assets/icons/refer.svg",
                          imageExtension: "svg",
                          label: "Refer & Earn",
                        ):
                            SizedBox.shrink(),
                        /// +++++++++++++++++++++++
                        /// About Us
                        /// +++++++++++++++++++++++
                        BottomWidget(
                          onTap: () => webViewOnTap("about_us"),
                          image: "assets/icons/about.png",
                          imageExtension: "png",
                          label: "About Us",
                        ),
                        /// +++++++++++++++++++++++
                        /// Legal
                        /// +++++++++++++++++++++++
                        BottomWidget(
                          onTap: () {
                            Get.toNamed(AboutRoutes.about);
                          },
                          image: "assets/icons/legal.png",
                          imageExtension: "png",
                          label: "Legal",
                        ),
                        Config.isDoctor() ?
                        GestureDetector( onTap: () => webViewOnTap("doctor_chat"),
                          child: Text("Talk with Dr. Onco", style: TextStyl.subtitle
                              ?.copyWith(fontSize: 13),),
                        )
                        :SizedBox.shrink(),
                        Divider(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  auth.logout();
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.logout,
                      color: kcDanger,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Logout",
                      style: TextStyl.body
                          ?.copyWith(color: kcDanger, fontSize: 15),
                    )
                  ],
                ),
              ),
              Text(
                "OncoFix v1.1",
                style: TextStyl.bodySm?.copyWith(
                  fontSize: spacer2,
                  color: kcSecondary,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

class BottomWidget extends StatelessWidget {
  const BottomWidget(
      {super.key,
      required this.onTap,
      this.imageExtension = "png",
      this.image,
      this.iconData,
      this.label = ""});

  final VoidCallback onTap;
  final String imageExtension;
  final String? image;
  final String label;
  final IconData? iconData;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
        color: kcWhite,
        child: Row(
          children: [
            imageExtension == "icon"
                ? Icon(
                    iconData,
                    color: kcSecondary,
                    size: spacer5,
                  )
                : imageExtension == "svg"
                    ? SvgPicture.asset(
                        "$image",
                        color: kcSecondary,
                        height: spacer4,
                      )
                    : Image.asset(
                        "$image",
                        color: kcSecondary,
                        height: spacer4,
                      ),
            if (label != "") SizedBox(width: 8),
            if (label != "")
              Text(
                '$label',
                style: TextStyl.subtitle
                    ?.copyWith(fontSize: 14, color: kcSecondary),
              ),
          ],
        ),
      ),
    );
  }
}
