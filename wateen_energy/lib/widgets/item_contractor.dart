import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wateen_energy/models/alarm.dart';
import 'package:wateen_energy/models/sites.dart';
import '../models/contractor.dart';
import '../utils/AppScale.dart';
import '../utils/colour.dart';
import '../utils/strings.dart';

class ContractorItem extends StatelessWidget {
  Contractor data;

  ContractorItem(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppScale _scale = AppScale(context);

    return InkWell(
      onTap: () {},
      child: Container(
          padding: EdgeInsets.only(left: 2.h, right: 2.h),
          color: Colors.white,
          height: 8.h,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 7.2.h,
                child: Text(data.name,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: _scale.normalTxt,
                      color: AppColors.blueText,
                    )),
              ),
              Text(data.rank.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: _scale.normalTxt,
                    color: AppColors.blueText,
                  )),

              /* RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: data.rank.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.w500, color: Colors.black)),
                  WidgetSpan(
                    child: Transform.translate(
                      offset: const Offset(2, -4),
                      child: Text(
                        getRankText(data.rank),
                        //superscript is usually smaller in size
                        textScaleFactor: 0.7,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  TextSpan(
                      text: "  Position",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      )),
                ]),
              ),*/
              Text(data.score.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: _scale.normalTxt,
                    color: AppColors.blueText,
                  )),
            ],
          )),
    );
  }

  String getRankText(int rank) {
    String position = "th";
    switch (rank) {
      case 1:
        return "st";
      case 2:
        return "nd";
      case 3:
        return "rd";
      case 4:
        return "rth";
      case 5:
        return "th";
    }
    return position;
  }
}
