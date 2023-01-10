import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../utils/AppScale.dart';
import '../utils/colour.dart';

class SiteAlarmContainer extends StatelessWidget {
  final String data;
  final String quantity;

  const SiteAlarmContainer(this.data, this.quantity);

  @override
  Widget build(BuildContext context) {
    AppScale _scale = AppScale(context);

    return Container(

      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColors.darkBlue),
          borderRadius: BorderRadius.all(Radius.circular(1.h)) ),
      width: 12.h,
      height: 8.h,
   //   padding: EdgeInsets.all(0.5.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Text(textAlign: TextAlign.center,
            this.data,
            style: TextStyle(fontWeight: FontWeight.w500,
                color: Colors.black, fontSize: _scale.siteConQTxt),
          ),
          SizedBox(
            height: 1.h,
          ),
          Text(
            this.quantity,
            style: TextStyle(fontWeight: FontWeight.bold,
                color: Colors.black, fontSize: _scale.axisHeading),
          ),
        ],
      )
      ,

    );
  }
}
