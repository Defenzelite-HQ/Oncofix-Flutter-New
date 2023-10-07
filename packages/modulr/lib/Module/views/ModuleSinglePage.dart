const String stub = """
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_x/ui_x.dart';
import '../../../shared/views/errors/NotConnectedErrorPage.dart';
import '../../../shared/views/layouts/MasterLayout.dart';
import '../../../shared/views/widgets/LoadingIconWidget.dart';
import '../controllers/{CONTROLLER}Controller.dart';

class {MODULE}Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<{CONTROLLER}Controller>(
      init: {CONTROLLER}Controller(),
      builder: ({CONTROLLER}Controller controller) {
        return !controller.isConnected
            ? NotConnectedErrorPage()
            : controller.isBusy
                ? LoadingIconWidget(message: "Please wait...")
                : MasterLayout(
                    title: "{MODULE}",
                    body: SafeArea(
                      child: Container(
                        child: Text("Build awesome page here."), 
                      ),
                    ),
                  );
      },
    );
  }
}
""";
