import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../screens/critical_alarm_screen.dart';
import '../utils/AppScale.dart';
import '../utils/colour.dart';
import '../utils/strings.dart';

class AlarmDataContainer extends StatelessWidget {
  final String data;
  final String quantity;

  const AlarmDataContainer(this.data, this.quantity);

  @override
  Widget build(BuildContext context) {
    AppScale _scale = AppScale(context);

    return InkWell(
      onTap: () {
        if (data == Strings.criticalAlarms) {
          Navigator.of(context).pushNamed(CriticalAlarmScreen.routeName);

        }
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(1.h))),
        width: 12.h,
        height: 12.h,
        //   padding: EdgeInsets.all(0.5.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              textAlign: TextAlign.center,
              this.data,
              style:
                  TextStyle(color: Colors.black, fontSize: _scale.axisHeading),
            ),
            SizedBox(
              height: 1.h,
            ),
            Text(
              this.quantity,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: _scale.axisHeading),
            ),
          ],
        ),
      ),
    );
  }
}
