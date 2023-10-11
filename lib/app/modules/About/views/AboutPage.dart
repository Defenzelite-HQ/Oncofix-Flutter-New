import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oncofix/app/modules/About/views/widget/AboutWidget.dart';
import 'package:ui_x/helpers/Sizes.dart';
import '../../../helpers/Webview.dart';
import '../../../shared/views/layouts/MasterLayout.dart';

class AboutPage extends StatelessWidget {
  AboutPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MasterLayout(
        leading: IconButton(
          icon: Icon(
            Icons.west,
            size: spacer5,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: "Legal",
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
          child: Column(
            children: [
              // AboutWidget(
              //     about: "About Us",
              //     onTap: () => webViewOnTap("about_us")),
              // AboutWidget(about: "Contact Us", onTap: () {}),
              // AboutWidget(about: "FAQ's", onTap: () {}),
              AboutWidget(
                  about: "Terms & Conditions",
                  onTap: () => webViewOnTap("terms_&_condition")),
              AboutWidget(
                  about: "Return Policy",
                  onTap: () => webViewOnTap("privacy_policy")),
              AboutWidget(
                  about: "Privacy Policy",
                  onTap: () => webViewOnTap("privacy_policy")),
            ],
          ),
        ));
  }
}
