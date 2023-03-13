import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wateen_energy/models/alarm.dart';
import 'package:wateen_energy/models/sites.dart';
import '../utils/AppScale.dart';
import '../utils/colour.dart';
import '../utils/strings.dart';

class AlarmItem extends StatelessWidget {
  Alarm alarm;

  AlarmItem(this.alarm, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppScale _scale = AppScale(context);

    return Padding(
      padding: EdgeInsets.only(bottom: 0.9.h),
      child: InkWell(
        onTap: () {},
        child: Container(
            color: Colors.white,
            padding: EdgeInsets.only(left: 1.h, right: 1.h),
            height: 15.5.h,
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                Image.asset(
                  'assets/images/alarmitem.png',
                  width: 9.h,
                  height: 9.h,
                ),
                SizedBox(
                  width: 1.h,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text((alarm.events ?? ""),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    //background: Paint()..color = Colors.black38,
                                    fontSize: _scale.normalTxt,
                                    color: Colors.black,
                                  )),
                              SizedBox(
                                height: 0.3.h,
                              ),
                              Text(alarm.siteName + " - " + alarm.siteRegion,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: _scale.ssTxt,
                                    color: Colors.black,
                                  )),
                            ],
                          ),
                          Spacer(),
                          Align(
                            alignment: Alignment.topRight,
                            child: alarm.priority.isEmpty ? Container() : Container(
                              alignment: Alignment.center,
                              width: 10.h,
                              height: 3.5.h,
                              decoration: BoxDecoration(
                                  color: alarm.priority.contains("Major")
                                      ? AppColors.redColor
                                      : AppColors.orangeColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(0.7.h))),
                              child: Text(
                                alarm.priority,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: _scale.sssTxt,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Row(
                        children: [
                          getCustomerData(
                              context,  alarm.siteType, 'Site Type:'),
                          SizedBox(
                            width: 1.5.h,
                          ),
                          getCustomerData(
                              context, getDate(alarm.alarmDate), 'Date:'),
                          SizedBox(
                            width: 1.5.h,
                          ),
                          getCustomerData(
                              context,             alarm.elapsedTime.substring(0,1) + " Days",
                               'Elapsed Time:')
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }

  String getDate(String data) {
    List list = data.split("T");

    return list[0];
  }

  String getTime(String data) {
    List list = data.split(".");

    return list[0];
  }

  Widget getCustomerData(BuildContext context, String data, String label) {
    AppScale _scale = AppScale(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: _scale.ssTxt,
              color: Colors.black,
            )),
        Container(
          height: 0.1.h,
          color: Colors.black,
          width: label.contains('Site')
              ? 10.h
              : label.contains('Time')
                  ? 12.5.h
                  : 9.h,
          margin: EdgeInsets.only(top: 0.5.h, bottom: 0.5.h),
        ),
        Text(data,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: _scale.sssTxt,
              color: Colors.black,
            )),
      ],
    );
  }
}
