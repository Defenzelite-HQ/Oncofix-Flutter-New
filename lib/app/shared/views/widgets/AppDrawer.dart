import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_x/helpers/ColorPalette.dart';
import 'package:zstarter_flutter/app/helpers/Global.dart';


Drawer appDrawer(BuildContext context) {
  return Drawer(
    backgroundColor: kcWhite,
    child: ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            color: kcPrimary,
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/profile');
            },
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                        child: Image.asset(
                          'assets/systems/logo.png',
                          width: 100,
                          height: 100,
                          color: kcWhite,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        ListTile(
          leading: Image.asset(
            'assets/icons/category.png',
            color: kcPrimary,
            height: 20,
            width: 20,
          ),
          title: const Text(
            'Shop by Categories',
            style: TextStyle(fontSize: 16),
          ),
          onTap: () {
          },
        ),
        Divider(
          thickness: 0.5,
        ),
        ListTile(
          leading: Image.asset(
            'assets/icons/market.png',
            color: kcPrimary,
            height: 25,
            width: 25,
          ),
          title: const Text(
            'Orders',
            style: TextStyle(fontSize: 16),
          ),
          onTap: () {
            auth.logout();
            // Get.toNamed('/order');
          },
        ),
        Divider(
          thickness: 0.5,
        ),
      ],
    ),
  );
}
