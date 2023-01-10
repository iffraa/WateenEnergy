import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../utils/AppScale.dart';
import '../utils/colour.dart';

class DateRangePicker extends StatefulWidget {
  final String data;
  final Function(String) onClickAction;
  static const routeName = '/date';

  const DateRangePicker(this.data, this.onClickAction);

  @override
  State<DateRangePicker> createState() => _DateRangePickerState();
}

class _DateRangePickerState extends State<DateRangePicker> {
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    AppScale _scale = AppScale(context);

    return InkWell(
      onTap: () async {
        final picked = await showDateRangePicker(
          context: context,
          lastDate: endDate,
          firstDate: new DateTime(2019),
        );
        if (picked != null && picked != null) {
          print(picked);
          setState(() {
            startDate = picked.start;
            endDate = picked.end;
          });
        }
      },
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.greyBg,
            borderRadius: BorderRadius.all(Radius.circular(1.h))),
        width: 12.h,
        height: 12.h,
        //   padding: EdgeInsets.all(0.5.h),
        child: Text(
          textAlign: TextAlign.center,
          this.widget.data,
          style: TextStyle(color: Colors.black, fontSize: _scale.axisHeading),
        ),
      ),
    );
  }
}
