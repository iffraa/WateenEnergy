import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wateen_energy/screens/critical_alarm_screen.dart';

import '../models/alarm.dart';
import '../utils/AppScale.dart';
import '../utils/colour.dart';

class CriticalTicketsItem extends StatelessWidget {
  final Alarm alarm;

  const CriticalTicketsItem(this.alarm);

  @override
  Widget build(BuildContext context) {
    AppScale _scale = AppScale(context);
    return InkWell(
      onTap: (){
        Navigator.of(context).pushNamed(CriticalAlarmScreen.routeName);

      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.black26,
            borderRadius: BorderRadius.all(Radius.circular(1.h))),
        width: 13.h,
        height: 18.h,
        padding: EdgeInsets.only(left:0.5.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text(textAlign: TextAlign.center,
              alarm.siteName,
              style: TextStyle(
                  color: Colors.black, fontSize: _scale.axisHeading),
            ),
            SizedBox(
              height: 1.h,
            ),
            Text(
              textAlign: TextAlign.center,
              alarm.status,
              style: TextStyle(
                  color: Colors.blue, fontWeight: FontWeight.bold, fontSize: _scale.axisHeading),
            ),
            SizedBox(
              height: 1.h,
            ),
            Text(
              alarm.elapsedTime.substring(0,2) + " Days",
              style: TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold, fontSize: _scale.axisHeading),
            ),
          ],
        )
        ,

      ),
    );
  }
}
