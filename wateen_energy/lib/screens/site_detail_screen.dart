import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wateen_energy/models/testenergy.dart';
import 'package:wateen_energy/widgets/performance_line_chart.dart';
import '../services/network_api.dart';
import '../services/service_url.dart';
import '../utils/AppScale.dart';
import '../utils/colour.dart';
import '../utils/strings.dart';
import '../utils/user_table.dart';
import '../utils/utility.dart';
import '../widgets/AnimationDemo.dart';
import '../widgets/SiteAnimation.dart';
import '../widgets/base_app_bar.dart';
import '../widgets/dynamic_line_chart.dart';
import '../widgets/energy_mix_chart.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/main_drawer.dart';
import '../widgets/site_data_container.dart';
import '../widgets/solar_energy_chart.dart';
import '../widgets/weather_dialog.dart';

class SiteDetailScreen extends StatefulWidget {
  static const routeName = '/sitewise';
  static bool isChecked = false;

  @override
  State<SiteDetailScreen> createState() => _SiteDetailScreenState();
}

class _SiteDetailScreenState extends State<SiteDetailScreen> {
  final box = GetStorage();
  Future<Map<String, dynamic>>? futureData;
  String siteName = "";
  late StreamController _postsController;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      setState(() {
        siteName = ModalRoute.of(context)!.settings.arguments as String;
      });
      getSolarSite();
    });
  }

  Timer? _startTimerPeriodic(int millisec) {
    timer =
        Timer.periodic(Duration(milliseconds: millisec), (Timer _timer) async {
      // Your code here;
      getSolarSite();

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
        //  extendBodyBehindAppBar: true,
        appBar: BaseAppBar(AppBar(), siteName),
        drawer: MainDrawer(),
        body: SingleChildScrollView(
          child: Container(
            // height:  MediaQuery.of(context).size.height,
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.03, bottom: 2.h),
            alignment: Alignment.topLeft,
            child: FutureBuilder<Map<String, dynamic>>(
                future: futureData,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  //  print('Has error: ${snapshot.hasError}');
                  print('Has data: ${snapshot.hasData}');
                  print('Snapshot Data ${snapshot.data}');
                  print('ConnectionState ${snapshot.connectionState}');

                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 2.h, right: 2.h),
                          color: AppColors.greyBg,
                          height: 16.h,
                          width: MediaQuery.of(context).size.width,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Center(
                              child: Wrap(spacing: 1.h, children: [
                                SiteDataContainer(Strings.todayRevenue,
                                    snapshot.data[UserTableKeys.todayRevenue]),
                                SiteDataContainer(Strings.cuf,
                                    snapshot.data[UserTableKeys.cuf]),
                                SiteDataContainer(Strings.yield,
                                    snapshot.data[UserTableKeys.todaysYield]),
                                SiteDataContainer(Strings.activeFaults,
                                    snapshot.data[UserTableKeys.activeFaults]),
                                SiteDataContainer(Strings.systemSize,
                                    snapshot.data[UserTableKeys.systemSize]),
                                SiteDataContainer(
                                    Strings.performanceRatio,
                                    snapshot
                                        .data[UserTableKeys.performanceRatio]),
                                SiteDataContainer(
                                    Strings.tcpr,
                                    snapshot.data[
                                        UserTableKeys.tcPerformanceRatio]),
                              ]),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(2.h),
                          child: Column(
                            children: [

                              Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                    alignment: Alignment.topRight,
                                    //  padding:  EdgeInsets.only(top: 2.h),
                                    icon: Image.asset(
                                      'assets/images/weather.png',
                                    ),
                                    onPressed: () =>{
                                      showDialog(
                                          context: context,
                                          builder: (_) => WeatherDialog(snapshot.data["longitude"],snapshot.data["latitude"])
                                      )}
                                ),
                              ),
                              SiteAnimation(
                                  animation: snapshot.data["animation"]),

                              EnergyMixChart(getEnergyMix(snapshot.data["solar_hourly"]), getLabels(snapshot,"solar_hourly"),"Energy Mix",siteName),
                              SizedBox(
                                height: 5.h,
                              ),
                              DynamicLineChart(getDynamicInverterData(snapshot), getLabels(snapshot, "inverter_hourly")),
                              SizedBox(
                                height: 5.h,
                              ),
                             // SolarEnergyChart(getSolarHourlyData(snapshot)),
                            //  EnergyMixChart(getEnergyMix(snapshot.data["actual_vs_solar"]), getLabels(snapshot,"actual_vs_solar"),"Actual Solar VS Expected Solar",siteName),

                            ],
                          ),
                        ),

                        // Energy mix graph
                      ],
                    );
                  } else {
                    EasyLoading.dismiss();
                    return Center(
                    );
                  }
                }),
          ),
        ));
  }

  void handleResponse() {
    String res = '';
  }

  void getSolarSite() async {
    Map<String, dynamic> postData = {
      UserTableKeys.siteName: siteName,
    };

    GetStorage box = GetStorage();
    Map<String, String> headers = {
      'Authorization': "JWT " + box.read(Strings.token),
    };



    EasyLoading.show();
    futureData = NetworkAPI()
        .httpGetGraphData(ServiceUrl.perfSolarSiteUrl, headers, postData);
  }

  void onFailureAlert() {
    Navigator.of(context).pop(); // dismiss dialog
  }

  List<List<ChartDataP>> getEnergyMix(List prComparison) {
    List<List<ChartDataP>> coordinates = [];
    int length = prComparison.length;

    List<dynamic> xCoords = prComparison[length - 1];
    List<dynamic> labels = prComparison[length - 2];

    print("EnergyMix " + xCoords.length.toString());

    for (int i = 0; i < labels.length; i++) {
      List<dynamic> yList = prComparison[i];

      final List<ChartDataP> chartData = [];
      for (int j = 0; j < yList.length; j++) {

        chartData.add(ChartDataP(
          xCoords[j],
          yList[j] ,
        ));
      }
      coordinates.add(chartData);
    }


    return coordinates;
  }

  List<InverterHourlyData> getInverterData(AsyncSnapshot snapshot) {
    List<InverterHourlyData> coordinates = [];
    Map<String, dynamic> data = snapshot.data;
    List prComparison = data["inverter_hourly"];
    List<dynamic> y1List = prComparison[0];
    List<dynamic> y2List = prComparison[1];
    List<dynamic> xCoords = prComparison[3];

    print("InverterHourlyData " + xCoords.length.toString());

    for (int j = 0; j < y1List.length; j++) {
      String x = xCoords[j];
      double y1 = y1List[j];
      double y2 = y2List[j];

      InverterHourlyData data = InverterHourlyData(x, y1, y2);
      coordinates.add(data);
    }

    return coordinates;
  }

  List<dynamic> getLabels(AsyncSnapshot snapshot, String key)
  {
    Map<String, dynamic> data = snapshot.data;
    List prComparison = data[key];
    int length = prComparison.length;
    List<dynamic> labels = prComparison[length - 2];
    return labels;
  }

  List<List<ChartDataP>> getDynamicInverterData(AsyncSnapshot snapshot) {
    final List<List<ChartDataP>> coordinates = [];
    Map<String, dynamic> data = snapshot.data;
    List prComparison = data["inverter_hourly"];
    int length = prComparison.length;

    List<dynamic> xCoords = prComparison[length - 1];
    List<dynamic> labels = prComparison[length - 2];


    for (int i = 0; i < labels.length; i++) {
      List<dynamic> yList = prComparison[i];

      final List<ChartDataP> chartData = [];
      for (int j = 0; j < yList.length; j++) {
        chartData.add(ChartDataP(xCoords[j],yList[j],));
      }
      coordinates.add(chartData);
    }
    return coordinates;
  }




  List<SolarData> getSolarHourlyData(AsyncSnapshot snapshot) {
    List<SolarData> coordinates = [];
    Map<String, dynamic> data = snapshot.data;
    List prComparison = data["solar_hourly"];
    List<dynamic> y1List = prComparison[0];
    List<dynamic> y2List = prComparison[1];
    List<dynamic> y3List = prComparison[2];
    List<dynamic> y4List = prComparison[3];

    List<dynamic> xCoords = prComparison[4];

    print("EnergyMix " + xCoords.length.toString());

    for (int j = 0; j < y1List.length; j++) {
      String x = xCoords[j];
      double y1 = y1List[j];
      int y2 = y2List[j];
      int y3 = y3List[j];
      int y4 = y4List[j];

      SolarData data = SolarData(x, y1, y2, y3, y4);
      coordinates.add(data);
    }

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
