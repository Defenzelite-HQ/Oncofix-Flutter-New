import 'package:flutter/material.dart';
import 'package:ui_x/ui_x.dart';

class TabPillWidget extends StatelessWidget {
  ///
  /// Ex:
  ///  TabPillWidget(
  ///         onTap: () {},
  ///         label: "",
  ///         image: Image.asset(""),
  ///         active: true,
  ///       ),
  ///
  const TabPillWidget(
      {Key? key,
      required this.label,
      required this.onTap,
      this.active = false,
      this.image})
      : super(key: key);
  final String label;
  final VoidCallback onTap;
  final bool active;
  final Widget? image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: active ? kcPrimary : kcOffWhite,
          borderRadius: BorderRadius.circular(spacer2),
        ),
        margin: const EdgeInsets.only(right: spacer2),
        padding:
            const EdgeInsets.symmetric(vertical: spacer2, horizontal: spacer5),
        child: Text(
          "$label",
          style: TextStyl.bodySm?.copyWith(color: active ? kcWhite : kcDark),
        ),
      ),
    );
  }
}
