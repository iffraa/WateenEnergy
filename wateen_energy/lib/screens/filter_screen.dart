import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_widget/google_maps_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wateen_energy/screens/alarm_screen.dart';
import 'package:wateen_energy/screens/performance_screen.dart';
import '../services/network_api.dart';
import '../services/service_url.dart';
import '../utils/AppScale.dart';
import '../utils/colour.dart';
import '../utils/strings.dart';
import '../utils/user_table.dart';
import '../utils/utility.dart';
import '../widgets/dropdown.dart';
import '../widgets/filter_dropdown.dart';
import '../widgets/form_button.dart';
import '../widgets/input_form_field.dart';
import '../widgets/site_map.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = '/filter';

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final _formKey = GlobalKey<FormState>();
  late String password = "", username = "", mobile = "";
  final box = GetStorage();
  Map<String,String> filterMap = {};
  String region = "", severity = "", category = "", elapsedTime = "";

  @override
  Widget build(BuildContext context) {
    AppScale _scale = AppScale(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  //alignment: Alignment.bottomLeft,
                  padding: EdgeInsets.only(bottom: 1.h, left: 2.h),
                  color: AppColors.darkBlue,
                  height: 30.h,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        alignment: Alignment.topLeft,
                        padding:  EdgeInsets.only(top: 3.h,left: 0),
                        icon: ImageIcon(
                          color: Colors.white,
                          AssetImage("assets/images/back.png"),
                        ),
                        onPressed: () =>navigateToAlarmScreen()
                            ,
                      ),
                      Spacer(),
                      Text(
                        "Filter",
                        style: TextStyle(fontSize: _scale.appBarHeading,
                            color: Colors.white, fontWeight: FontWeight.w800),
                      ),
                    ],
                  )),
              SizedBox(
                height: 1.5.h,
              ),
              //  Expanded(child: HeatMap()),

              getTextView("Filter By Region"),
              FilterDropdown(["North", "South", "East", "West"],onRegionSelected),
              getTextView("Filter By Severity"),
              FilterDropdown(["Minor", "Major", "Critical"],onSeveritySelected),
              getTextView("Filter By Category"),
              FilterDropdown(["Platinium", "Gold", "Silver", "Other"],onCategorySelected),
              getTextView("Filter By Elapsed Time"),
              FilterDropdown([Strings.ascending, Strings.descending],onETimeSelected),

            ],
          ),
        ),
      ),
    );
  }

  void navigateToAlarmScreen()
  {
    filterMap[Strings.region] = region;
    filterMap[Strings.severity] = severity;
    filterMap[Strings.category] = category;
    filterMap[Strings.elapsed] = elapsedTime;

    Navigator.of(context).pushNamed(AlarmsScreen.routeName, arguments: filterMap);
  }

  void onCategorySelected(String selCategory){
    category = selCategory ;
  }

  void onElapsedSelected(String selCategory){
    elapsedTime = selCategory ;
  }

  void onRegionSelected(String selRegion){
    region = selRegion ;
  }

  void onSeveritySelected(String selData){
    severity = selData ;
  }

  void onETimeSelected(String selData){
    elapsedTime = selData ;
  }

  Widget getTextView(String text)
  {
    AppScale _scale = AppScale(context);

    return Padding(
      padding:  EdgeInsets.only(left: 2.h,bottom: 1.h,top: 2.h),
      child: Text(textAlign: TextAlign.start,text, style: TextStyle(
      color: Colors.black, fontSize: _scale.normalTxt,fontWeight: FontWeight.w600)),
    );
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
