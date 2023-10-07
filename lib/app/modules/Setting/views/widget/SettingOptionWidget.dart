import 'package:flutter/material.dart';
import 'package:ui_x/ui_x.dart';

import '../../../../shared/views/widgets/Translated.dart';

class SettingOptionWidget extends StatelessWidget {
  const SettingOptionWidget({Key? key, this.icon, required this.label, this.trailing}) : super(key: key);

  final Widget? icon;
  final String label;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if(icon != null) icon!,
        if(icon != null) SizedBox(width: spacer2),
        Translated(
          child: Text(
            "$label",
            style: TextStyl.body!.copyWith(
              color: kcSecondary,
            ),
          ),
        ),
        Spacer(),
        if(trailing != null) trailing!,
      ],
    );
  }
}
