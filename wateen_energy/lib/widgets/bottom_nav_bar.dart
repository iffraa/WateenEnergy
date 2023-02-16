import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wateen_energy/screens/oandm_screen.dart';
import 'package:wateen_energy/screens/reporting_screen.dart';
import 'package:wateen_energy/screens/site_screen.dart';

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


  void _onItemTapped(int index) {
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

  @override
  Widget build(BuildContext context) {
    AppScale _scale = AppScale(context);
    _selectedIndex = Provider.of<BottomNavIndexCN>(context, listen: false).selectedIndex;

    return  BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("assets/images/performance.png"),
              ),

              label:Strings.performanceTitle,
          //    backgroundColor: Colors.green
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

        ],
     //   type: BottomNavigationBarType.shifting,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.black26,
        iconSize: 4.h,
        onTap: _onItemTapped,showUnselectedLabels: true,
        elevation: 5
    );
  }
}
