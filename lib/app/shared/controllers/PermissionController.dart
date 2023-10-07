import 'dart:io';

import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import 'AppController.dart';

class PermissionController extends AppController {
  /// Create and get the instance of the controller
  static PermissionController get instance {
    if (!Get.isRegistered<PermissionController>())
      Get.put(PermissionController());
    return Get.find<PermissionController>();
  }

  /// Observables

  /// Getters

  @override
  void onInit() async {
    super.onInit();
  }

  /// ======================
  /// Permission Access
  /// ======================
  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      } else if (result == PermissionStatus.denied) {
        return false;
      }
    }
    return false;
  }

  /// ======================
  /// Storage Permission Access
  /// ======================
  void storagePermission() async {
    _requestPermission(Permission.storage);
  }

  /// ======================
  /// Location Permission Access
  /// ======================
  Future<void> locationPermission() async {
    await _requestPermission(Permission.location);
  }

  /// ======================
  /// Camera Permission Access
  /// ======================
  void cameraPermission() async {
    await _requestPermission(Permission.camera);
  }

  /// ======================
  /// Audio Permission Access
  /// ======================
  void audioPermission() async {
    await _requestPermission(Permission.microphone);
  }

  /// ======================
  /// Notification Permission Access
  /// ======================
  void notificationPermission() async {
    await _requestPermission(Permission.notification);
  }

  /// ======================
  /// accessMediaLocation Permission Access
  /// ======================
  void accessMediaLocationPermission() async {
    await _requestPermission(Permission.accessMediaLocation);
  }

  /// ======================
  /// accessNotificationPolicy Permission Access
  /// ======================
  void accessNotificationPolicyPermission() async {
    await _requestPermission(Permission.accessNotificationPolicy);
  }

  /// ======================
  /// activityRecognition Permission Access
  /// ======================
  void activityRecognitionPermission() async {
    await _requestPermission(Permission.activityRecognition);
  }

  /// ======================
  /// appTrackingTransparency Permission Access
  /// ======================
  void appTrackingTransparencyPermission() async {
    await _requestPermission(Permission.appTrackingTransparency);
  }

  /// ======================
  /// bluetoothAdvertise Permission Access
  /// ======================
  void bluetoothAdvertisePermission() async {
    await _requestPermission(Permission.bluetoothAdvertise);
  }

  /// ======================
  /// bluetoothConnect Permission Access
  /// ======================
  void bluetoothConnectPermission() async {
    await _requestPermission(Permission.bluetoothConnect);
  }

  /// ======================
  /// calendar Permission Access
  /// ======================
  void calendarPermission() async {
    await _requestPermission(Permission.calendar);
  }

  /// ======================
  /// criticalAlerts Permission Access
  /// ======================
  void criticalAlertsPermission() async {
    await _requestPermission(Permission.criticalAlerts);
  }

  /// ======================
  /// ignoreBatteryOptimizations Permission Access
  /// ======================
  void ignoreBatteryOptimizationsPermission() async {
    await _requestPermission(Permission.ignoreBatteryOptimizations);
  }

  /// ======================
  /// manageExternalStorage Permission Access
  /// ======================
  void manageExternalStoragePermission() async {
    await _requestPermission(Permission.manageExternalStorage);
  }

  /// ======================
  /// nearbyWifiDevices Permission Access
  /// ======================
  void nearbyWifiDevicesPermission() async {
    await _requestPermission(Permission.nearbyWifiDevices);
  }

  /// ======================
  /// microphone Permission Access
  /// ======================
  void microphonePermission() async {
    await _requestPermission(Permission.microphone);
  }

  /// ======================
  /// photos Permission Access
  /// ======================
  void photosPermission() async {
    await _requestPermission(Permission.photos);
  }

  /// ======================
  /// sms Permission Access
  /// ======================
  void smsPermission() async {
    await _requestPermission(Permission.sms);
  }


}
