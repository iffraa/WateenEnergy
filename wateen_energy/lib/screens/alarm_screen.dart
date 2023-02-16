import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wateen_energy/models/alarm.dart';
import 'package:wateen_energy/screens/filter_screen.dart';
import 'package:wateen_energy/widgets/item_sites.dart';
import '../services/network_api.dart';
import '../services/service_url.dart';
import '../utils/AppScale.dart';
import '../utils/alarm_list_cn.dart';
import '../utils/colour.dart';
import '../utils/strings.dart';
import '../utils/user_table.dart';
import '../utils/utility.dart';
import '../widgets/base_app_bar.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/item_alarm.dart';
import '../widgets/main_drawer.dart';
import '../widgets/search_form_field.dart';

class AlarmsScreen extends StatefulWidget {
  static const routeName = '/alarms';
  static bool isChecked = false;

  @override
  State<AlarmsScreen> createState() => _AlarmsScreenState();
}

class _AlarmsScreenState extends State<AlarmsScreen> {
  final box = GetStorage();
  Future<Map<String, dynamic>>? futureAlarms;

  @override
  void initState() {
    super.initState();
    getAlarms();
  }

  @override
  Widget build(BuildContext context) {
    AppScale _scale = AppScale(context);

    return Scaffold(
        bottomNavigationBar: BottomNavBar(),
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        appBar: BaseAppBar(AppBar(), Strings.alarmsTitle),
        drawer: MainDrawer(),
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            alignment: Alignment.topLeft,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                showFilter(context),
                SizedBox(height: 1.5.h,),
                SearchFormField("Search by site name", TextInputType.text,
                    onSaved: onSearch),
                Container(
                  color: AppColors.greyBg,
                  child: FutureBuilder<Map<String, dynamic>>(
                      future: futureAlarms,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          EasyLoading.show();
                          return Padding(
                            padding: EdgeInsets.only(top: 40.h),
                            child: Center(
                              child: Text(
                                "Loading...",
                                style: TextStyle(fontSize: _scale.subHeading),
                              ),
                            ),
                          );
                        } else {
                          EasyLoading.dismiss();
                          return getAlarmList(snapshot);
                        }
                      }),
                ),
              ],
            ),
          ),
        ));
  }

  Widget getSearchData() {
    return Consumer<AlarmListCN>(builder: (context, alarmList, child) {
      return Container(
        padding: EdgeInsets.only(bottom: 6.h),
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: alarmList.data.length,
          itemBuilder: (context, index) {
            return AlarmItem(alarmList.data![index]);
          },
        ),
      );
    });
  }

  Widget showFilter(BuildContext context) {
    return Container(
     // padding: EdgeInsets.only(top: 5.5.h),
      width: MediaQuery.of(context).size.width,
      height: 19.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 3.h, right: 1.h),
            child: IconButton(
              alignment: Alignment.center,
            //  padding:  EdgeInsets.only(top: 2.h),
              icon: Image.asset(height: 2.h,
                'assets/images/filter.png',
              ),
              onPressed: () =>
                  Navigator.of(context).pushNamed(FilterScreen.routeName),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 1.h, top: 0),
            child: Text(
              "Filter",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          )
        ],
      ),
    );
  }

  List<Alarm> formAlarmsList(Map<String, dynamic> data) {
    List<Alarm> sitesData = [];

    if (data.entries.isNotEmpty) {
      List sites = data['alarms'];
      print("vals " + sites.length.toString());
      for (int i = 0; i < sites.length; i++) {
        List data = sites[i];
        Alarm site = Alarm(data[1], data[4], data[2], data[3], data[6], data[5],
            data[8], data[7]);
        sitesData.add(site);
      }
    }

    //  data.forEach((k, v) => print('${k}: ${v}'));
    return sitesData;
  }

  List<Alarm> getFilteredList(List<Alarm> alarms) {
    List<Alarm> filteredList = alarms;
    final map =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;

    print("map " + map[Strings.elapsed].toString());
    if (map[Strings.region]!.isNotEmpty) {
      filteredList
          .removeWhere((item) => item.siteRegion != map[Strings.region]);
    } else if (map[Strings.severity]!.isNotEmpty) {
      filteredList
          .removeWhere((item) => item.priority != map[Strings.severity]);
    } else if (map[Strings.category]!.isNotEmpty) {
      filteredList
          .removeWhere((item) => item.siteType != map[Strings.category]);
    } else if (map[Strings.elapsed]!.isNotEmpty) {
      if (map[Strings.elapsed] == Strings.descending) {
        filteredList.sort((a, b) => b.elapsedTime.compareTo(a.elapsedTime));
      } else {
        filteredList.sort((a, b) => b.elapsedTime.compareTo(a.elapsedTime));
        filteredList = filteredList.reversed.toList();
      }
    }

    //
    List outputList = filteredList.where((o) => o.siteRegion == '1').toList();

    return filteredList;
  }

  List<Alarm> alarms = [];

  Widget getAlarmList(AsyncSnapshot snapshot) {
    alarms = formAlarmsList(snapshot.data);
    if (ModalRoute.of(context)?.settings.arguments != null) {
      alarms = getFilteredList(alarms);
    }

    return searchResult.isEmpty ? getAlarmLiveData() : getSearchData();
  }

  Widget getAlarmLiveData() {
    return Container(
      padding: EdgeInsets.only(bottom: 2.h, top: 2.h),
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: alarms.length,
        itemBuilder: (context, index) {
          return AlarmItem(alarms[index]);
        },
      ),
    );
  }

  Future<List<Alarm>>? getAlarms() async {
    GetStorage box = GetStorage();
    Map<String, String> headers = {
      'Authorization': "JWT " + box.read(Strings.token),
    };

    List<Alarm> mealsList = <Alarm>[];
    try {
      futureAlarms = NetworkAPI().httpFetchData(ServiceUrl.alarmUrl, headers);
    } catch (e) {
      Utility.showSubmitAlert(context, Strings.noRecordTxt, "", null);
    }
    return mealsList;
  }

  String searchResult = "";

  void onSearch(String? result) {
    print("result " + result!);
    setState(() {
      searchResult = result;

      alarms.removeWhere(
          (e) => !(e.siteName.toLowerCase().contains(result.toLowerCase())));
      //  Provider.of<SiteListCN>(context, listen: false).updateData(sites);

      context.read<AlarmListCN>().clear();
      context.read<AlarmListCN>().updateData(alarms);
    });
  }
}
