import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../utils/AppScale.dart';
import '../utils/colour.dart';

class MonthYearPicker extends StatefulWidget {
  final Function(String) onClickAction;

  const MonthYearPicker(this.onClickAction);

  @override
  State<MonthYearPicker> createState() => _MonthYearPickerState();
}

class _MonthYearPickerState extends State<MonthYearPicker> {
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    AppScale _scale = AppScale(context);
    print(DateTime.now().year);
    return InkWell(
      onTap: () async {
        final picked = await showMonthYearPicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(DateTime.now().year),

          builder: (BuildContext context, child) {
            return Theme(
              data: ThemeData.light().copyWith(
                colorScheme: ColorScheme.light(
                  primary: AppColors.darkBlue,
                  onPrimary: Colors.white,
                  surface: AppColors.darkBlue,
                  onSurface: Colors.black,
                  secondary: AppColors.darkBlue,// selection circle color
                  onSecondary: Colors.white,
                ),
                dialogBackgroundColor:Colors.white,



                  inputDecorationTheme: InputDecorationTheme(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2.h,),
                        borderSide: BorderSide(color: Colors.orange)),
                  )

              ), child: Container(
              child: child!,
              ),
            );
          },

        );
        if (picked != null && picked != null) {
          print("picked " + picked.toString());
          setState(() {
            startDate = picked;
          });
          widget.onClickAction(startDate.toString().substring(0,7));
        }
      },
      child: Text(
        textAlign: TextAlign.center,
        getMonth(startDate),
        style: TextStyle(color: Colors.black, fontSize: _scale.axisHeading),
      ),
    );
  }

  String getMonth(DateTime date)
  {
    String year = date.year.toString();
    List months =
    ['January', 'February', 'March', 'April', 'May','June','July','August','September','October','November','December'];
    int current_mon = startDate.month;
    return months[current_mon-1] + " " + year;
  }

}
