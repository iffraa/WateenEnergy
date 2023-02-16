import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wateen_energy/services/service_url.dart';
import 'package:wateen_energy/widgets/form_button.dart';
import 'package:wateen_energy/widgets/format_radio_button.dart';
import 'package:wateen_energy/widgets/time_radio_button.dart';
import 'package:wateen_energy/widgets/var_check_box.dart';
import 'package:wateen_energy/widgets/week_date_picker.dart';

import '../services/network_api.dart';
import '../utils/AppScale.dart';
import '../utils/colour.dart';
import '../utils/strings.dart';
import '../utils/user_table.dart';
import '../utils/utility.dart';
import 'alert_button.dart';
import 'daily_date_picker.dart';
import 'dialog_button.dart';
import 'dropdown.dart';
import 'month_year_picker.dart';
import 'nav_button.dart';

class CustomDialog extends StatefulWidget {
  final String reportType;
  final Function(String, String) onClickAction;

  const CustomDialog(this.reportType, this.onClickAction);

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  String selectedDate = DateTime.now().toString().split(" ")[0];
  String selectedSite = "";
  Future<Map<String, dynamic>>? futureSites;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FormatRadioGroup.formatType = "PDF";
    AppScale _scale = AppScale(context);

    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(top: 9.h, bottom: 9.h, left: 7.h, right: 7.h),
        padding: EdgeInsets.all(3.h),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(1.h))),
        //   padding: EdgeInsets.all(0.5.h),
        child: Column(
          children: [
            Text(
              textAlign: TextAlign.center,
              "Custom Reports",
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
              height: 25.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                //  mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    "Select Variable:",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: _scale.chartHeading,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Expanded(
                      child: VariablesChkBox(getVariables(), onVariableSelected)),
                ],
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Container(
              padding: EdgeInsets.only(left: 1.h),
              decoration: BoxDecoration(
                  color: AppColors.greyBg,
                  borderRadius: BorderRadius.all(Radius.circular(1.h))),
              width: MediaQuery.of(context).size.width * 0.7,
              height: 25.h,
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
                  TimeRadioGroup()
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
              height: 20.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                //  mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    "Sites:",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: _scale.chartHeading,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Expanded(
                      child: VariablesChkBox(getSites(), onVariableSelected)),
                ],
              ),
            ),

            Row(
              children:  [
                Expanded(child: DialogButton("Generate PDF", onPDFClick)),
                SizedBox(width: 1.h,),
                Expanded(child: DialogButton("Save Preferences", onPDFClick)),

              ],
            )
          ],
        ),
      ),
    );
  }
}

void onVariableSelected(List selectedItems) {
  for (int i = 0; i < selectedItems.length; i++) {
    print(selectedItems[i]["title"]);
    print(selectedItems.length);
  }
}

void onSitesSelected(List selectedItems) {
  for (int i = 0; i < selectedItems.length; i++) {
    print(selectedItems[i]["title"]);
    print(selectedItems.length);
  }
}

List getVariables() {
  return [
    {
      "value": false,
      "title": "Total Yield",
    },
    {
      "value": false,
      "title": "Daily Energy",
    },
    {
      "value": false,
      "title": "Total Power",
    },
    {
      "value": false,
      "title": "AC Power (Meter)",
    },
    {
      "value": false,
      "title": "AC Power (Inverter)",
    },
    {
      "value": false,
      "title": "Yield (Inverter)",
    },
    {
      "value": false,
      "title": "Irradiation",
    },
    {
      "value": false,
      "title": "PR",
    },
    {
      "value": false,
      "title": "Fault Count",
    },
    {
      "value": false,
      "title": "Load",
    },
  ];
}

List getSites() {
  return [
    {
      "value": false,
      "title": "Plant Report",
    },
    {
      "value": false,
      "title": "Grid Point Report",
    },
    {
      "value": false,
      "title": "Unit Report",
    },
    {
      "value": false,
      "title": "Inverter Report",
    },

  ];
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

void onPDFClick() {
  Map<String, String> params = {
/*      "report_type":widget.reportType,
      "site_name":selectedSite,
      "report_format":FormatRadioGroup.formatType,
      "time_period":selectedDate*/
  };

  print(params);
  Map<String, String> headers = {
    "Referer": "http://referer.url.com",
  };

  /*   EasyLoading.show();
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

*/
}

void onDateSelected(String format) {
  print(format + " Date SELECTED");
  //  selectedDate = format;
}

void onFormatSelected(String format) {
  print(format + " Format SELECTED");
}

void onSiteSelected(String site) {
  print(site + " Site SELECTED");
  //  selectedSite = site;
}

List<String> getDropdownData() {
  return <String>["Candle", "ABC"];
}
