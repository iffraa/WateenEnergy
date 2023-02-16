import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wateen_energy/models/alarm.dart';
import 'package:wateen_energy/models/sites.dart';
import '../screens/site_detail_screen.dart';
import '../utils/AppScale.dart';
import '../utils/colour.dart';
import '../utils/strings.dart';

class SiteItem extends StatelessWidget {
  Site site;

  SiteItem(this.site, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppScale _scale = AppScale(context);

    return Padding(
      padding: EdgeInsets.only(bottom: 0.9.h),
      child: InkWell(
        onTap: () {
          Navigator.of(context)
              .pushNamed(SiteDetailScreen.routeName, arguments: site.name);

        },
        child: Container(
            color: Colors.white,
            padding: EdgeInsets.only(left: 1.5.h, right: 1.5.h),
            height: 20.h,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/images/siteitem.png',
                      width: 8.h,
                      height: 8.h,
                    ),
                    SizedBox(
                      width: 1.h,
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Text((site.name ?? ""),
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                //background: Paint()..color = Colors.black38,
                                fontSize: _scale.normalTxt,
                                color: Colors.black,
                              )),
                          //Spacer(),
                          SizedBox(width: 4.h,),
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              alignment: Alignment.center,
                              width: 9.h,
                              height: 2.5.h,
                              decoration: BoxDecoration(
                                  color: site.status.contains("Active")
                                      ? AppColors.geenOnlineColor
                                      : AppColors.redColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4.h))),
                              child: Text(
                                site.status,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: _scale.ssTxt,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 2.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    getCustomerData(context, site.tSystemSize.toString(),
                        'Total System Size (KWp)'),
                    SizedBox(
                      width: 2.h,
                    ),
                    getCustomerData(context, site.tPower.toString(),
                        'Total Yield (KWh)'),
                    SizedBox(
                      width: 2.h,
                    ),
                    getCustomerData(
                        context, site.tAlarms.toString(), 'Total Alarms')
                  ],
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

    return Container(
      decoration: BoxDecoration(
          border: Border.all(color:Colors.black),
          borderRadius: BorderRadius.all(
              Radius.circular(1.h)),
          ),
      width: 12.5.h,
      height: 7.5.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(data,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: _scale.sssTxt,
                color: Colors.black,
              )),

          SizedBox(
            height: 1.h,
          ),
          Text(label,textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: _scale.ssTxt,
                color: Colors.black,
              )),

         ],
      ),
    );
  }
}
