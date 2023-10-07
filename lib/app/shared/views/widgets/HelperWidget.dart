import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_x/ui_x.dart';

class HelperWidget extends StatelessWidget {
  const HelperWidget({Key? key, this.title = "Title here", this.description, this.children}) : super(key: key);
  final String title;
  final String? description;
  final List<Widget>? children;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          color: kcWhite,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Positioned(
              right: 0.0,
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Align(
                  alignment: Alignment.topRight,
                  child: CircleAvatar(
                    radius: 14.0,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.close,
                      color: Colors.red,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ),
            Text(
              "$title",
              style: TextStyl.subtitle?.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 12),
            if (description != null)
              Text(
                "$description",
                style: TextStyl.body,
              ),
            if (children != null) ...children!,

          ],
        ),
      ),
    );
  }
}
