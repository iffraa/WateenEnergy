import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../utils/AppScale.dart';
import '../utils/bottom_nav_index_cn.dart';
import '../utils/strings.dart';
import '../widgets/alert_button.dart';
import '../widgets/row_alert_button.dart';
import 'login_screen.dart';

class LogoutScreen{

  final BuildContext context;

  const LogoutScreen(this.context);

  void onLogout()
  {
    Navigator.of(context).pop(); // dismiss dialog
    Navigator.pop(context);
    Navigator.of(context).pushNamed(LoginScreen.routeName);

    GetStorage box = GetStorage();
    box.erase();
    Provider.of<BottomNavIndexCN>(context, listen: false).removeAll();

  }

  void onCancel()
  {
    Navigator.of(context).pop(); // dismiss dialog

  }

  void showLogout() {
    AppScale _scale = AppScale(context);

    // set up the button
    Widget okButton = RowAlertButton(Strings.yesTxt,onLogout);
    Widget cancelButton = RowAlertButton(Strings.noTxt,onCancel);

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      //  title: const Text(Strings.thankTxt),
      content: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            /* Image.asset(
              'assets/images/green_tick.png',
              width: 75,
              height: 75,
            ),
            SizedBox(
              height: 10,
            ),*/
            Text(
              Strings.appNameTxt,
              style: TextStyle(
                  fontSize: _scale.subHeading,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 1.h,
            ),
            Text(
              "Do you want to logout?",
              style: TextStyle(
                fontSize: _scale.subHeading,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
      actions: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            okButton,
            cancelButton

          ],
        ),
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



}