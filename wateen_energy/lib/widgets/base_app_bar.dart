import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../utils/AppScale.dart';
import '../utils/colour.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor = Colors.red;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final AppBar appBar;
  final String title;

  BaseAppBar(this.appBar, this.title) : super();

  @override
  Widget build(BuildContext context) {
    AppScale _scale = AppScale(context);
    _scaffoldKey;
    false; // This!

    return PreferredSize(
      preferredSize:
      Size.fromHeight(40.h),
      child: AppBar(
        toolbarHeight: 40.h,
        title: Padding(
          padding:  EdgeInsets.only(top: 2.h,),
          child: Text(
            textAlign: TextAlign.start,
            title,
            style:  TextStyle(fontSize: _scale.appBarHeading, color: Colors.black, ),
          ),
        ),
        actions: <Widget>[
         /* SizedBox(
            width: 80,
            height: 80,
            child: IconButton(
              icon: Image.asset('assets/images/app_icon.png'),
              padding: EdgeInsets.only(top: 12,right: 8),
              onPressed: () {
                //   Navigator.of(context).pushNamed(WelcomeScreen.routeName);
              },
            ),
          )*/
        ],
        backgroundColor: Colors.white,
       // shadowColor: Colors.transparent,
         elevation: 0.0,
        leading:
            showBackBtn(title) ? getBackIcon(context) : getDrawerIcon(context),
      ),
    );
  }

  bool showBackBtn(String title) {
    if (title.contains('Location')) {
      return true;
    }
    return false;
  }

  IconButton getDrawerIcon(BuildContext context) {
    return IconButton(
      padding:  EdgeInsets.only(top: 2.h),
      icon: Image.asset('assets/images/app_icon.png'),
      onPressed: () => Scaffold.of(context).openDrawer(),
    );
  }

  IconButton getBackIcon(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.only(left: 2.h,top: 2.h ),
      icon: Icon(Icons.arrow_back,color: AppColors.greyText,size:3.5.h,),
      onPressed: () => Navigator.pop(context),
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(10.h);//appBar.preferredSize.height
}
