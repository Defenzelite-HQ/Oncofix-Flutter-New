import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui_x/helpers/ColorPalette.dart';
import 'package:ui_x/helpers/Sizes.dart';
import 'package:ui_x/helpers/TextStyl.dart';
import '../../../../config/Config.dart';

class MasterLayout extends StatelessWidget {
  final Widget body;
  final Drawer? drawer;
  final Color? backgroundColor;
  final dynamic title;
  final Widget? floatingActionButton;
  final PreferredSize? preferredSize;
  final List<Widget>? action;
  final Widget? bottomNavigationBar;
  final Widget? leading;

  MasterLayout({
    Key? key,
    required this.body,
    this.leading,
    this.drawer,
    this.backgroundColor,
    this.title,
    this.floatingActionButton,
    this.preferredSize,
    this.bottomNavigationBar,
    this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        // For Android.
        // Use [light] for white status bar and [dark] for black status bar.
        statusBarIconBrightness: Brightness.light,
        // For iOS.
        // Use [dark] for white status bar and [light] for black status bar.
        statusBarBrightness: Brightness.dark,
      ),
      child: SafeArea(
        child: Scaffold(
          // backgroundColor: bodyBackgroundColor,
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            titleSpacing: 0,
            backgroundColor: kcPrimaryLight,
            elevation: 0,
            automaticallyImplyLeading: false,
            bottom: preferredSize,
            actions: action,
            leading: leading,
            title: title is Widget
                ? title
                : Text(
              "${title != null ? title : Config.appName}",
              style: TextStyl.label?.copyWith(
                color: kcWhite,
                fontSize: spacer5,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          drawer: drawer,
          body: SafeArea(
            child: body,
          ),
          bottomNavigationBar: bottomNavigationBar,
          floatingActionButton: floatingActionButton,
        ),
      ),
    );
  }
}
