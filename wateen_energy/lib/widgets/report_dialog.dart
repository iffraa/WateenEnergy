import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wateen_energy/services/service_url.dart';
import 'package:wateen_energy/widgets/form_button.dart';
import 'package:wateen_energy/widgets/format_radio_button.dart';
import 'package:wateen_energy/widgets/week_date_picker.dart';

import '../services/network_api.dart';
import '../utils/AppScale.dart';
import '../utils/colour.dart';
import '../utils/strings.dart';
import '../utils/user_table.dart';
import '../utils/utility.dart';
import 'alert_button.dart';
import 'daily_date_picker.dart';
import 'dropdown.dart';
import 'month_year_picker.dart';
import 'nav_button.dart';

class ReportDialog extends StatefulWidget {
  final String reportType;
  final Function(String, String) onClickAction;
  static const routeName = '/date';

  const ReportDialog(this.reportType, this.onClickAction);

  @override
  State<ReportDialog> createState() => _ReportDialogState();
}

class _ReportDialogState extends State<ReportDialog> {
  String selectedDate = DateTime.now().toString().split(" ")[0];
  String selectedSite = "";
  Future<Map<String, dynamic>>? futureSites;

  @override
  void initState() {
    super.initState();
    getSites();
  }

  @override
  Widget build(BuildContext context) {
    FormatRadioGroup.formatType = "PDF";
    AppScale _scale = AppScale(context);

    return FutureBuilder<Map<String, dynamic>>(
        future: futureSites,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            EasyLoading.dismiss();

            return SingleChildScrollView(
              child: Container(
                margin:
                    EdgeInsets.only(top: 9.h, bottom: 9.h, left: 7.h, right: 7.h),
                padding: EdgeInsets.all(3.h),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(1.h))),
                //   padding: EdgeInsets.all(0.5.h),
                child: Column(
                  children: [
                    Text(
                      textAlign: TextAlign.center,
                      "Reports",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: _scale.heading,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Container(
                      padding: EdgeInsets.all(1.h),
                      decoration: BoxDecoration(
                          color: AppColors.greyBg,
                          borderRadius: BorderRadius.all(Radius.circular(1.h))),
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: 9.h,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            textAlign: TextAlign.center,
                            "Report Type:",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: _scale.chartHeading,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Text(
                            widget.reportType,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: _scale.chartHeading,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Container(
                      padding: EdgeInsets.all(1.h),
                      decoration: BoxDecoration(
                          color: AppColors.greyBg,
                          borderRadius: BorderRadius.all(Radius.circular(1.h))),
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: 9.h,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            textAlign: TextAlign.center,
                            "Select Site:",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: _scale.chartHeading,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Expanded(
                            child: DropdownSpinner(getSiteNames(snapshot.data!),
                                Strings.site, onSiteSelected,true),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Container(
                      padding: EdgeInsets.all(1.h),
                      decoration: BoxDecoration(
                          color: AppColors.greyBg,
                          borderRadius: BorderRadius.all(Radius.circular(1.h))),
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: 9.h,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        //  mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            textAlign: TextAlign.center,
                            "Report Format:",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: _scale.chartHeading,
                                fontWeight: FontWeight.bold),
                          ),
                          Expanded(child: FormatRadioGroup()),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Container(
                      padding: EdgeInsets.all(1.h),
                      decoration: BoxDecoration(
                          color: AppColors.greyBg,
                          borderRadius: BorderRadius.all(Radius.circular(1.h))),
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: widget.reportType.contains("Weekly") ? 20.h : 9.h,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        //  mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            textAlign: TextAlign.center,
                            "Time Period:",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: _scale.chartHeading,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          widget.reportType.contains("Daily") ? DailyDatePicker(onDateSelected) :
                          widget.reportType.contains("Monthly")? MonthYearPicker(onDateSelected) :
                          widget.reportType.contains("Weekly")? WeekDatePicker(onDateSelected) :
                          DropdownSpinner(getYears()!, "Year", onYearSelected, true),
                        ],
                      ),
                    ),
                    NavButton("Go", onButtonClick)
                  ],
                ),
              ),
            );
          } else {
            EasyLoading.show();
            return Container();
          }
        });
  }

  void onYearSelected(String year)
  {
      print("year " + year);
  }

  List<String>? getYears()
  {
    int currentYear = DateTime.now().year;
    int startingYear = currentYear;
    List<String> yearList = List.generate((currentYear+startingYear)+1, (index) => (startingYear-index).toString());
    return yearList;
  }

  List<String> getSiteNames(Map<String, dynamic> data) {
    List<String> sitesData = [];

    if (data.entries.isNotEmpty) {
      List sites = data['sites'];
      for (int i = 0; i < sites.length; i++) {
        List data = sites[i];
        sitesData.add(data[0]);
      }
    }

    return sitesData;
  }

  void onButtonClick() {
    Map<String, String> params = {
      "report_type":widget.reportType,
      "site_name":selectedSite,
      "report_format":FormatRadioGroup.formatType,
      "time_period":selectedDate
    };

    print(params);
    GetStorage box = GetStorage();

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    'Authorization': "JWT " + box.read(Strings.token),
      'Referer': 'https://fsel.enerlyticslab.com',
    };

    EasyLoading.show();
    NetworkAPI().httpPostData(ServiceUrl.getReportUrl, headers,params,
            (error, response) {
          if (response != null) {
            print("report" +response.toString());
            if (!error) {

            } else {
              print("ERROR");

              // Utility.showSubmitAlert(context, response["detail"], Strings.appNameTxt, onFailureAlert);
            }
          } else {
            // Utility.showSubmitAlert(context, "Please try again later", "", onFailureAlert);
          }
          EasyLoading.dismiss();
        });


  }

  void onDateSelected(String format) {
    print(format + " Date SELECTED");
    selectedDate = format;
  }

  void onFormatSelected(String format) {
    print(format + " Format SELECTED");
  }

  void onSiteSelected(String site) {
    print(site + " Site SELECTED");
    selectedSite = site;
  }

  List<String> getDropdownData() {
    return <String>["Candle", "ABC"];
  }

  void getSites() async {
    GetStorage box = GetStorage();
    Map<String, String> headers = {
      'Authorization': "JWT " + box.read(Strings.token),
    };

    Map<String, String> params = {
      UserTableKeys.epcName: "EFC",
    };

    try {
      futureSites =
          NetworkAPI().httpGetGraphData(ServiceUrl.getSitesUrl, headers, params);
    } catch (e) {
      Utility.showSubmitAlert(context, Strings.noRecordTxt, "", null);
    }
  }
}
