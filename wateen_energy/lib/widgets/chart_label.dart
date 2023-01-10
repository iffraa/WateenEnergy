import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../utils/AppScale.dart';
import '../utils/colour.dart';

class ChartLabel extends StatelessWidget {
  final String text;
  final int index;

  const ChartLabel(this.text,this.index );

  @override
  Widget build(BuildContext context) {
    AppScale _scale = AppScale(context);

    return Row(
      children: [
        Container(
          height: 0.8.h,
          width: 4.h,
          decoration: BoxDecoration(
              color: index == 0 ? AppColors.darkBlue : AppColors.lightBlue,
              borderRadius: BorderRadius.all(Radius.circular(1.h))),
        ),
        SizedBox(
          width: 2.h,
        ),
        Text(
          text,
          style: TextStyle(fontSize: _scale.axisHeading),
          textAlign: TextAlign.start,
        ),
        SizedBox(
          width: 4.h,
        ),

      ],
    );
  }
}
