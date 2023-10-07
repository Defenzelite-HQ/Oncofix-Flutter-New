import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ui_x/helpers/ColorPalette.dart';

class SettingPageWidget extends StatelessWidget {
  const SettingPageWidget({Key? key, required this.title, this.subTitle, this.onTap, required this.image}) : super(key: key);

  final VoidCallback? onTap;
  final String title;
  final String? subTitle;
  final String image;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(
                '$image',
                color: kcBlack,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "$title",
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 35,
              ),
              Flexible(
                child: Text(
                  "$subTitle",
                  style: TextStyle(fontSize: 14, color: kcDarkAlt),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            thickness: 1,
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
