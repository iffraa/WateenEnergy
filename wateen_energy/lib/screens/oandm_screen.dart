import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wateen_energy/models/contractor.dart';
import 'package:wateen_energy/models/testenergy.dart';
import 'package:wateen_energy/widgets/item_contractor.dart';
import 'package:wateen_energy/widgets/list_heading.dart';
import 'package:wateen_energy/widgets/performance_line_chart.dart';
import 'package:wateen_energy/widgets/item_critical_tickets.dart';
import 'package:wateen_energy/widgets/vertical_bar_chart.dart';
import '../models/alarm.dart';
import '../services/network_api.dart';
import '../services/service_url.dart';
import '../utils/AppScale.dart';
import '../utils/colour.dart';
import '../utils/strings.dart';
import '../utils/user_table.dart';
import '../utils/utility.dart';
import '../widgets/alarm_data_container.dart';
import '../widgets/base_app_bar.dart';
import '../widgets/energy_mix_chart.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/graph_heading.dart';
import '../widgets/main_drawer.dart';
import '../widgets/site_alarms_chart.dart';
import '../widgets/site_data_container.dart';
import '../widgets/site_wise_alarm_container.dart';
import '../widgets/solar_energy_chart.dart';

class OnMScreen extends StatefulWidget {
  static const routeName = '/onm';
  static bool isChecked = false;

  @override
  State<OnMScreen> createState() => _OnMScreenState();
}

class _OnMScreenState extends State<OnMScreen> {
  final box = GetStorage();
  Future<Map<String, dynamic>>? futureData;
  String siteName = "";
  late StreamController _postsController;
  Timer? timer;
  Future<Map<String, dynamic>>? futureAlarms;

  @override
  void initState() {
    super.initState();

    getOnMData();
    getAlarms();
  }

  Timer? _startTimerPeriodic(int millisec) {
    timer =
        Timer.periodic(Duration(milliseconds: millisec), (Timer _timer) async {
      // Your code here;
      getOnMData();

      if (millisec == 0) {
        timer?.cancel();
        _startTimerPeriodic(6000000);
        print("yimer");
      }
    });

    return timer;
  }

  Timer makePeriodicTimer(
    Duration duration,
    void Function(Timer timer) callback, {
    bool fireNow = false,
  }) {
    var timer = Timer.periodic(duration, callback);
    if (fireNow) {
      callback(timer);
    }
    return timer;
  }

  @override
  Widget build(BuildContext context) {
    AppScale _scale = AppScale(context);
    bool isChecked = false;

    return Scaffold(
        bottomNavigationBar: BottomNavBar(),
        resizeToAvoidBottomInset: false,
        //   extendBodyBehindAppBar: true,
        appBar: BaseAppBar(AppBar(), "Operation and Maintenance"),
        drawer: MainDrawer(),
        body: SingleChildScrollView(
          child: Container(
            color: Colors.black26,
            // height:  MediaQuery.of(context).size.height * 1.6,
            margin: EdgeInsets.only(bottom: 5.h),
            alignment: Alignment.topLeft,
            child: FutureBuilder<Map<String, dynamic>>(
                future: futureData,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return FutureBuilder<Map<String, dynamic>>(
                        future: futureAlarms,
                        builder:
                            (BuildContext context, AsyncSnapshot alarmSnapshot) {
                          if (alarmSnapshot.hasData) {
                            alarms = formAlarmsList(alarmSnapshot.data);

                            return Column(
                              children: [
                                Container(
                                  padding:
                                      EdgeInsets.only(left: 2.h, right: 2.h),
                                  //color: Colors.black26,
                                  height: 16.h,
                                  width: MediaQuery.of(context).size.width,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Center(
                                      child: Wrap(spacing: 1.h, children: [
                                        AlarmDataContainer(
                                            Strings.criticalAlarms,
                                            snapshot.data[
                                            UserTableKeys.criticalAlarms]),
                                        AlarmDataContainer(
                                            Strings.majorAlarms,
                                            snapshot.data[
                                                UserTableKeys.majorAlarms]),
                                        AlarmDataContainer(
                                            Strings.minorAlarms,
                                            snapshot.data[
                                                UserTableKeys.minorAlarms]),
                                        AlarmDataContainer(
                                            Strings.totalSites,
                                            snapshot.data[
                                                UserTableKeys.totalSites]),
                                        AlarmDataContainer(
                                            Strings.platinumSites,
                                            snapshot.data[
                                                UserTableKeys.platinumSites]),
                                        AlarmDataContainer(
                                            Strings.goldCustomer,
                                            snapshot.data[
                                                UserTableKeys.goldCustomer]),
                                        AlarmDataContainer(
                                            Strings.silverCustomer,
                                            snapshot.data[
                                                UserTableKeys.silverCustomer]),
                                        AlarmDataContainer(
                                            Strings.otherSites,
                                            snapshot.data[
                                                UserTableKeys.otherCustomer]),
                                      ]),
                                    ),
                                  ),
                                ),
                                Container(
                                  color: Colors.white,
                                  child: Padding(
                                    padding: EdgeInsets.all(2.h),
                                    child: Column(
                                      children: [
                                        SiteAlarmsChart(
                                            getInverterData(snapshot
                                                .data["site_wise_alarms"]),
                                            Utility.getLabelData(
                                                snapshot, 'site_wise_alarms')),
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                        getAlarmData(snapshot)
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Container(
                                  height: alarms.isNotEmpty ? 20.h : 10.h,
                                  color: Colors.white,
                                  child: Padding(
                                    padding: EdgeInsets.only(bottom:2.h,top: 1.h,left: 2.h,right: 2.h),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ListHeading(
                                          Strings.unresolvedTckts,

                                        ),
                                        SizedBox(
                                          height: 1.h,
                                        ),
                                        getAlarmLiveData()
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                getContractorList(snapshot),
                                SizedBox(
                                  height: 1.h,
                                ),
                                getSupplierList(snapshot),
                                SizedBox(
                                  height: 1.h,
                                ),
                                getOnMList(snapshot)
                              ],
                            );
                          } else {
                            EasyLoading.dismiss();
                            return Center(
                                // child: Text("Loading..."),
                                );
                          }
                        });
                  } else {
                    EasyLoading.dismiss();
                    return Center(
                        // child: Text("Loading..."),
                        );
                  }
                }),
          ),
        ));
  }

  Widget getAlarmData(AsyncSnapshot snapshot) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Center(
        child: Wrap(spacing: 1.h, children: [
          SiteAlarmContainer(
            Strings.resolved,
            snapshot.data['resolved'],
          ),
          SiteAlarmContainer(
            Strings.received,
            snapshot.data['recieved'],
          ),
          SiteAlarmContainer(
            Strings.avFirstResponseTime,
            snapshot.data['avg_first_response'],
          ),
          SiteAlarmContainer(
            Strings.avResponseTime,
            snapshot.data['avg_response'],
          ),
          SiteAlarmContainer(
            Strings.resolutionSLA,
            snapshot.data['resolution_sla'],
          ),
        ]),
      ),
    );
  }

  Widget getContractorList(AsyncSnapshot snapshot) {
    List data = snapshot.data["Contractor"];
    List<Contractor> contractors = [];
    for (int i = 0; i < data.length; i++) {
      List c = data[i];
      Contractor contractor = Contractor(c[0], i + 1, c[1]);
      contractors.add(contractor);
    }
    AppScale _scale = AppScale(context);

    return Container(
      height: 28.h,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 2.h, top: 1.h),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: ListHeading("Contractor Ranking")),
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          Container(
            padding: EdgeInsets.only(left: 2.h, right: 2.h),
            height: 5.h,
            color: AppColors.darkBlue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Contractors',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: _scale.normalTxt,
                      color: Colors.white,
                    )),
                Text('Rank',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: _scale.normalTxt,
                      color: Colors.white,
                    )),
                Text('Score',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: _scale.normalTxt,
                      color: Colors.white,
                    )),
              ],
            ),
          ),
          Divider(
            height: 1.h,
            color: AppColors.greyBg,
          ),
          Container(
            constraints:
                BoxConstraints(minWidth: double.infinity, maxHeight: 17.h),
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return Divider(
                  height: 1.h,
                  color: AppColors.greyBg,
                );
              },
              padding: EdgeInsets.zero,
              itemCount: contractors.length,
              itemBuilder: (context, index) {
                return ContractorItem(contractors[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget getSupplierList(AsyncSnapshot snapshot) {
    List data = snapshot.data["Supplier"];
    List<Contractor> contractors = [];
    for (int i = 0; i < data.length; i++) {
      List c = data[i];
      Contractor contractor = Contractor(c[0], i + 1, c[1]);
      contractors.add(contractor);
    }

    AppScale _scale = AppScale(context);
    return Container(
      height: 28.h,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 2.h, top: 1.h),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: ListHeading("Supplier Ranking")),
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          Container(
            padding: EdgeInsets.only(left: 2.h, right: 2.h),
            height: 5.h,
            color: AppColors.darkBlue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Suppliers',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: _scale.normalTxt,
                      color: Colors.white,
                    )),
                Text('Rank',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: _scale.normalTxt,
                      color: Colors.white,
                    )),
                Text('Score',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: _scale.normalTxt,
                      color: Colors.white,
                    )),
              ],
            ),
          ),
          Divider(
            height: 1.h,
            color: AppColors.greyBg,
          ),
          Container(
            constraints:
                BoxConstraints(minWidth: double.infinity, maxHeight: 17.h),
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return Divider(
                  height: 1.h,
                  color: AppColors.greyBg,
                );
              },
              padding: EdgeInsets.zero,
              itemCount: contractors.length,
              itemBuilder: (context, index) {
                return ContractorItem(contractors[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Alarm> alarms = [];

  Widget getAlarmLiveData() {

    if (alarms.isNotEmpty) {
      return Expanded(
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.zero,
          itemCount: alarms.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(right: 1.h),
              child: CriticalTicketsItem(alarms[index]),
            );
          },
        ),
      );
    }
    else {
      return Container();
    }
  }


  List<Alarm> formAlarmsList(Map<String, dynamic> data) {
    List<Alarm> alarmsData = [];

    if (data.entries.isNotEmpty) {
      List sites = data['alarms'];
      print("vals " + sites.length.toString());
      for (int i = 0; i < sites.length; i++) {
        List data = sites[i];
        if(data[8] == 'Critical') {
          Alarm site = Alarm(
              data[1],
              data[4],
              data[2],
              data[3],
              data[6],
              data[5],
              data[8],
              data[7]);
          alarmsData.add(site);
        }
      }
    }

    //  data.forEach((k, v) => print('${k}: ${v}'));
    return alarmsData;
  }


  Widget getOnMList(AsyncSnapshot snapshot) {
    List data = snapshot.data["onm"];
    List<Contractor> contractors = [];
    for (int i = 0; i < data.length; i++) {
      List c = data[i];
      Contractor contractor = Contractor(c[0], i + 1, c[1]);
      contractors.add(contractor);
    }
    AppScale _scale = AppScale(context);

    return Container(
      height: 28.h,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 2.h, top: 1.h),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: ListHeading("O&M Ranking")),
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          Container(
            padding: EdgeInsets.only(left: 2.h, right: 2.h),
            height: 5.h,
            color: AppColors.darkBlue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Suppliers',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: _scale.normalTxt,
                      color: Colors.white,
                    )),
                Text('Rank',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: _scale.normalTxt,
                      color: Colors.white,
                    )),
                Text('Score',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: _scale.normalTxt,
                      color: Colors.white,
                    )),
              ],
            ),
          ),
          Divider(
            height: 1.h,
            color: AppColors.greyBg,
          ),
          Container(
            constraints:
                BoxConstraints(minWidth: double.infinity, maxHeight: 17.h),
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return Divider(
                  height: 1.h,
                  color: AppColors.greyBg,
                );
              },
              padding: EdgeInsets.zero,
              itemCount: contractors.length,
              itemBuilder: (context, index) {
                return ContractorItem(contractors[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  void getOnMData() async {
    EasyLoading.show();
    Map<String, String> headers = {
      'Authorization': "JWT " + box.read(Strings.token),
    };

    futureData = NetworkAPI().httpFetchData(ServiceUrl.oNmUrl, headers);
  }

  void onFailureAlert() {
    Navigator.of(context).pop(); // dismiss dialog
  }

  List<SolarData> getEnergyMix(AsyncSnapshot snapshot) {
    List<SolarData> coordinates = [];
    Map<String, dynamic> data = snapshot.data;
    List prComparison = data["solar_hourly"];
    List<dynamic> y1List = prComparison[0];
    List<dynamic> xCoords = prComparison[1];

    print("EnergyMix " + xCoords.length.toString());

    for (int j = 0; j < y1List.length; j++) {
      String x = xCoords[j];
      double y1 = y1List[j];
      print("x time: " + x);
      //EnergyMixData data = EnergyMixData(x, y1);
      //coordinates.add(data);
    }

    final List<KPIData> chartData = [
      KPIData('Site_A', 28, 50),
      KPIData('Site_B', 12, 90),
      KPIData('Site_C', 107, 90),
      KPIData('Site_D', 87, 71),
    ];
    //coordinates = chartData;

    return coordinates;
  }

  List<List<ChartDataP>> getInverterData(List prComparison) {
    List<List<ChartDataP>> coordinates = [];
    int length = prComparison.length;

    List<dynamic> xCoords = prComparison[length - 1];
    List<dynamic> labels = prComparison[length - 2];

    for (int i = 0; i < labels.length; i++) {
      List<dynamic> yList = prComparison[i];

      final List<ChartDataP> chartData = [];
      for (int j = 0; j < yList.length; j++) {
        chartData.add(ChartDataP(
          xCoords[j],
          yList[j],
        ));
      }
      coordinates.add(chartData);
    }

    return coordinates;
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

  /* List<SiteAlamrs> getInverterData(AsyncSnapshot snapshot) {
    List<SiteAlamrs> coordinates = [];
    Map<String, dynamic> data = snapshot.data;
    List prComparison = data["site_wise_alarms"];
    List<dynamic> y1List = prComparison[0];
    List<dynamic> y2List = prComparison[1];
    List<dynamic> y3List = prComparison[2];

    List<dynamic> xCoords = prComparison[3];

    print("InverterHourlyData " + xCoords.length.toString());

    for (int j = 0; j < y1List.length; j++) {
      String x = xCoords[j];
      int y1 = y1List[j];
      int y2 = y2List[j];
      int y3 = y3List[j];

      SiteAlamrs data = SiteAlamrs(x, y1, y2, y3);
      coordinates.add(data);
    }

    final List<KPIData> chartData = [
      KPIData('Site_A', 28, 50),
      KPIData('Site_B', 12, 90),
      KPIData('Site_C', 107, 90),
      KPIData('Site_D', 87, 71),
    ];
    // coordinates = chartData;

    return coordinates;
  }*/

  List<SolarData> getSolarHourlyData(AsyncSnapshot snapshot) {
    List<SolarData> coordinates = [];
    Map<String, dynamic> data = snapshot.data;
    List prComparison = data["pr_hourly"];
    List<dynamic> y1List = prComparison[0];
    List<dynamic> xCoords = prComparison[1];

    print("EnergyMix " + xCoords.length.toString());

    for (int j = 0; j < y1List.length; j++) {
      String x = xCoords[j];
      double y1 = y1List[j];
      //    EnergyMixData data = EnergyMixData(x, y1);
      //   coordinates.add(data);
    }

    final List<KPIData> chartData = [
      KPIData('Site_A', 28, 50),
      KPIData('Site_B', 12, 90),
      KPIData('Site_C', 107, 90),
      KPIData('Site_D', 87, 71),
    ];
    // coordinates = chartData;

    return coordinates;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    //timer?.cancel();
    //_postsController.close();
    print("SITE DISPOSE");

    super.dispose();
  }
}
