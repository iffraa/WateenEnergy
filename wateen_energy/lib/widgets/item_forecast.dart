import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../models/forecast.dart';
import '../utils/AppScale.dart';
import '../utils/colour.dart';
import '../utils/utility.dart';

class ForecastItem extends StatelessWidget {
  final Forecast forecast;

  const ForecastItem(this.forecast );

  @override
  Widget build(BuildContext context) {
    AppScale _scale = AppScale(context);

    DateTime date = DateTime.parse(forecast.date!);

    return Container(
      margin: EdgeInsets.only(right: 1.5.h),
      padding: EdgeInsets.all(1.h),
      decoration: BoxDecoration(
          color: AppColors.lightBlue,
          borderRadius: BorderRadius.all(Radius.circular(3.h))),
      width: 11.h,
      height: 14.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            textAlign: TextAlign.center,
            Utility.getDay(date.weekday),
            style: TextStyle(
                color: Colors.white,
                fontSize: _scale.forecastItem,
                fontWeight: FontWeight.w400),
          ),

          Expanded(
            child: Image.network(fit: BoxFit.contain,
              'https://openweathermap.org/img/wn/' + forecast.icon! + ".png",
              width: 7.h,
              height: 7.h,
            ),
          ),
          Text(
            textAlign: TextAlign.center,
            forecast.temp!.toString() + "\u00B0",
            style: TextStyle(
                color: Colors.white,
                fontSize: _scale.chartHeading,
                fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }


}
