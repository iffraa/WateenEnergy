import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wateen_energy/screens/oandm_screen.dart';
import 'package:wateen_energy/screens/reporting_screen.dart';
import 'package:wateen_energy/screens/site_screen.dart';
import 'package:wateen_energy/utils/user_table.dart';

import '../screens/alarm_screen.dart';
import '../screens/performance_screen.dart';
import '../utils/AppScale.dart';
import '../utils/bottom_nav_index_cn.dart';
import '../utils/colour.dart';
import '../utils/site_list_cn.dart';
import '../utils/strings.dart';

class BottomNavBar extends StatefulWidget {
 // final String text;
 // final Function onClickAction;

  const BottomNavBar();

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;


  void onEPCItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Provider.of<BottomNavIndexCN>(context, listen: false).setIndex(_selectedIndex);

    print("_selectedIndex " + _selectedIndex.toString());
    switch (_selectedIndex) {
      case 0:
        Navigator.of(context).pushNamed(PerformanceScreen.routeName);
        break;
      case 1:
        Navigator.of(context).pushNamed(OnMScreen.routeName);
        break;
      case 2:
        Navigator.of(context).pushNamed(AlarmsScreen.routeName);
        break;
      case 3:
        Navigator.of(context).pushNamed(SiteScreen.routeName);
        break;
      case 4:
        Navigator.of(context).pushNamed(ReportingScreen.routeName);
        break;
    }
  }

  void onClientItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Provider.of<BottomNavIndexCN>(context, listen: false).setIndex(_selectedIndex);

    print("_selectedIndex " + _selectedIndex.toString());
    switch (_selectedIndex) {
      case 0:
        Navigator.of(context).pushNamed(AlarmsScreen.routeName);
        break;
      case 1:
        Navigator.of(context).pushNamed(SiteScreen.routeName);
        break;
      case 2:
        Navigator.of(context).pushNamed(ReportingScreen.routeName);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    _selectedIndex = Provider.of<BottomNavIndexCN>(context, listen: false).selectedIndex;
    int userType = GetStorage().read(UserTableKeys.userType);
    return  BottomNavigationBar(
        items:  userType == 2 ? getEPCBNavBar() : getClientBNavBar(),
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.black26,
        iconSize: 4.h,
        onTap: userType == 2 ? onEPCItemTapped : onClientItemTapped,showUnselectedLabels: true,
        elevation: 5
    );
  }

  List<BottomNavigationBarItem> getClientBNavBar()
  {
    return <BottomNavigationBarItem>[

      BottomNavigationBarItem(
        icon: ImageIcon(
          AssetImage("assets/images/alarm.png"),
        ),
        label: Strings.alarmsTitle,
        //   backgroundColor: Colors.blue,
      ),
      BottomNavigationBarItem(
        icon:  ImageIcon(
          AssetImage("assets/images/sites.png"),
        ),
        label: "Sites",
        //   backgroundColor: Colors.blue,
      ),
      BottomNavigationBarItem(
        icon: ImageIcon(
          AssetImage("assets/images/report.png"),
        ),
        label: Strings.reportingTitle,
        //    backgroundColor: Colors.blue,
      ),

    ];
  }

  List<BottomNavigationBarItem> getEPCBNavBar()
  {
    return <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: ImageIcon(
          AssetImage("assets/images/performance.png"),
        ),

        label:Strings.performanceTitle,
      ),
      BottomNavigationBarItem(
        icon: ImageIcon(
          AssetImage("assets/images/onm.png"),
        ),

        label: Strings.oAndMTitle,
        //   backgroundColor: Colors.yellow
      ),
      BottomNavigationBarItem(
        icon: ImageIcon(
          AssetImage("assets/images/alarm.png"),
        ),
        label: Strings.alarmsTitle,
        //   backgroundColor: Colors.blue,
      ),
      BottomNavigationBarItem(
        icon:  ImageIcon(
          AssetImage("assets/images/sites.png"),
        ),
        label: "Sites",
        //   backgroundColor: Colors.blue,
      ),
      BottomNavigationBarItem(
        icon: ImageIcon(
          AssetImage("assets/images/report.png"),
        ),
        label: Strings.reportingTitle,
        //    backgroundColor: Colors.blue,
      ),

    ];
  }
}
