/*
@category ZStarter Flutter
@ref     Defenzelite Product
@author  <Defenzelite hq@defenzelite.com>
@license <https://www.defenzelite.com Defenzelite Private Limited>
@version <zStarter: 202310-V1.2>
@link    <https://www.defenzelite.com>
*/

import 'package:get/get.dart';
import '../../../shared/controllers/AppController.dart';
import '../../../helpers/Global.dart';
import '../../../models/ApiResponse.dart';
import '../services/NotificationService.dart';
import '../models/NotificationModel.dart';
// Third Party Packages
import 'package:flutter/cupertino.dart';
import 'package:ui_x/helpers/Toastr.dart';

class NotificationController extends AppController {
   /// Creating Global Instance
  static NotificationController get instance {
    if (!Get.isRegistered<NotificationController>()) Get.put(NotificationController());
    return Get.find<NotificationController>();
  }

  /// Initialise [NotificationService] service
  final NotificationService _notificationService = NotificationService.instance;
  
   /// Initialize For Global Usage (Once per app run)
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  
  
   /// --- System Handlers ---
  /// Observables & Getters
 
  // Add Scoped Var Here...

  /// --- Functionality Handlers ---
  /// Observables & Getters
  var _indexData = NotificationModel().obs;
  NotificationModel get indexData => _indexData.value;
  
  var _showData = NotificationModel().obs;
  NotificationModel get showData => _showData.value;
  
  /// Variables
  TextEditingController taskInput = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    index();
  }
  
 /// --- Core Functionalities Methods ---


 
  // Index
  Future<void> index({bool refresh = false}) async {
    try {
      setBusy(true);
      _notificationService.init();

      /// Call Service to Get API Response
      ApiResponse response = await _notificationService.index();

      /// Checking Response Error
      if (response.hasError()) {
        Toastr.show(
            message: "${response.message}");
        setBusy(false);
        return;
      }

      /// Add Response Data To Variables
      if (response.hasData()) {
        _indexData(NotificationModel.fromJson(response.data));
      }
      _notificationService.close();
      setBusy(false);
    } on Exception catch (e) {
      print(e);
    }
  }

  //Show
  Future<void> show({bool refresh = false}) async {
    try {
      setBusy(true);
      _notificationService.init();

      /// Call Service to Get API Response
      ApiResponse response = await _notificationService.show(id: auth.user.id!.toInt());

      /// Checking Response Error
      if (response.hasError()) {
        Toastr.show(
            message: "${response.message}");
        setBusy(false);
        return;
      }

      /// Add Response Data To Variables
      if (response.hasData()) {
        _showData(NotificationModel.fromJson(response.data));
      }

      _notificationService.close();
      setBusy(false);
    } on Exception catch (e) {
      print(e);
    }
  }

  // Create
  Future<void> create({bool refresh = false}) async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    try {
      _notificationService.init();

       /// Prepare form data to be sent to server.
      Map<String, dynamic> body = {
        "task": taskInput.text,
      };

      /// Call Service to Get API Response
      ApiResponse response = await _notificationService.create(body: body);

      /// Checking Validation Errors
      if (response.hasValidationErrors()) {
        Toastr.show(
            message:
                "${response.validationError}");
        return;
      }

      /// Checking Response Error
      if (response.hasError()) {
        Toastr.show(
            message: "${response.message}"); 
        return;
      }

      _notificationService.close();
      Toastr.show(message: "${response.message}"); 
    } on Exception catch (e) {
      print(e);
    }
  }

  // Store
  Future<void> store({bool refresh = false}) async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    try {
      _notificationService.init();

     /// Prepare form data to be sent to server.
      Map<String, dynamic> body = {
        "task": taskInput.text,
      };

      /// Call Service to Get API Response
      ApiResponse response = await _notificationService.store(body: body);

      /// Checking Validation Errors
      if (response.hasValidationErrors()) {
        Toastr.show(
            message:
                "${response.validationError}");
        return;
      }

      /// Checking Response Error
      if (response.hasError()) {
        Toastr.show(
            message: "${response.message}"); 
        return;
      }

      _notificationService.close();
      Toastr.show(message: "${response.message}"); 
    } on Exception catch (e) {
      print(e);
    }
  }

  //Edit
  Future<void> edit({bool refresh = false}) async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    try {
      _notificationService.init();

       /// Prepare form data to be sent to server.
      Map<String, dynamic> body = {
        "task": taskInput.text,
      };

      /// Call Service to Get API Response
      ApiResponse response =
          await _notificationService.edit(body: body, id: auth.user.id!.toInt());

      /// Checking Validation Errors
      if (response.hasValidationErrors()) {
        Toastr.show(
            message:
                "${response.validationError}"); 
        return;
      }

      /// Checking Response Error
      if (response.hasError()) {
        Toastr.show(
            message: "${response.message}");
        return;
      }

      _notificationService.close();
      Toastr.show(message: "${response.message}"); 
    } on Exception catch (e) {
      print(e);
    }
  }

  // Update
  Future<void> patch({bool refresh = false}) async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    try {
      _notificationService.init();

       /// Prepare form data to be sent to server.
      Map<String, dynamic> body = {
        "task": taskInput.text,
      };

      /// Call Service to Get API Response
      ApiResponse response =
          await _notificationService.edit(body: body, id: auth.user.id!.toInt());

      /// Checking Validation Errors
      if (response.hasValidationErrors()) {
        Toastr.show(
            message:
                "${response.validationError}");
        return;
      }

      /// Checking Response Error
      if (response.hasError()) {
        Toastr.show(
            message: "${response.message}"); 
        return;
      }

      _notificationService.close();
      Toastr.show(message: "${response.message}"); 
    } on Exception catch (e) {
      print(e);
    }
  }

  //Delete
  Future<void> delete({bool refresh = false}) async {
    try {
      setBusy(true);
      _notificationService.init();

      /// Call Service to Get API Response
      ApiResponse response =
          await _notificationService.delete(id: auth.user.id!.toInt());

      /// Checking Response Error
      if (response.hasError()) {
        Toastr.show(
            message: "${response.message}"); 
        setBusy(false);
        return;
      }

      /// Refresh Index Data
      index(refresh: true);

      _notificationService.close();
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

