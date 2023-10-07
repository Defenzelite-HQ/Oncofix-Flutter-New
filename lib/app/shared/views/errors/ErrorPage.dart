import 'package:flutter/material.dart';
import 'package:ui_x/ui_x.dart';

import '../../../shared/views/layouts/MasterLayout.dart';
import '../widgets/ServerErrorPage.dart';

class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MasterLayout(
      title: "Server Error",
      backgroundColor: kcWhite,
      body: ServerErrorPage(
        message: "404 error",
      ),
    );
  }
}
