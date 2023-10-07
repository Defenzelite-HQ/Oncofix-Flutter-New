/*
@category ZStarter Flutter
@ref     Defenzelite Product
@author  <Defenzelite hq@defenzelite.com>
@license <https://www.defenzelite.com Defenzelite Private Limited>
@version <zStarter: 202310-V1.2>
@link    <https://www.defenzelite.com>
*/

// Third Party Packages
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ui_x/helpers/Toastr.dart';

import '../../../helpers/Global.dart';
import '../../../helpers/Request.dart';
import '../../../models/ApiResponse.dart';
import '../../../models/CategoryElementModel.dart';
import '../../../shared/controllers/AppController.dart';
import '../models/DoctorModel.dart';
import '../models/FeedbackModel.dart';
import '../models/MeetingModel.dart';
import '../services/DoctorService.dart';

class DoctorController extends AppController {
  /// Creating Global Instance
  static DoctorController get instance {
    if (!Get.isRegistered<DoctorController>()) Get.put(DoctorController());
    return Get.find<DoctorController>();
  }

  /// Initialise [DoctorService] service
  final DoctorService _doctorService = DoctorService.instance;

  /// Initialize For Global Usage (Once per app run)
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ScrollController scrollController = ScrollController();


  /// --- System Handlers ---
  /// Observables & Getters

  // Add Scoped Var Here...

  /// --- Functionality Handlers ---
  /// Observables & Getters
  var _categories = <CategoryElementModel>[].obs;

  List<CategoryElementModel> get categories => this._categories;

  var _selectedGender = "both".obs;

  String get selectedGender => this._selectedGender.value;
  var _selectedSpecialist = "0".obs;

  String get selectedSpecialist => this._selectedSpecialist.value;

  var _categoryName = "".obs;

  String get categoryName => this._categoryName.value;
  RxBool _loadingMore = RxBool(false);

  bool get loadingMore => this._loadingMore.value;
  RxInt _page = RxInt(1);
  RxInt _limit = RxInt(10);

  bool get isLoading => this._isLoading.value;
  var _isLoading = false.obs;
  RxBool _doctorsListEnded = RxBool(false);

  var _indexData = <DoctorModel>[].obs;

  List<DoctorModel> get indexData => _indexData;

  var _showData = DoctorModel().obs;

  DoctorModel get showData => _showData.value;

  /// Variables
  TextEditingController taskInput = TextEditingController();

  TextEditingController nameInput = TextEditingController();


  @override
  void onInit() {
    super.onInit();
    index();
  }

  /// --- Core Functionalities Methods ---

  // Index
  Future<void> index({bool refresh = false}) async {
    try {
      if (!refresh) setBusy(true);

      var params = "";
      if (_selectedGender.value != 'both') {
        params = "${params + "gender=" + _selectedGender.value}";
      }
      if (_selectedSpecialist.value != '0') {
        params = "${params + "&profile_type=" + _selectedSpecialist.value}";
      } else if (_selectedSpecialist.value != '0') {
        params = "${params + "?profile_type=" + _selectedSpecialist.value}";
      } else if (_selectedSpecialist.value != '0' && nameInput.text != "") {
        params = "${params + "&name=" + nameInput.text}";
      } else if (_selectedGender.value != 'both' && nameInput.text != "") {
        params = "${params + "&name=" + nameInput.text}";
      } else if (nameInput.text != "") {
        params = "${params + "name=" + nameInput.text}";
      } else {
        setBusy(true);
      }

      _doctorService.init();

      /// Call Service to Get API Response
      ApiResponse response = await _doctorService.index(params: params);

      /// Checking Response Error
      if (response.hasError()) {
        Toastr.show(message: "${response.message}");
        setBusy(false);
        return;
      }

      /// Add Response Data To Variables
      if (response.hasData()) {
        _indexData.assignAll(List<DoctorModel>.from(
            response.data.map((e) => DoctorModel.fromJson(e))));
      }
      _doctorService.close();
      setBusy(false);
    } on Exception catch (e) {
      print(e);
    }
  }

  void resetFilter() async {
    _selectedSpecialist('0');
    _selectedGender('both');
    _categoryName('');
    nameInput.text = "";
    await index();
  }

  // Future<void> getMoreDoctors() async {
  //   _page(_page.value + 1);
  //   _loadingMore(true);
  //
  //   var params = "?page=${_page.value}&limit=${_limit.value}";
  //
  //   params = "${params + "&gender=" + _selectedGender.value}";
  //
  //   if (_selectedSpecialist.value != '0') {
  //     params = "${params + "&profile_type=" + _selectedSpecialist.value}";
  //   }
  //   if (nameInput.text != "") {
  //     params = "${params + "&name=" + nameInput.text}";
  //   }
  //   ApiResponse response =
  //   await Request.get('/doctors$params', authenticate: true);
  //
  //   if (response.hasError()) {
  //     ShowSnack.toast(message: "${response.message}");
  //     _loadingMore(false);
  //     return;
  //   }
  //
  //   log.w(response.data);
  //
  //   if (response.hasData()) {
  //     log.e(response.data);
  //     _doctors.addAll(List<DoctorModel>.from(
  //         response.data.map((e) => DoctorModel.fromJson(e))));
  //   } else {
  //     _doctorsListEnded(true);
  //   }
  //
  //   _loadingMore(false);
  // }

  // Future<void> getFilter() async {
  //   _isLoading(true);
  //
  //   ApiResponse response =
  //   await Request.get('/doctors/categories', authenticate: true);
  //
  //   log.w(response.data);
  //   if (response.hasError()) {
  //    Toastr.show(message: message);
  //     return;
  //   }
  //
  //   if (response.hasData()) {
  //     _categories.assignAll(List<CategoryElementModel>.from(
  //         response.data.map((x) => CategoryElementModel.fromJson(x))));
  //     if (Get.parameters['category_id'] != null) {
  //       CategoryElementModel cat = _categories
  //           .where((element) =>
  //       element.id.toString() ==
  //           Get.parameters['category_id'].toString())
  //           .first;
  //       _selectedSpecialist(Get.parameters['category_id']);
  //       _categoryName(cat.name);
  //       getDoctors(refresh: true);
  //     }
  //   }
  //
  //   _isLoading(false);
  // }

  void onGenderSelect(String gender) {
    _selectedGender(gender);
  }

  void onSpecialistSelect(String spec) {
    _selectedSpecialist(spec);
    CategoryElementModel cat = _categories
        .where((element) => element.id.toString() == spec.toString())
        .first;
    _categoryName(cat.name);
  }

  /// --- Common Functionalities Methods ---
// Here you can add a scoped method...

  /// --- Supporting Functionalities Methods ---
// Here you can add a scoped method...

  /// --- Form Functionalities Methods ---
// Here you can add a scoped method...
}
