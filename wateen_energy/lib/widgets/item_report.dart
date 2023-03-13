import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wateen_energy/models/alarm.dart';
import 'package:wateen_energy/models/sites.dart';
import 'package:wateen_energy/widgets/custom_dialog.dart';
import 'package:wateen_energy/widgets/report_dialog.dart';
import '../utils/AppScale.dart';
import '../utils/colour.dart';
import '../utils/strings.dart';

class ReportItem extends StatelessWidget {
  String text;

  ReportItem(this.text, {Key? key}) : super(key: key);

  void getReport(String reportType, String date)
  {}


  @override
  Widget build(BuildContext context) {
    AppScale _scale = AppScale(context);

    return Padding(
      padding: EdgeInsets.only(bottom: 0.9.h),
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (_) => (text.split(" ")[0].contains("Custom") ||
              text.split(" ")[0].contains("Saved"))  ? CustomDialog(text.split(" ")[0],getReport):
            ReportDialog(text.split(" ")[0],getReport),
          );
        },
        child: Container(
            margin: EdgeInsets.only(left: 1.5.h, right: 1.5.h),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(1.h))),
            padding: EdgeInsets.only(left: 1.h, right: 1.h),
            height: 15.5.h,
            width: MediaQuery.of(context).size.width * 0.42,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Center(
                        child:
                        Image.asset(
                          'assets/images/daily.png',
                          width: 9.h,
                          height: 9.h,
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(top: 2.h),
                        child: Text(getText(text),style: TextStyle(color: AppColors.darkBlue,
                            fontWeight: FontWeight.w600,fontSize: _scale.navButton),),
                      ),
                    ]
                ),

                SizedBox(
                  width: 1.h,
                ),
                Expanded(
                    child: Text(
                  text,
                        style: TextStyle(fontWeight: FontWeight.w700,fontSize: _scale.sTxt),
                ))
              ],
            )),
      ),
    );
  }

  String getText(String data)
  {
    switch (data) {
      case "Daily Reports":
        return "1";
      case "Weekly Reports":
        return "7";
      case "Monthly Reports":
        return "30";
      case "Annual Reports":
        return "365";
    }

    return "";
  }
}
