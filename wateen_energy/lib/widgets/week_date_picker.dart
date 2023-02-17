import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:weekly_date_picker/weekly_date_picker.dart';

import '../utils/AppScale.dart';
import '../utils/colour.dart';

class WeekDatePicker extends StatefulWidget {
  final Function(String) onClickAction;
  static const routeName = '/date';

  const WeekDatePicker(this.onClickAction);

  @override
  State<WeekDatePicker> createState() => _WeekDatePickerState();
}

class _WeekDatePickerState extends State<WeekDatePicker> {
  DateTime startDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    AppScale _scale = AppScale(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          startDate.toString().split(" ")[0],
          style: TextStyle(
            color: Colors.black,
            fontSize: _scale.chartHeading,
          ),        ),
        SizedBox(height: 1.h,),
        Container(
          color: Colors.lightBlue,
          child: WeeklyDatePicker(
            selectedDay: startDate,
            changeDay: (value) => setState(() {
              startDate = value;
              print("week is " + startDate.toString());
            }),
            weeknumberColor: AppColors.blueText,
            weeknumberTextColor: Colors.white,
            backgroundColor: Colors.white,
            weekdayTextColor: const Color(0xFF8A8A8A),
            digitsColor: Colors.black,
            selectedBackgroundColor: AppColors.blueText,
            weekdays: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"],
            daysInWeek: 7,
          ),
        )
      ],
    );
  }

  String getWeek() {
    String week = "";

    return week;
  }
}
