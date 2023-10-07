import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

import '../../ui_x.dart';

class FormInputDateRange extends StatelessWidget {
  FormInputDateRange({Key? key, this.onChanged, required this.startDate, required this.endDate, this.suffixIcon, this.initialRange, this.dateFormat})
      : super(key: key);

  final DateTime startDate;
  final DateTime endDate;
  final DateTimeRange? initialRange;

  final Icon? suffixIcon;
  final Function(DateTimeRange?)? onChanged;
  final String? dateFormat;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        DateTimeRange? result = await showDateRangePicker(
          context: context,
          firstDate: startDate,
          lastDate: endDate,
          initialDateRange: initialRange,
          initialEntryMode: DatePickerEntryMode.calendar,
          builder: (context, Widget? child) => Theme(
            data: Theme.of(context).copyWith(
              appBarTheme: Theme.of(context).appBarTheme.copyWith(
                    iconTheme: Theme.of(context).appBarTheme.iconTheme!.copyWith(color: Colors.white),
                  ),
            ),
            child: child!,
          ),
        );

        if (result != null) {
          onChanged!(result);
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: kcWhite,
          border: Border.all(color: Colors.black.withOpacity(0.25), width: 1.0),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            Text(
              "${initialRange?.start.formatIt(dateFormat ?? 'dd MMM, yyyy')} - ${initialRange?.end.formatIt(dateFormat ?? 'dd MMM, yyyy')}",
              style: TextStyl.bodySm,
            ),
            Spacer(),
            suffixIcon ??
                Icon(
                  Icons.date_range_outlined,
                  size: 18,
                )
          ],
        ),
      ),
    );
  }
}

extension DateRangeExt on DateTime {
  String formatIt(String format) {
    return Jiffy(this.toString()).format(format);
  }
}
