const String stub = """
import 'package:get/get.dart';
import '../../../shared/controllers/AppController.dart';
import '../../../helpers/Global.dart';
import '../../../models/ApiResponse.dart';
import '../services/{SERVICE}Service.dart';
import '../models/{SERVICE}Model.dart';
// Third Party Packages
import 'package:flutter/cupertino.dart';
import 'package:ui_x/helpers/Toastr.dart';

class {MODULE}Controller extends AppController {
   /// Creating Global Instance
  static {MODULE}Controller get instance {
    if (!Get.isRegistered<{MODULE}Controller>()) Get.put({MODULE}Controller());
    return Get.find<{MODULE}Controller>();
  }

  /// Initialise [{SERVICE}Service] service
  final {SERVICE}Service _{CAMEL_SERVICE}Service = {SERVICE}Service.instance;
  
   /// Initialize For Global Usage (Once per app run)
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  
  
   /// --- System Handlers ---
  /// Observables & Getters
 
  // Add Scoped Var Here...

  /// --- Functionality Handlers ---
  /// Observables & Getters
  var _indexData = {SERVICE}Model().obs;
  {SERVICE}Model get indexData => _indexData.value;
  
  var _showData = {SERVICE}Model().obs;
  {SERVICE}Model get showData => _showData.value;
  
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
      _{CAMEL_SERVICE}Service.init();

      /// Call Service to Get API Response
      ApiResponse response = await _{CAMEL_SERVICE}Service.index();

      /// Checking Response Error
      if (response.hasError()) {
        Toastr.show(
            message: "{RESPONSE_MESSAGE}");
        setBusy(false);
        return;
      }

      /// Add Response Data To Variables
      if (response.hasData()) {
        _indexData({SERVICE}Model.fromJson(response.data));
      }
      _{CAMEL_SERVICE}Service.close();
      setBusy(false);
    } on Exception catch (e) {
      print(e);
    }
  }

  //Show
  Future<void> show({bool refresh = false}) async {
    try {
      setBusy(true);
      _{CAMEL_SERVICE}Service.init();

      /// Call Service to Get API Response
      ApiResponse response = await _{CAMEL_SERVICE}Service.show(id: auth.user.id!.toInt());

      /// Checking Response Error
      if (response.hasError()) {
        Toastr.show(
            message: "{RESPONSE_MESSAGE}");
        setBusy(false);
        return;
      }

      /// Add Response Data To Variables
      if (response.hasData()) {
        _showData({SERVICE}Model.fromJson(response.data));
      }

      _{CAMEL_SERVICE}Service.close();
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
      _{CAMEL_SERVICE}Service.init();

      /// Create Map Body
      Map<String, dynamic> body = {
        "task": taskInput.text,
      };

      /// Call Service to Get API Response
      ApiResponse response = await _{CAMEL_SERVICE}Service.create(body: body);

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

      _{CAMEL_SERVICE}Service.close();
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
      _{CAMEL_SERVICE}Service.init();

      /// Create Map Body
      Map<String, dynamic> body = {
        "task": taskInput.text,
      };

      /// Call Service to Get API Response
      ApiResponse response = await _{CAMEL_SERVICE}Service.store(body: body);

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

      _{CAMEL_SERVICE}Service.close();
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
      _{CAMEL_SERVICE}Service.init();

      /// Create Map Body
      Map<String, dynamic> body = {
        "task": taskInput.text,
      };

      /// Call Service to Get API Response
      ApiResponse response =
          await _{CAMEL_SERVICE}Service.edit(body: body, id: auth.user.id!.toInt());

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

      _{CAMEL_SERVICE}Service.close();
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
      _{CAMEL_SERVICE}Service.init();

      /// Create Map Body
      Map<String, dynamic> body = {
        "task": taskInput.text,
      };

      /// Call Service to Get API Response
      ApiResponse response =
          await _{CAMEL_SERVICE}Service.edit(body: body, id: auth.user.id!.toInt());

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

      _{CAMEL_SERVICE}Service.close();
      Toastr.show(message: "{RESPONSE_MESSAGE}"); 
    } on Exception catch (e) {
      print(e);
    }
  }

  //Delete
  Future<void> delete({bool refresh = false}) async {
    try {
      setBusy(true);
      _{CAMEL_SERVICE}Service.init();

      /// Call Service to Get API Response
      ApiResponse response =
          await _{CAMEL_SERVICE}Service.delete(id: auth.user.id!.toInt());

      /// Checking Response Error
      if (response.hasError()) {
        Toastr.show(
            message: "{RESPONSE_MESSAGE}"); 
        setBusy(false);
        return;
      }

      /// Refresh Index Data
      index(refresh: true);

      _{CAMEL_SERVICE}Service.close();
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
