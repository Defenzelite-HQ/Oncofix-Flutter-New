const String stub = """
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
import '../services/{MODULE}Service.dart';
import '../models/{MODULE}Model.dart';
// Third Party Packages
import 'package:flutter/cupertino.dart';
import 'package:ui_x/helpers/Toastr.dart';

class {MODULE}Controller extends AppController {
   /// Creating Global Instance
  static {MODULE}Controller get instance {
    if (!Get.isRegistered<{MODULE}Controller>()) Get.put({MODULE}Controller());
    return Get.find<{MODULE}Controller>();
  }

  /// Initialise [{MODULE}Service] service
  final {MODULE}Service _{CAMEL_MODULE}Service = {MODULE}Service.instance;
  
   /// Initialize For Global Usage (Once per app run)
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  
  
   /// --- System Handlers ---
  /// Observables & Getters
 
  // Add Scoped Var Here...

  /// --- Functionality Handlers ---
  /// Observables & Getters
  var _indexData = {MODULE}Model().obs;
  {MODULE}Model get indexData => _indexData.value;
  
  var _showData = {MODULE}Model().obs;
  {MODULE}Model get showData => _showData.value;
  
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
      _{CAMEL_MODULE}Service.init();

      /// Call Service to Get API Response
      ApiResponse response = await _{CAMEL_MODULE}Service.index();

      /// Checking Response Error
      if (response.hasError()) {
        Toastr.show(
            message: "{RESPONSE_MESSAGE}");
        setBusy(false);
        return;
      }

      /// Add Response Data To Variables
      if (response.hasData()) {
        _indexData({MODULE}Model.fromJson(response.data));
      }
      _{CAMEL_MODULE}Service.close();
      setBusy(false);
    } on Exception catch (e) {
      print(e);
    }
  }

  //Show
  Future<void> show({bool refresh = false}) async {
    try {
      setBusy(true);
      _{CAMEL_MODULE}Service.init();

      /// Call Service to Get API Response
      ApiResponse response = await _{CAMEL_MODULE}Service.show(id: auth.user.id!.toInt());

      /// Checking Response Error
      if (response.hasError()) {
        Toastr.show(
            message: "{RESPONSE_MESSAGE}");
        setBusy(false);
        return;
      }

      /// Add Response Data To Variables
      if (response.hasData()) {
        _showData({MODULE}Model.fromJson(response.data));
      }

      _{CAMEL_MODULE}Service.close();
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
      _{CAMEL_MODULE}Service.init();

       /// Prepare form data to be sent to server.
      Map<String, dynamic> body = {
        "task": taskInput.text,
      };

      /// Call Service to Get API Response
      ApiResponse response = await _{CAMEL_MODULE}Service.create(body: body);

      /// Checking Validation Errors
      if (response.hasValidationErrors()) {
        Toastr.show(
            message:
                "{RESPONSE_VALIDATION_ERROR}");
        return;
      }

      /// Checking Response Error
      if (response.hasError()) {
        Toastr.show(
            message: "{RESPONSE_MESSAGE}"); 
        return;
      }

      _{CAMEL_MODULE}Service.close();
      Toastr.show(message: "{RESPONSE_MESSAGE}"); 
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
      _{CAMEL_MODULE}Service.init();

     /// Prepare form data to be sent to server.
      Map<String, dynamic> body = {
        "task": taskInput.text,
      };

      /// Call Service to Get API Response
      ApiResponse response = await _{CAMEL_MODULE}Service.store(body: body);

      /// Checking Validation Errors
      if (response.hasValidationErrors()) {
        Toastr.show(
            message:
                "{RESPONSE_VALIDATION_ERROR}");
        return;
      }

      /// Checking Response Error
      if (response.hasError()) {
        Toastr.show(
            message: "{RESPONSE_MESSAGE}"); 
        return;
      }

      _{CAMEL_MODULE}Service.close();
      Toastr.show(message: "{RESPONSE_MESSAGE}"); 
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
      _{CAMEL_MODULE}Service.init();

       /// Prepare form data to be sent to server.
      Map<String, dynamic> body = {
        "task": taskInput.text,
      };

      /// Call Service to Get API Response
      ApiResponse response =
          await _{CAMEL_MODULE}Service.edit(body: body, id: auth.user.id!.toInt());

      /// Checking Validation Errors
      if (response.hasValidationErrors()) {
        Toastr.show(
            message:
                "{RESPONSE_VALIDATION_ERROR}"); 
        return;
      }

      /// Checking Response Error
      if (response.hasError()) {
        Toastr.show(
            message: "{RESPONSE_MESSAGE}");
        return;
      }

      _{CAMEL_MODULE}Service.close();
      Toastr.show(message: "{RESPONSE_MESSAGE}"); 
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
      _{CAMEL_MODULE}Service.init();

       /// Prepare form data to be sent to server.
      Map<String, dynamic> body = {
        "task": taskInput.text,
      };

      /// Call Service to Get API Response
      ApiResponse response =
          await _{CAMEL_MODULE}Service.edit(body: body, id: auth.user.id!.toInt());

      /// Checking Validation Errors
      if (response.hasValidationErrors()) {
        Toastr.show(
            message:
                "{RESPONSE_VALIDATION_ERROR}");
        return;
      }

      /// Checking Response Error
      if (response.hasError()) {
        Toastr.show(
            message: "{RESPONSE_MESSAGE}"); 
        return;
      }

      _{CAMEL_MODULE}Service.close();
      Toastr.show(message: "{RESPONSE_MESSAGE}"); 
    } on Exception catch (e) {
      print(e);
    }
  }

  //Delete
  Future<void> delete({bool refresh = false}) async {
    try {
      setBusy(true);
      _{CAMEL_MODULE}Service.init();

      /// Call Service to Get API Response
      ApiResponse response =
          await _{CAMEL_MODULE}Service.delete(id: auth.user.id!.toInt());

      /// Checking Response Error
      if (response.hasError()) {
        Toastr.show(
            message: "{RESPONSE_MESSAGE}"); 
        setBusy(false);
        return;
      }

      /// Refresh Index Data
      index(refresh: true);

      _{CAMEL_MODULE}Service.close();
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
""";
