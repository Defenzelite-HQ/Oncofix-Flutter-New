import 'package:flutter/material.dart';
import 'package:ui_x/ui_x.dart';
import '../../../shared/views/layouts/MasterLayout.dart';
import '../../../shared/views/widgets/ThankyouWidget.dart';

class ThankyouPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MasterLayout(
      title: "Thank you!",
      backgroundColor: kcWhite,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: spacer),
        child: ThankYouWidget(
          onTap: (btn) {
            btn.setBusy(true).setDisabled(true);
            btn.setBusy(false).setDisabled(false);
          },
          image: 'assets/placeholders/thank-you.png',
          title: 'Thank You!',
          subtitle:
              'Thanks for Making your payment your product will be delivered soon...',
          buttonLable: 'Go to Dashboard',
        ),
      ),
    );
  }
}
