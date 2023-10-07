import 'package:flutter/material.dart';
import 'package:ui_x/helpers/ColorPalette.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: kcWhite,
        child: Center(
          child: CircularProgressIndicator(
            color: kcInfo,
          ),
        ),
      ),
    );
  }
}
