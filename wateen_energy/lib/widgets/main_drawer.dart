import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wateen_energy/screens/site_screen.dart';
import '../screens/oandm_screen.dart';
import '../screens/performance_screen.dart';
import '../screens/login_screen.dart';
import '../screens/logout_screen.dart';
import '../screens/site_detail_screen.dart';
import '../utils/AppScale.dart';
import '../utils/colour.dart';
import '../utils/strings.dart';
import '../utils/user_table.dart';
import '../utils/utility.dart';

bool visible = false;

class MainDrawer extends StatefulWidget {
  static bool _visible = Utility.isLoggedIn;

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  Widget buildListTile(String title, VoidCallback tapHandler) {
    AppScale _scale = AppScale(context);
    return ListTile(
      title: Text(
        title,
        style: TextStyle(fontSize: _scale.subHeading),
      ),
      onTap: tapHandler,
    );
  }

  Widget buildLoginTile(String asset,String title, VoidCallback tapHandler) {
    AppScale _scale = AppScale(context);
    MainDrawer._visible = true;
    return Visibility(
      visible: (MainDrawer._visible && title.contains("Login"))
          ? false
          : (!MainDrawer._visible && title.contains("Login"))
              ? true
              : MainDrawer._visible,
      child: ListTile(
        title: Row(
          children: [
            asset.isNotEmpty ? Image.asset(asset,width: 3.h,height: 3.h,color: AppColors.greyText,) : Container(),
            asset.isNotEmpty ? SizedBox(width: 2.h,) : Container(),
            Text(
              title,
              style: TextStyle(
                  fontSize: _scale.subHeading, fontWeight: FontWeight.normal),
            ),
          ],
        ),
        onTap: tapHandler,
      ),
    );
  }

  Widget buildExpansionTile(String title, VoidCallback tapHandler) {
    AppScale _scale = AppScale(context);

    return ExpansionTile(
      expandedAlignment: Alignment.topLeft,
      childrenPadding: EdgeInsets.only(left: 2.h),
      title: Text(
        title,
        style: TextStyle(
            fontSize: _scale.subHeading, fontWeight: FontWeight.normal),
      ),
      children: <Widget>[
        Text("Plant 1", textAlign: TextAlign.start),
        Text("Plant 2")
      ],
    );
  }

  Widget buildCustomisedTile(String title, VoidCallback tapHandler, bool flag) {
    AppScale _scale = AppScale(context);
    return Visibility(
      visible: flag,
      child: ListTile(
          title: Text(
            title,
            style: TextStyle(
                /* color: getPermissionVisibility(title, permissions)
              ? Colors.black87
              : Colors.black38,*/
                fontSize: _scale.subHeading,
                fontWeight: FontWeight.normal),
          ),
          onTap:
              tapHandler // getPermissionVisibility(title, permissions) ? tapHandler : null,
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    AppScale _scale = AppScale(context);
    String userName = "Enerlytics username"; //GetStorage().read(UserTableKeys.username);
    return Drawer(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 6.0.h,left: 1.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/nav_menu.png',
                  width: 6.h,
                  height: 6.h,
                ),
                SizedBox(width: 1.h,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: _scale.chartHeading),
                    ),
                    Text(
                      "ID: 89999999999",
                      style: TextStyle(
                          fontSize: _scale.chartHeading),
                    ),
                  ],
                ),
              ],
            ),
          ),
           SizedBox(
            height: 5.h,
          ),
          buildLoginTile('assets/images/solar_icon.png',"Solar", () {
            Navigator.of(context).pushNamed(PerformanceScreen.routeName);
          }),
          buildLoginTile('assets/images/electric_pole.png',"Grid", () {
          //  Navigator.of(context).pushNamed(SiteDetailScreen.routeName);
          }),
          buildLoginTile('assets/images/generator.png',Strings.oAndMTitle, () {
          //   Navigator.of(context).pushNamed(OnMScreen.routeName);
          }),
      /*    buildLoginTile(Strings.sitesTitle, () {
              Navigator.of(context).pushNamed(SiteScreen.routeName);
          }),
          buildLoginTile(Strings.reportingTitle, () {
            //     Navigator.of(context).pushNamed(AboutScreen.routeName);
          }),
          buildLoginTile(Strings.testingTitle, () {
            //  Navigator.of(context).pushNamed(ContactScreen.routeName);
          }),
          buildLoginTile(Strings.equipmentTitle, () {
            // Navigator.of(context).pushNamed(MyTicketsScreen.routeName);
          }),
*/
          buildLoginTile("",Strings.logoutTitle, () {
            LogoutScreen l = LogoutScreen(context);
            l.showLogout();
          }),
          buildLoginTile("","Login", () {
            Navigator.of(context).pushNamed(LoginScreen.routeName);
          }),
          /*   buildLoginTile(Strings.servicesTitle, () {
            Navigator.of(context).pushNamed(ServicesScreen.routeName);
          }),*/
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    if (Utility.isLoggedIn) {
      setState(() {
        MainDrawer._visible = true;
      });
    } else {
      setState(() {
        MainDrawer._visible = false;
      });
    }
  }
}
