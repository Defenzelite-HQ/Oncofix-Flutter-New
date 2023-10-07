import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_x/ui_x.dart';

import '../../../shared/views/errors/NotConnectedErrorPage.dart';
import '../../../shared/views/layouts/MasterLayout.dart';
import '../../../shared/views/widgets/LoadingIconWidget.dart';
import '../controllers/CasesController.dart';

class CasesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CasesController>(
      init: CasesController(),
      builder: (CasesController controller) {
        return !controller.isConnected
            ? NotConnectedErrorPage()
            : controller.isBusy
                ? LoadingIconWidget(message: "Please wait...")
                : MasterLayout(
                    title: "Cases",
                    body: SafeArea(
                      child: Container(
                        child: Text("${controller.indexData.firstName} ${controller.indexData.lastName}"), 
                      ),
                    ),
                  );
      },
    );
  }
}

