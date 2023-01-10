import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wateen_energy/utils/strings.dart';
import '../models/testenergy.dart';
import '../widgets/alert_button.dart';
import '../widgets/chart_label.dart';
import 'colour.dart';

class Utility {
  static bool isLoggedIn = false;

  static double getMaxYAxisValue(List<List<ChartDataP>> chartData)
  {
    double maxY = 0;
    for(int i =0 ; i < chartData.length; i++)
    {
      double max = 0, temp = 0;
      List<ChartDataP> data = chartData[i];
      temp = data.fold<num>(0, (max, e) => e.y > max ? e.y : max) as double;
      if(temp > maxY) {
        maxY = temp;
      }
    }

  //  print("maxy" + maxY.toString());
   // print("WHY " + ((maxY ~/ 8)*10).toString());

    return ((maxY ~/ 8)*10);
  }

  static int getInterval(double val)
  {
    val = 45;
    int interval = 0;

    if(val % 10 == 0)
      {
          interval = 8;
      }
    else
      interval = 5;

    print("interval " + interval.toString());
    return interval;
  }

  static Widget getChartLabels(List<dynamic> labels)
  {
    return Container(
      constraints: BoxConstraints(minWidth: double.infinity, maxHeight: 7.h),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        itemCount: labels.length,
        itemBuilder: (context, index) {
          return ChartLabel(labels[index],index);
        },
      ),
    );
  }


  static TooltipBehavior getToolTipStyle()
  {
    return  TooltipBehavior(enable: true,color: Colors.black26  ,textStyle:
    TextStyle(color: Colors.white));

  }

  static showToast(String msg, BuildContext context, FToast fToast) {
    Widget toast = Container(
        width: MediaQuery.of(context).size.width * 0.5,
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2.h),
          color: AppColors.greyText.withOpacity(0.8),
        ),
        child:  Text(msg,style: TextStyle(color: Colors.white),)
    );
    fToast.showToast(
      child: toast,
      gravity: ToastGravity.CENTER,
      toastDuration: Duration(seconds: 2),
    );
  }


  static showProgressDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(
            color: AppColors.darkBlue,
          ),
          Container(
              margin: EdgeInsets.only(left: 5), child: Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static showSubmitAlert(BuildContext context, String msg,String title, onClick) {
    // set up the button
    Widget okButton = AlertButton(Strings.ok,onClick);

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      //  title: const Text(Strings.thankTxt),
      content: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[

             Text(
              title,
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 3.h,
            ),
             Text(
              msg,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static showWarningAlert(BuildContext context, String msg) {
    // set up the button
    Widget okButton = TextButton(
      child: const Text(
        "OK",
        style: TextStyle(fontSize: 20, color: AppColors.lightBlue),
      ),
      onPressed: () {

          Navigator.of(context).pop(); // dismiss dialog

      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text(Strings.appNameTxt),
      content: Text(msg),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  /*static Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }*/

  static bool isWideWidth(double width) {
    if (width < 480)
      return false;
    else
      return true;
  }

  static String? validateEmail(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value))
      return null;//Strings.validEmailTxt;
    else
      return null;
  }

  static String? isEmpty(String? value) {
    if (value == null || value.isEmpty)
      return Strings.emptyFieldsTxt;
    else
      return null;
  }

  static String? validateMobile(String? value) {
    if (value == null || value.isEmpty || value.length > 12 || value.length < 8)
      return Strings.validMobileTxt;
    else
      return null;
  }


  static clearData()
  {

  }
}