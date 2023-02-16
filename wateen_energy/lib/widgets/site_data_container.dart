import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../utils/AppScale.dart';
import '../utils/colour.dart';
import '../utils/strings.dart';

class SiteDataContainer extends StatelessWidget {
  final String data;
  final String quantity;

  const SiteDataContainer(this.data, this.quantity);

  @override
  Widget build(BuildContext context) {
    AppScale _scale = AppScale(context);

    return Container(
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
          Container(
              decoration: BoxDecoration(
                  color: AppColors.greyContainerColor,
          shape: BoxShape.circle,),

          width: 5.h,
              height: 5.h,
              child: getIcon(this.data)),
          SizedBox(
            height: 1.h,
          ),
          Text(
            textAlign: TextAlign.center,
            this.data,
            style: TextStyle(
                color: AppColors.blueText,
                fontSize: _scale.siteConQTxt,
                fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 1.h,
          ),
          Text(
            this.quantity,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: _scale.siteConQTxt),
          ),
        ],
      ),
    );
  }

  Widget getIcon(String text) {
    switch (text) {
      case Strings.todayRevenue:
        {
          return ImageIcon(
            color: Colors.black,
            AssetImage("assets/images/dollar.png"),
          );
        }

      case Strings.cuf:
        {
          return ImageIcon(
            color: Colors.black,
            AssetImage("assets/images/cuf.png"),
          );
        }
      case Strings.yield:
        {
          return ImageIcon(
            color: Colors.black,
            AssetImage("assets/images/yield.png"),
          );
        }
      case Strings.activeFaults:
        {
          return ImageIcon(
            color: Colors.black,
            AssetImage("assets/images/faults.png"),
          );
        }
      case Strings.systemSize:
        {
          return ImageIcon(
            color: Colors.black,
            AssetImage("assets/images/system.png"),
          );
        }
      case Strings.performanceRatio:
        {
          return ImageIcon(
            color: Colors.black,
            AssetImage("assets/images/pr.png"),
          );
        }
      case Strings.tcpr:
        {
          return ImageIcon(
            color: Colors.black,
            AssetImage("assets/images/tcpr.png"),
          );
        }
    }
    return ImageIcon(
      AssetImage("assets/images/faults.png"),
    );
  }
}
