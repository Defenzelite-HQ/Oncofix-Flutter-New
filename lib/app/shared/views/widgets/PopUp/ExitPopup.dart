import 'dart:io';
import 'package:flutter/material.dart';
import 'package:ui_x/helpers/ColorPalette.dart';
import 'package:ui_x/helpers/Sizes.dart';
import 'package:ui_x/helpers/TextStyl.dart';




///Dialog::::::::::::::::::::::
///
///WillPopScope(
///   onWillPop: () => showExitPopup(context),
/// child:
/// );
Future<bool> showExitPopup(context) async {
  return await showDialog( //show confirm dialogue
    context: context,
    builder: (context) =>
        Dialog(
          backgroundColor: kcWhite,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: spacer8, horizontal: spacer).copyWith(bottom: 4),
            decoration: BoxDecoration(
              color: kcWhite,
              borderRadius: BorderRadius.circular(spacer2),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Exit App",
                  style: TextStyl.subtitle?.copyWith(fontSize: 18),
                ),
                const SizedBox(height: spacer1),
                Text(
                  "Do you want to exit an App?",
                  style: TextStyl.bodySm?.copyWith(color: kcDarkAlt),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: spacer5),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        style: TextButton.styleFrom(backgroundColor: Colors.transparent),
                        child: Text(
                          "Cancel",
                          style: TextStyl.button?.copyWith(color: kcDarkAlt),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                      ),
                    ),
                    const SizedBox(width: spacer3),
                    Expanded(
                      child: TextButton(
                        style: TextButton.styleFrom(backgroundColor: Colors.transparent),
                        child: Text(
                          "Exit",
                          style: TextStyl.button?.copyWith(color: kcDanger),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
  ) ?? false;
}
  //
  //       Future<bool> showExitPopup(context) async{
  // return await showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         content: Container(
  //           height: 90,
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text("Do you want to exit an App?"),
  //               SizedBox(height: 20),
  //               Row(
  //                 children: [
  //                   Expanded(
  //                     child: ElevatedButton(
  //                       onPressed: () {
  //                         print('yes selected');
  //                         exit(0);
  //                       },
  //                       child: Text("Yes"),
  //                       style: ElevatedButton.styleFrom(
  //                           primary: kcPrimary),
  //                     ),
  //                   ),
  //                   SizedBox(width: 15),
  //                   Expanded(
  //                       child: ElevatedButton(
  //                         onPressed: () {
  //                           print('no selected');
  //                           Navigator.of(context).pop();
  //                         },
  //                         child: Text("No", style: TextStyle(color: kcWhite)),
  //                         style: ElevatedButton.styleFrom(
  //                           primary: kcPrimary,
  //                         ),
  //                       ))
  //                 ],
  //               )
  //             ],
  //           ),
  //         ),
  //       );
  //

        // AlertDialog(
        //   title: Text('Exit App'),
        //   content: Text('Do you want to exit an App?'),
        //   actions:[
        //     ElevatedButton(
        //       onPressed: () => Navigator.of(context).pop(false),
        //       //return false when click on "NO"
        //       child:Text('No'),
        //     ),
        //
        //     ElevatedButton(
        //       onPressed: () => Navigator.of(context).pop(true),
        //       //return true when click on "Yes"
        //       child:Text('Yes'),
        //     ),
        //
        //   ],
        // );
