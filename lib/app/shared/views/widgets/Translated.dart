import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:google_translator/google_translator.dart';

import '../../../modules/Setting/controllers/SettingController.dart';

class Translated extends StatelessWidget {
  Translated({Key? key, required this.child}) : super(key: key);
  final dynamic child;

  final SettingController settingController = SettingController.instance;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: SettingController(),
        builder: (_) {
          return settingController.setting.appLocale != 'en'
              ? Text(
                  child.data,
                  style: child.style,
                  key: child.key,
                  maxLines: child.maxLines,
                  overflow: child.overflow,
                  textAlign: child.textAlign,
                ).translate()
              : child;
        });
  }
}
