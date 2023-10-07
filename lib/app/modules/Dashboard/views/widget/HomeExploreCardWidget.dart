import 'package:flutter/material.dart';
import 'package:ui_x/helpers/ColorPalette.dart';
import 'package:ui_x/helpers/Sizes.dart';
import 'package:ui_x/helpers/TextStyl.dart';

import '../../../../helpers/Global.dart';

class HomeExploreCardWidget extends StatelessWidget {
  const HomeExploreCardWidget(
      {super.key,
      this.onTap,
      this.image = "",
      required this.label,
      this.count = "0",
      this.maxLines,
      this.width,
      this.color});

  final VoidCallback? onTap;
  final String image;
  final String count;
  final String label;
  final int? maxLines;
  final double? width;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.all(3.0),
        padding: const EdgeInsets.all(3.0),
        decoration: BoxDecoration(
          color: color ?? kcWhite,
          border: Border.all(
            color: kcGray.withOpacity(0.5),
          ),
          borderRadius: BorderRadius.all(
              Radius.circular(6.0) //                 <--- border radius here
              ),
        ),
        width: width ?? screen.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              image != ""
                  ? Image.asset(
                      "$image",
                      height: 40,
                      width: 40,
                      fit: BoxFit.cover,
                    )
                  : Text(
                      "${formattedTotalAmount(count)}",
                      style: TextStyl.body
                          ?.copyWith(color: kcPrimary, fontSize: 20),
                    ),
              SizedBox(
                height: 5,
              ),
              Text(
                "$label",
                style: TextStyl.label!.copyWith(
                    color: kcSecondary,
                    fontSize: spacer4 / 1.3,
                    fontWeight: FontWeight.w500,
                    overflow: TextOverflow.ellipsis),
                textAlign: TextAlign.center,
                maxLines: maxLines ?? 1,
              ),
            ],
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}
