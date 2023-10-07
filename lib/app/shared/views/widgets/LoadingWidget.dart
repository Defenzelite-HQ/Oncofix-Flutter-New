import 'package:flutter/material.dart';
import 'package:ui_x/ui_x.dart';

class LoadingWidget extends StatelessWidget {
  ///
  /// Ex:
  ///
  /// LoadingWidget()
  ///
  LoadingWidget({Key? key, this.message = "Loading..."}) : super(key: key);
  final String message;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(horizontal: 32),
      decoration: BoxDecoration(
        color: kcWhite,
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 12),
            LoadingIcon(height: spacer, color: kcPrimary),
            SizedBox(height: 20),
            Text(
              "$message",
              style: TextStyl.body,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
