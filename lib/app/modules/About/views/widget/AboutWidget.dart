import 'package:flutter/material.dart';

class AboutWidget extends StatelessWidget {
  const AboutWidget({Key? key, required this.about, required this.onTap}) : super(key: key);

  final String about;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
        child: Row(
          children: [
            Text("$about"),
            Spacer(),
            Icon(Icons.arrow_forward_ios_sharp)
          ],
        ),
      ),
    );
  }
}
