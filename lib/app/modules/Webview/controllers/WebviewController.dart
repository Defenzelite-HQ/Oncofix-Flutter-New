/*
@category ZStarter Flutter
@ref     Defenzelite Product
@author  <Defenzelite hq@defenzelite.com>
@license <https://www.defenzelite.com Defenzelite Private Limited>
@version <zStarter: 202310-V1.2>
@link    <https://www.defenzelite.com>
*/

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_webview_pro/webview_flutter.dart';
import 'package:get/get.dart';
import 'package:ui_x/helpers/Toastr.dart';
import 'dart:io' show Platform;
import '../../../shared/controllers/AppController.dart';
import '../../../shared/views/errors/ServerErrorPage.dart';
import '../services/WebviewService.dart';
import 'package:http/http.dart' as http;

class WebviewController extends AppController {
  /// Create and get the instance of the controller
  static WebviewController get instance {
    if (!Get.isRegistered<WebviewController>()) Get.put(WebviewController());
    return Get.find<WebviewController>();
  }

  /// Initialise [WebviewModule] service
  final WebviewService _webviewService = WebviewService.instance;

  /// Observables
  var _pageTitle = "Webview".obs;
  var _url = ''.obs;
  var _tasks = RxList<Map<String, dynamic>>([]);
  var _loadingPercentage = 0.obs;

  /// Getters
  String get pageTitle => _pageTitle.value;

  String get url => _url.value;

  List<Map<String, dynamic>> get tasks => _tasks;

  int get loadingPercentage => _loadingPercentage.value;

  /// Variables
  TextEditingController taskInput = TextEditingController();

  @override
  void onInit() {
    if (kIsWeb) {

    }
    super.onInit();
    _url(Get.parameters['url']);
    _pageTitle(Get.parameters['title']);

    /// This Code are most important to WebView Copy
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    setBusy(true);
    for (int i in Iterable.generate(5)) {
      _tasks.add({'id': i + 1, 'task': "Task no. $i", "completed": false});
    }
    setBusy(false);
  }

  void onLoadingPercent(int value) {
    _loadingPercentage(value);
  }

  Future<void> saveTask() async {
    try {
      if (taskInput.text.isEmpty) {
        Toastr.show(message: "Please enter a task to continue!");
        return;
      }
      await Future.delayed(1.seconds);
      _tasks.add({
        "id": _tasks.last['id'] + 1,
        "task": taskInput.text,
        "completed": false,
      });
      taskInput.clear();
    } on Exception catch (e) {
      Get.to(ServerErrorPage(message: "$e"));
    }
  }

  void toggleTask(int id) async {
    try {
      _tasks
          .where((t) => t['id'] == id)
          .first
          .update("completed", (value) => value = !value);
      _tasks.refresh();
    } on Exception catch (e) {
      Get.to(ServerErrorPage(message: "$e"));
    }
  }

  void removeTask(int index) async {
    try {
      _tasks.removeAt(index);
    } on Exception catch (e) {
      Get.to(ServerErrorPage(message: "$e"));
    }
  }
}
