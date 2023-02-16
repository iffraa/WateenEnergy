import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../utils/AppScale.dart';
import '../utils/colour.dart';
import '../utils/strings.dart';

class TotalDataContainer extends StatelessWidget {
  final String data;
  final String quantity;

  const TotalDataContainer(this.data, this.quantity);

  @override
  Widget build(BuildContext context) {
    AppScale _scale = AppScale(context);

    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(1.h))),
      width: 10.h,
      height: 11.h,
      padding: EdgeInsets.all(0.3.h),
      margin: EdgeInsets.only(top: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              decoration: BoxDecoration(
                  color: AppColors.darkBlue,
                  borderRadius: BorderRadius.all(Radius.circular(0.6.h))),
              width: 4.h,
              height: 4.4.h,

              child: getIcon(this.data)),
          SizedBox(
            height: 1.h,
          ),
          Text(
            textAlign: TextAlign.center,
            this.data,
            style: TextStyle(
                color: Colors.black, fontSize: _scale.smallestTxt),
          ),
          SizedBox(
            height: 1.h,
          ),
          Text(
            this.quantity,
            style: TextStyle(
                color: Colors.black,
                fontSize: _scale.sTxt,
                fontWeight: FontWeight.w700),
          ),
        ],
      )
      ,

    );
  }

  Widget getIcon(String text) {
    switch (text) {
      case Strings.commercialSites:
        {
          return ImageIcon(color: Colors.white,
            AssetImage("assets/images/skyline.png"),
          );
        }

      case Strings.industrialSites:
        {
          return ImageIcon(color: Colors.white,
            AssetImage("assets/images/industrial.png"),
          );
        }
      case Strings.residentialSites:
        {
          return ImageIcon(color: Colors.white,
            AssetImage("assets/images/house.png"),
          );
        }
      case Strings.activeAlarms:
        {
          return ImageIcon(color: Colors.white,
            AssetImage("assets/images/alarmm.png"),
          );
        }

    }
    return ImageIcon(
      AssetImage("assets/images/commercial.png"),
    );
  }
}
