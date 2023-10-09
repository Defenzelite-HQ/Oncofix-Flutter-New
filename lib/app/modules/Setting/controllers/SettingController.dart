/*
@category ZStarter Flutter
@ref     Defenzelite Product
@author  <Defenzelite hq@defenzelite.com>
@license <https://www.defenzelite.com Defenzelite Private Limited>
@version <zStarter: 202310-V1.2>
@link    <https://www.defenzelite.com>
*/

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:get/get.dart';
import 'package:ui_x/helpers/Helpers.dart';
import 'package:ui_x/helpers/Helpers.dart';

import '../../../../config/Config.dart';
import '../../../helpers/Global.dart';
import '../../../models/ApiResponse.dart';
import '../../../models/LanguageModel.dart';
import '../../../models/SettingModel.dart';
import '../../../models/UserModel.dart';
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

  /// --- System Handlers ---
  /// Observables & Getters

  // Add Scoped Var Here...

  /// --- Functionality Handlers ---
  /// Observables & Getters
  var _languages = <LanguageModel>[].obs;
  List<LanguageModel> get languages => _languages;
  var _setting = SettingModel().obs;
  SettingModel get setting => _setting.value;
  var _user = UserModel().obs;
  UserModel get user => this._user.value;
  var _selectedAvatar = <File>[].obs;
  List<File> get selectedAvatar => this._selectedAvatar;
  var _selectedGender = "".obs;
  String get selectedGender => this._selectedGender.value;
  var _updating = false.obs;
  bool get updating => this._updating.value;


  final TextEditingController userNameInput = TextEditingController();
  final TextEditingController emailInput = TextEditingController();
  final TextEditingController phoneNumberInput = TextEditingController();
  final TextEditingController dobInput = TextEditingController();


  @override
  void onInit() {
    super.onInit();
    getSettings();
    applyLocale(setting.appLocale);
    getLanguages();
  }

  Future<void> getUser() async {
    userNameInput.text = auth.user.name!;
    emailInput.text = auth.user.email!;
    phoneNumberInput.text = auth.user.phone!;
    _selectedGender(auth.user.gender!);
    if(auth.user.dob != null) dobInput.text = auth.user.dob!;
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


  Future<void> updateUser() async {

    MultipartRequest request = http.MultipartRequest("POST", Uri.parse(Config.apiBaseUrl + "/update-profile"));

    /// Files
    if(_selectedAvatar.length >= 1) request.files.add(await http.MultipartFile.fromPath("avatar", _selectedAvatar.first.path));

    request.fields['name'] = userNameInput.text;
    request.fields['email'] = emailInput.text;
    request.fields['phone'] = phoneNumberInput.text;
    request.fields['gender'] = _selectedGender.value;

    // Set Headers
    Map<String, String> _headers = {
      "Accept": "application/json",
      "Content-type": "application/json",
      "Authorization": "Bearer ${storage.read('token')}",
    };
    request.headers.addAll(_headers);

    _updating(true);
    StreamedResponse send = await request.send().timeout(60.seconds);

    http.Response res = await http.Response.fromStream(send);

    ApiResponse response = ApiResponse.fromJson(jsonDecode(res.body));

    if(response.hasError()){
      Toastr.show(message: "${response.message}");
      _updating(false);
      return;
    }
    await auth.getUser();
    getUser();
    _updating(false);
    Toastr.show(message: "${response.message}");
  }

  void onGenderSelect(String gender){
    _selectedGender(gender);
  }


  void onAvatarSelect(File file){
    _selectedAvatar.clear();
    _selectedAvatar.add(file);
  }
}
