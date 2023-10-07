import 'package:flutter/material.dart';
import 'package:ui_x/helpers/ColorPalette.dart';
import 'package:ui_x/helpers/TextStyl.dart';

class TableWidget extends StatelessWidget {
  const TableWidget(
      {super.key,
      this.child,
      this.title = "",
      this.style,
      this.padding,
      this.color,
      this.backgroundColor = false});

  final Widget? child;
  final String? title;
  final TextStyle? style;
  final EdgeInsets? padding;
  final Color? color;
  final bool backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: backgroundColor
          ? BoxDecoration(
              color: kcDarkAlt, border: Border.all(color: kcWhite))
          : BoxDecoration(border: Border.all(color: kcWhite)),
      padding: padding ?? const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (child != null) child!,
          if (title != "")
            Text(
              "$title",
              style: style ??
                  TextStyl.bodySm?.copyWith(
                      color: color ?? kcBlack, fontWeight: FontWeight.w500),
            ),
        ],
      ),
    );
  }
}
