import 'package:flutter/material.dart';
import 'package:ui_x/helpers/ColorPalette.dart';
import 'package:ui_x/widgets/buttons/Button.dart';
import '../../../helpers/Global.dart';


class ThankYouWidget extends StatelessWidget {
  const ThankYouWidget(
      {Key? key,
        required this.image,
        required this.title,
        required this.subtitle, required this.onTap, required this.buttonLable})
      : super(key: key);

  final String image;
  final String title;
  final String subtitle;
  final String buttonLable;
  final Function(ButtonController)? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      color: Colors.transparent,
      width: double.infinity,
      height: screen.height - 70,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "$image",
            height: 230,
          ),
          SizedBox(height: 25),
          Text(
            "$title",
            style: TextStyle(
                color: kcBlack, fontSize: 25, fontWeight: FontWeight.bold),
          ),
          Text(
            textAlign: TextAlign.center,
            "$subtitle",
            style: TextStyle(
                fontWeight: FontWeight.w500, color: kcBlack.withOpacity(0.6)),
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Button.block(
              key: UniqueKey(),
              variant: ButtonVariant.BLACK,
              label: "$buttonLable",
              onTap: onTap,),
          ),
        ],
      ),
    );
  }
}