import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
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

  Widget buildLoginTile(String asset, String title, VoidCallback tapHandler) {
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
            asset.isNotEmpty
                ? Image.asset(
                    asset,
                    width: 3.h,
                    height: 3.h,
                    color: title.contains("Solar") ? AppColors.lightBlue  : AppColors.greyText,
                  )
                : Container(),
            asset.isNotEmpty
                ? SizedBox(
                    width: 2.h,
                  )
                : Container(),
            Text(
              title,
              style: TextStyle(color: title.contains("Solar") ? AppColors.lightBlue : AppColors.greyText,
                  fontSize: _scale.subHeading, fontWeight: FontWeight.normal),
            ),
            Spacer(),
            Image.asset(
              'assets/images/f_arrow.png',
              width: 3.h,
              height: 3.h,
            )
          ],
        ),
        onTap: tapHandler,
      ),
    );
  }

  Widget buildLogoutTile(String asset, String title, VoidCallback tapHandler) {
    AppScale _scale = AppScale(context);
    MainDrawer._visible = true;
    return Visibility(
      visible: (MainDrawer._visible && title.contains("Login"))
          ? false
          : (!MainDrawer._visible && title.contains("Login"))
              ? true
              : MainDrawer._visible,
      child: ListTile(
        title: Container(
          decoration: BoxDecoration(
              color: AppColors.lightBlue,
              borderRadius: BorderRadius.all(Radius.circular(1.3.h))),
          height: 4.5.h,
          alignment: Alignment.bottomCenter,
          child: Align(
            alignment: Alignment.center,
            child: Text(
              title,
              style: TextStyle(
                  fontSize: _scale.subHeading,
                  fontWeight: FontWeight.normal,
                  color: Colors.white),
            ),
          ),
        ),
        onTap: tapHandler,
      ),
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
    String userName = GetStorage().read(Strings.epcName);
    return Drawer(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 6.0.h, left: 1.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/nav_menu.png',
                  width: 6.h,
                  height: 6.h,
                ),
                SizedBox(
                  width: 1.h,
                ),
                Text(
                  userName,
                  style: TextStyle(
                    fontSize: _scale.navButton,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 4.h,
          ),
          buildLoginTile('assets/images/solar_icon.png', "Solar", () {
            Navigator.of(context).pushNamed(PerformanceScreen.routeName);
          }),
          Container(width: MediaQuery.of(context).size.width * 0.57, height: 1, color: Colors.grey,),
          buildLoginTile('assets/images/electric_pole.png', "Grid", () {
            //  Navigator.of(context).pushNamed(SiteDetailScreen.routeName);
          }),
          Container(width: MediaQuery.of(context).size.width * 0.57, height: 1, color: Colors.grey,),
          buildLoginTile('assets/images/generator_menu.png', 'Generator', () {
            //   Navigator.of(context).pushNamed(OnMScreen.routeName);
          }),
          Container(width: MediaQuery.of(context).size.width * 0.57, height: 1, color: Colors.grey,),
          /*buildLoginTile(Strings.sitesTitle, () {
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
          buildLoginTile("", "Login", () {
            Navigator.of(context).pushNamed(LoginScreen.routeName);
          }),
          Spacer(),
          buildLogoutTile("", Strings.logoutTitle, () {
            LogoutScreen l = LogoutScreen(context);
            l.showLogout();
          }),
          Padding(
            padding:  EdgeInsets.only(bottom: 7.h),
            child: Text("Powered By Enerlytics"),
          )

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
