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
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:ui_x/helpers/Toastr.dart';
import '../../../helpers/Global.dart';
import '../../../models/ApiResponse.dart';
import '../../../models/CategoryElementModel.dart';
import '../../../shared/controllers/AppController.dart';
import '../models/DashboardModel.dart';
import '../models/FeaturedDoctorModel.dart';
import '../services/DashboardService.dart';


class DashboardController extends AppController {
  /// Creating Global Instance
  static DashboardController get instance {
    if (!Get.isRegistered<DashboardController>())
      Get.put(DashboardController());
    return Get.find<DashboardController>();
  }

  /// Initialise [DashboardService] service
  final DashboardService _dashboardService = DashboardService.instance;

  /// Initialize For Global Usage (Once per app run)
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late ScrollController _scrollController;

  /// --- System Handlers ---
  /// Observables & Getters

  // Add Scoped Var Here...

  /// --- Functionality Handlers ---
  /// Observables & Getters
  var _qrcode = ''.obs;

  String get qrcode => _qrcode.value;




  var _data = DashboardModel().obs;
  DashboardModel get data => this._data.value;

  var _categories = <CategoryElementModel>[].obs;

  List<CategoryElementModel> get categories => this._categories;
  var _featuredDoctors = <FeaturedDoctorModel>[].obs;

  List<FeaturedDoctorModel> get featuredDoctors => this._featuredDoctors;

  var _isLoading = false.obs;

  bool get isLoading => this._isLoading.value;

  var _indexData = DashboardModel().obs;

  DashboardModel get indexData => _indexData.value;

  var _showData = DashboardModel().obs;

  DashboardModel get showData => _showData.value;

  /// Variables
  TextEditingController taskInput = TextEditingController();



  @override
  void onInit() async{
    auth.getUser();
    getData();
    index();

    _scrollController = ScrollController();
    super.onInit();
    _qrcode.value = '${auth.user.id}';
  }



  /// --- Core Functionalities Methods ---

  // Index
  Future<void> index({bool refresh = false}) async {
    try {
      setBusy(true);
      _dashboardService.init();

      /// Call Service to Get API Response
      ApiResponse response = await _dashboardService.index();

      /// Checking Response Error
      if (response.hasError()) {
        Toastr.show(message: "${response.message}");
        setBusy(false);
        return;
      }

      /// Add Response Data To Variables
      if (response.hasData()) {
        _indexData(DashboardModel.fromJson(response.data));
      }
      _dashboardService.close();
      setBusy(false);
    } on Exception catch (e) {
      print(e);
    }
  }

  //Show
  Future<void> show({bool refresh = false}) async {
    try {
      setBusy(true);
      _dashboardService.init();

      /// Call Service to Get API Response
      ApiResponse response =
          await _dashboardService.show(id: auth.user.id!.toInt());

      /// Checking Response Error
      if (response.hasError()) {
        Toastr.show(message: "${response.message}");
        setBusy(false);
        return;
      }

      /// Add Response Data To Variables
      if (response.hasData()) {
        _showData(DashboardModel.fromJson(response.data));
      }

      _dashboardService.close();
      setBusy(false);
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<void> getData() async {
    try {
      setBusy(true);
      ApiResponse response = await _dashboardService.index();

      if (response.hasError()) {
        Toastr.show(message: "${response.message}");
        setBusy(false);
        return;
      }

      if (response.hasData()) {
        _categories.assignAll(List<CategoryElementModel>.from(response
            .data['categories']
            .map((e) => CategoryElementModel.fromJson(e))));
        _featuredDoctors.assignAll(List<FeaturedDoctorModel>.from(response
            .data['featured_doctors']
            .map((e) => FeaturedDoctorModel.fromJson(e))));
      }

      setBusy(false);
    } on Exception catch (e) {
      print(e);
    }
  }



  //Delete
  Future<void> delete({bool refresh = false}) async {
    try {
      setBusy(true);
      _dashboardService.init();
      /// Call Service to Get API Response
      ApiResponse response =
          await _dashboardService.delete(id: auth.user.id!.toInt());

      /// Checking Response Error
      if (response.hasError()) {
        Toastr.show(message: "${response.message}");
        setBusy(false);
        return;
      }

      /// Refresh Index Data
      index(refresh: true);

      _dashboardService.close();
      setBusy(false);
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<void> storePatientAttendance(patientId) async {
    Map<String, dynamic> body = {
      "patient_id": patientId,
      "remark": "",
    };
    ApiResponse response =
        await _dashboardService.storePatientAttendance(body: body);
    if (response.hasError()) {
      Toastr.show(message: "${response.message}");
      return;
    }
    Toastr.show(message: "Invalid QR code");
  }

  /// --- Common Functionalities Methods ---
  // Here you can add a scoped method...

  /// --- Supporting Functionalities Methods ---
  String scannedQrcode = '';

  Future<void> scanQR() async {
    try {
      scannedQrcode = await FlutterBarcodeScanner.scanBarcode(
          '#0095b6', 'Cancel', true, ScanMode.QR);
      log.w(scannedQrcode);
      if (scannedQrcode != '-1') {
        await storePatientAttendance(scannedQrcode);
      } else {
        Toastr.show(message: "We could not locate the patient");
      }
    } on PlatformException {}
  }

  /// --- Form Functionalities Methods ---
  // Here you can add a scoped method...
  /// Mock Data
  List<Map<String, String>> imageListPatient = [
    {
      "id": "about_cancer",
      "image": "assets/icons/about-cancer.jpg",
    },
    {
      "id": "money_matters",
      "image": "assets/icons/home-banner-5.png",
    },
    {
      "id": "oncofix_screening",
      "image": "assets/icons/risk-assessment.jpg",
    },
    {
      "id": "doctor_list",
      "image": "assets/icons/doctor_slider_banner1.jpg",
    },
  ];

  List<Map<String, String>> imageListDoctor = [
    {
      "id": "about_cancer",
      "image": "assets/icons/about-cancer.jpg",
    },
    {
      "id": "clinical_trial",
      "image": "assets/icons/clinical-trial.jpg",
    },
    {
      "id": "oncofix_screening",
      "image": "assets/icons/risk-assessment.jpg",
    },
    {
      "id": "explore",
      "image": "assets/icons/youtube-bnr.jpg",
    },
  ];
}
