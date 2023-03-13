import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wateen_energy/models/alarm.dart';
import 'package:wateen_energy/widgets/input_form_field.dart';
import 'package:wateen_energy/widgets/item_sites.dart';
import '../models/sites.dart';
import '../services/network_api.dart';
import '../services/service_url.dart';
import '../utils/AppScale.dart';
import '../utils/colour.dart';
import '../utils/site_list_cn.dart';
import '../utils/strings.dart';
import '../utils/user_table.dart';
import '../utils/utility.dart';
import '../widgets/base_app_bar.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/item_report.dart';
import '../widgets/main_drawer.dart';
import '../widgets/report_dialog.dart';
import '../widgets/search_form_field.dart';

class ReportingScreen extends StatefulWidget {
  static const routeName = '/reporting';
  static bool isChecked = false;

  @override
  State<ReportingScreen> createState() => _ReportingScreenState();
}

class _ReportingScreenState extends State<ReportingScreen> {
  final box = GetStorage();
  Future<Map<String, dynamic>>? futureSites;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppScale _scale = AppScale(context);

    return Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        bottomNavigationBar: BottomNavBar(),
        appBar: BaseAppBar(AppBar(), Strings.reportingTitle),
        drawer: MainDrawer(),
        body: SingleChildScrollView(
          child: Container(
            color: AppColors.greyBg,
             height:  MediaQuery.of(context).size.height,
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.19),
            alignment: Alignment.topLeft,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ReportItem("Daily Reports"),
                    ReportItem("Weekly Reports")
                  ],),
                SizedBox(height: 2.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ReportItem("Monthly Reports"),
                    ReportItem("Annual Reports")
                  ],),
              /*  SizedBox(height: 2.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ReportItem("Customized Reports"),
                    ReportItem("Saved Reports")
                  ],),*/


              ],
            ),
          ),
        ));
  }


}
