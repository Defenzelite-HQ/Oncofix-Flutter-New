/*
@category ZStarter Flutter
@ref     Defenzelite Product
@author  <Defenzelite hq@defenzelite.com>
@license <https://www.defenzelite.com Defenzelite Private Limited>
@version <zStarter: 202310-V1.2>
@link    <https://www.defenzelite.com>
*/

import 'dart:convert';

import 'package:flutter/services.dart' as rootBundle;
import 'package:get/get.dart';

import '../../../helpers/Global.dart';
import '../../../models/LanguageModel.dart';
import '../../../models/SettingModel.dart';
import '../../../shared/controllers/AppController.dart';
import '../services/SettingService.dart';

class SettingController extends AppController {
  /// Create and get the instance of the controller
  static SettingController get instance {
    if (!Get.isRegistered<SettingController>()) Get.put(SettingController());
    return Get.find<SettingController>();
  }

  /// Initialise [SettingModule] service
  final SettingService _settingService = SettingService.instance;

  /// Observables
  var _languages = <LanguageModel>[].obs;
  var _setting = SettingModel().obs;

  /// Getters
  List<LanguageModel> get languages => _languages;

  SettingModel get setting => _setting.value;

  @override
  void onInit() {
    super.onInit();
    getSettings();
    applyLocale(setting.appLocale);
    getLanguages();
  }

  void getSettings() {
    if (storage.read('settings') == null) {
      storage.write('settings',
          jsonEncode({"sound": true, "notifications": true, "locale": 'en'}));
    }
    _setting(SettingModel.fromJsom(jsonDecode(storage.read('settings'))));
    _setting.refresh();
  }

  ///
  /// Example usage:
  /// ```dart
  /// SearchableDialog(
  ///     onChanged: (value) {
  ///       controller.settingController.storeSetting(key: 'locale', value: value);
  ///       playAudio("click");
  ///     },
  ///     value: controller.settingController.setting.appLocale!,
  ///     placeholder: "Select Language",
  ///     options: [
  ///       DropDownItems(
  ///         label: "Select Language",
  ///         value: 'en',
  ///       ),
  ///       ...List.generate(controller.settingController.languages.length, (index) {
  ///         LanguageModel language = controller.settingController.languages[index];
  ///         return DropDownItems(
  ///           label: '${language.name}',
  ///           value: '${language.code}',
  ///         );
  ///       }),
  ///     ]),
  /// ```
  ///
  Future<void> getLanguages() async {
    final jsonData =
        await rootBundle.rootBundle.loadString('assets/langs.json');
    //decode json data as list
    final list = json.decode(jsonData) as List<dynamic>;
    _languages.assignAll(
        List<LanguageModel>.from(list.map((e) => LanguageModel.fromJson(e))));
  }

  void storeSetting({required String key, dynamic value}) async {
    Map<String, dynamic> _set = jsonDecode(storage.read('settings'));
    if (value != null) _set[key] = value;
    await storage.write('settings', jsonEncode(_set));
    if (key == 'locale') applyLocale(value);
    getSettings();
  }
}
