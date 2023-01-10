import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_widget/google_maps_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wateen_energy/screens/performance_screen.dart';
import '../services/network_api.dart';
import '../services/service_url.dart';
import '../utils/AppScale.dart';
import '../utils/colour.dart';
import '../utils/strings.dart';
import '../utils/user_table.dart';
import '../utils/utility.dart';
import '../widgets/form_button.dart';
import '../widgets/input_form_field.dart';
import '../widgets/site_map.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  late String password = "", username = "", mobile = "";
  final box = GetStorage();


  @override
  void initState() {
    super.initState();
    //requestLocPermission();
    checkUserConnection();
  }

  bool isActiveConnection = false;
  Future checkUserConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isActiveConnection = true;
         // T = "Turn off the data and repress again";
        });
      }
    } on SocketException catch (_) {
      setState(() {
        isActiveConnection = false;
       // T = "Turn On the data and repress again";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    AppScale _scale = AppScale(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: EdgeInsets.only(left: 12.w, right: 12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                /* Image.asset(
                  'assets/images/app_icon.png',
                  width: 27.h,
                  height: 17.h,
                ),*/
                SizedBox(
                  height: 1.5.h,
                ),
                //  Expanded(child: HeatMap()),

                Text(
                  "Enerlytics",
                  style: TextStyle(
                      color: Colors.black, fontSize: _scale.appBarHeading),
                ),
                SizedBox(
                  height: 2.5.h,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      InputFormField(
                          Strings.enterEmailTxt, TextInputType.emailAddress,
                          onSaved: (value) => username = value!),
                      InputFormField(
                          Strings.pwdTxt, TextInputType.visiblePassword,
                          onSaved: (value) => password = value!),
                      SizedBox(
                        height: 1.h,
                      ),
                      FormButton(Strings.loginBtn, onLoginAction)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onLoginAction() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if(isActiveConnection) {
        login();
      }
      else
        {
          Utility.showSubmitAlert(
              context, Strings.internetError, Strings.appNameTxt, onFailureAlert);

        }
    } else
      print(password);
  }

  void login() {
  //  username = "talha";
  //  password = "talha123";

    Map<String, dynamic> loginData = {
      UserTableKeys.userName: username,
      "password": password,
    };

    EasyLoading.show();
    NetworkAPI().httpPostRequest(ServiceUrl.loginUrl, null, loginData,
        (status, response) {
      if (response != null) {
        print(response);
        if (status) {
          Utility.isLoggedIn = true;
          navigate();
        } else {
          Utility.showSubmitAlert(
              context, response["detail"], Strings.appNameTxt, onFailureAlert);
        }
      } else {
        Utility.showSubmitAlert(
            context, "Please try again later", "", onFailureAlert);
      }
      EasyLoading.dismiss();
    });
  }

  void saveData(Map<String, dynamic> data) {
    /*User user = User.fromMap(data['user']);
    Provider.of<AllowedServicesCN>(context, listen: false)
        .setPermission(user.allowedService!);
    AllowedService a = user.allowedService!;
    print("events " + a.manage_events.toString()!!!);
    print("purchase_tickets " + a.purchase_tickets.toString()!!!);
    print("daily_visitor " + a.daily_visitor.toString()!!!);

    GetStorage().write(UserTableKeys.token, data['token'] as String);
    GetStorage().write(Strings.userData, user);*/
  }

  void navigate() {
    Navigator.pop(context);
    Navigator.of(context).pushNamed(PerformanceScreen.routeName);
  }

  void onFailureAlert() {
    Navigator.of(context).pop(); // dismiss dialog
  }

  /// Request the  permission and updates the UI accordingly
/* Future<bool> requestLocPermission() async {
    PermissionStatus result;
    // In Android we need to request the storage permission,
    // while in iOS is the photos permission

    await Permission.location.request();
    var status = await Permission.location.status;
    if (status.isGranted) {
      print("granted");
    } else if (status.isDenied) {
      print("isDenied");
      Map<Permission, PermissionStatus> st =
          await [Permission.location].request();
    }

    /* if (Platform.isAndroid) {
      result = await Permission.storage.request();
    } else {
      result = await Permission.photos.request();
    }

    if (result.isGranted) {
      imageSection = ImageSection.browseFiles;
      return true;
    } else if (Platform.isIOS || result.isPermanentlyDenied) {
      imageSection = ImageSection.noStoragePermissionPermanent;
    } else {
      imageSection = ImageSection.noStoragePermission;
    }*/
    return false;
  }*/
}
