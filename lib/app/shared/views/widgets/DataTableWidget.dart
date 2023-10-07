import 'package:flutter/material.dart';
import 'package:ui_x/helpers/ColorPalette.dart';
import 'package:ui_x/helpers/TextStyl.dart';
import '../../../helpers/Global.dart';
import 'TableWidget.dart';

class DataTableWidget extends StatelessWidget {
  const DataTableWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Table(
          // defaultColumnWidth:
          //     FixedColumnWidth(80.0),
          defaultColumnWidth: IntrinsicColumnWidth(),
          columnWidths: {
            0: FixedColumnWidth(48.0), // fixed to 100 width
            1: FixedColumnWidth(100.0),
            2: FixedColumnWidth(100.0), //fixed to 100 width
            4: FixedColumnWidth(100.0), //fixed to 100 width
          },
          border: TableBorder.symmetric(
            outside: BorderSide(
                color: kcDarkAlt.withOpacity(0.4),
                style: BorderStyle.solid,
                width: 1),
          ),
          children: [
            TableRow(
                decoration: BoxDecoration(
                  color: kcDarkAlt,
                ),
                children: [
                  TableWidget(
                    title: "Sno.",
                    style: TextStyl.bodySm?.copyWith(
                        color: kcWhite,
                        fontWeight: FontWeight.w600),
                  ),
                  TableWidget(
                    title: "Project",
                    style: TextStyl.bodySm?.copyWith(
                        color: kcWhite,
                        fontWeight: FontWeight.w600),
                  ),
                  TableWidget(
                    title: "Deadline",
                    style: TextStyl.bodySm?.copyWith(
                        color: kcWhite,
                        fontWeight: FontWeight.w600),
                  ),
                  TableWidget(
                    title: "Disc",
                    style: TextStyl.bodySm?.copyWith(
                        color: kcWhite,
                        fontWeight: FontWeight.w600),
                  ),
                  TableWidget(
                    title: "Tax",
                    style: TextStyl.bodySm?.copyWith(
                        color: kcWhite,
                        fontWeight: FontWeight.w600),
                  ),
                  TableWidget(
                    title: "Total",
                    style: TextStyl.bodySm?.copyWith(
                        color: kcWhite,
                        fontWeight: FontWeight.w600),
                  ),
                ]),

            /// Items List
            TableRow(children: [
              TableWidget(
                title: "1",
              ),
              TableWidget(
                title: "Kaam Milega",
              ),

              TableWidget(
                title: "₹2,000",
              ),
              TableWidget(
                title: "₹10.00",
              ),
              TableWidget(
                title: "10% (excl)",
              ),
              TableWidget(
                title: "₹990.00",
                style: TextStyl.bodySm?.copyWith(
                    color: kcBlack,
                    fontWeight: FontWeight.w600),
              ),
            ]),

            /// Sub Total
            TableRow(children: [
              TableWidget(
                title: "2",
              ),
              TableWidget(
                title: "Chalocab",
              ),
              TableWidget(
                title: "1 week Ago",
              ),
              TableWidget(
                title: "",
              ),
              TableWidget(
                title: "Sub Total",
              ),
              TableWidget(
                title: "₹990.00",
                style: TextStyl.bodySm?.copyWith(
                    color: kcBlack,
                    fontWeight: FontWeight.w600),
              ),
            ]),

            /// CGST
            TableRow(children: [
              TableWidget(
                title: "3",
              ),
              TableWidget(
                title: "Milan",
              ),
              TableWidget(
                title: "2 days ago",
              ),
              TableWidget(
                title: "",
              ),
              TableWidget(
                title: "CGST",
              ),
              TableWidget(
                title: "₹50.00",
                style: TextStyl.bodySm?.copyWith(
                    color: kcBlack,
                    fontWeight: FontWeight.w600),
              ),
            ]),

            /// SGST
            TableRow(children: [
              TableWidget(
                title: "4",
              ),
              TableWidget(
                title: "Hum Tum",
              ),
              TableWidget(
                title: "5 days ago",
              ),
              TableWidget(
                title: "",
              ),
              TableWidget(
                title: "SGST",
              ),
              TableWidget(
                title: "₹50.00",
                style: TextStyl.bodySm?.copyWith(
                    color: kcBlack,
                    fontWeight: FontWeight.w600),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
