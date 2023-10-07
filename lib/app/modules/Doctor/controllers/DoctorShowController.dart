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

import '../../../models/ApiResponse.dart';
import '../../../shared/controllers/AppController.dart';
import '../models/DoctorModel.dart';
import '../models/FeedbackModel.dart';
import '../models/MeetingModel.dart';
import '../services/DoctorService.dart';

class DoctorShowController extends AppController {
  /// Creating Global Instance
  static DoctorShowController get instance {
    if (!Get.isRegistered<DoctorShowController>())
      Get.put(DoctorShowController());
    return Get.find<DoctorShowController>();
  }

  /// Initialise [DoctorService] service
  final DoctorService _doctorService = DoctorService.instance;

  /// Initialize For Global Usage (Once per app run)
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  /// --- System Handlers ---
  /// Observables & Getters

  // Add Scoped Var Here...

  /// --- Functionality Handlers ---
  /// Observables & Getters
  var _feedback = FeedbackModel().obs;
  var _meetings = <MeetingModel>[].obs;
  var _doctorId = "".obs;
  var _showData = DoctorModel().obs;

  DoctorModel get showData => _showData.value;

  /// Variables
  TextEditingController taskInput = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    _doctorId(Get.parameters['doctor_id']);
    getFeedback();
    show();
    getMeetings();
  }

  /// --- Core Functionalities Methods ---

  //Show
  Future<void> show({bool refresh = false}) async {
    try {
      setBusy(true);
      _doctorService.init();

      /// Call Service to Get API Response
      ApiResponse response =
          await _doctorService.show(id: int.parse(_doctorId.value.toString()));

      /// Checking Response Error
      if (response.hasError()) {
        Toastr.show(message: "${response.message}");
        setBusy(false);
        return;
      }

      /// Add Response Data To Variables
      if (response.hasData()) {
        _showData(DoctorModel.fromJson(response.data));
      }

      _doctorService.close();
      setBusy(false);
    } on Exception catch (e) {
      print(e);
    }
  }

  //getMeetings
  Future<void> getMeetings({bool refresh = false}) async {
    try {
      setBusy(true);
      _doctorService.init();

      /// Call Service to Get API Response
      ApiResponse response = await _doctorService.getMeetings(
          id: int.parse(_doctorId.value.toString()));

      /// Checking Response Error
      if (response.hasError()) {
        Toastr.show(message: "${response.message}");
        setBusy(false);
        return;
      }

      /// Add Response Data To Variables
      if (response.hasData()) {
        _meetings.assignAll(List<MeetingModel>.from(
            response.data.map((x) => MeetingModel.fromJson(x))));
      }

      _doctorService.close();
      setBusy(false);
    } on Exception catch (e) {
      print(e);
    }
  }

//getFeedback
  Future<void> getFeedback({bool refresh = false}) async {
    try {
      setBusy(true);
      _doctorService.init();

      /// Call Service to Get API Response
      ApiResponse response = await _doctorService.getFeedbacks(
          id: int.parse(_doctorId.value.toString()));

      /// Checking Response Error
      if (response.hasError()) {
        Toastr.show(message: "${response.message}");
        setBusy(false);
        return;
      }

      /// Add Response Data To Variables
      if (response.hasData()) {
        _showData(DoctorModel.fromJson(response.data));
      }

      _doctorService.close();
      setBusy(false);
    } on Exception catch (e) {
      print(e);
    }
  }

  /// --- Common Functionalities Methods ---
// Here you can add a scoped method...

  /// --- Supporting Functionalities Methods ---
// Here you can add a scoped method...

  /// --- Form Functionalities Methods ---
// Here you can add a scoped method...
}
