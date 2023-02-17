import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../utils/AppScale.dart';
import '../utils/colour.dart';

class DailyDatePicker extends StatefulWidget {
  final Function(String) onClickAction;
  static const routeName = '/date';

  const DailyDatePicker(this.onClickAction);

  @override
  State<DailyDatePicker> createState() => _DailyDatePickerState();
}

class _DailyDatePickerState extends State<DailyDatePicker> {
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    AppScale _scale = AppScale(context);

    return InkWell(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          lastDate: endDate,
          firstDate: new DateTime(2019),
          initialDate: startDate,


          builder: (BuildContext context, child) {
            return Theme(
              data: ThemeData.light().copyWith(
                colorScheme: ColorScheme.light(
                  primary: AppColors.darkBlue,
                  onPrimary: Colors.white,
                  surface: AppColors.darkBlue,
                  onSurface: Colors.black,
                ),
                dialogBackgroundColor:Colors.white,
              ), child: child!,
            );
          },

        );
        if (picked != null && picked != null) {
          print(picked);
          setState(() {
            startDate = picked;
          });
          widget.onClickAction(startDate.toString().split(" ")[0]);
        }
      },
      child: Text(
        textAlign: TextAlign.center,
        startDate.toString().split(" ")[0],
        style: TextStyle(color: Colors.black, fontSize: _scale.axisHeading),
      ),
    );
  }
}
