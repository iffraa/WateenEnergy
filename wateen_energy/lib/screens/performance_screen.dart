import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wateen_energy/models/testenergy.dart';
import 'package:wateen_energy/screens/site_detail_screen.dart';
import 'package:wateen_energy/widgets/doughnut_chart.dart';
import 'package:wateen_energy/widgets/horizontal_bar_chart.dart';
import 'package:wateen_energy/widgets/pie_chart.dart';
import '../services/network_api.dart';
import '../services/service_url.dart';
import '../utils/AppScale.dart';
import '../utils/colour.dart';
import '../utils/strings.dart';
import '../utils/user_table.dart';
import '../utils/utility.dart';
import '../widgets/base_app_bar.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/dropdown.dart';
import '../widgets/main_drawer.dart';
import '../widgets/site_map.dart';
import '../widgets/total_data_container.dart';
import '../widgets/vertical_bar_chart.dart';
import '../widgets/weather_dialog.dart';

class PerformanceScreen extends StatefulWidget {
  static const routeName = '/dashboard';
  static bool isChecked = false;

  @override
  State<PerformanceScreen> createState() => _PerformanceScreenState();
}

class _PerformanceScreenState extends State<PerformanceScreen> {
  final box = GetStorage();
  Future<Map<String, dynamic>>? futureData;
  late TooltipBehavior _tooltipBehavior;
  late StreamController _postsController;

  @override
  void initState() {
    super.initState();
    _tooltipBehavior = TooltipBehavior(enable: true);
    getSolarOverview();
  }

  int i = 0;

  @override
  Widget build(BuildContext context) {
    AppScale _scale = AppScale(context);
    _tooltipBehavior = TooltipBehavior(enable: true);

    return Scaffold(
        bottomNavigationBar: BottomNavBar(),
        resizeToAvoidBottomInset: false,
        //   extendBodyBehindAppBar: true,
        appBar: BaseAppBar(AppBar(), "Overview"),
        drawer: MainDrawer(),
        body: SingleChildScrollView(
          child: Container(
            // padding: EdgeInsets.only(left: 5.h,right: 5.h),
            // height:  MediaQuery.of(context).size.height,
            //alignment: Alignment.topLeft,
            child: FutureBuilder<Map<String, dynamic>>(
                future: futureData,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    EasyLoading.dismiss();
                    print("New Data is here");
                    return Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 1.h, right: 1.h),
                          color: AppColors.greyBg,
                          height: 21.h,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Wrap(
                                alignment: WrapAlignment.center,
                                children: [
                                  DropdownSpinner(
                                      getDropdownData(snapshot, Strings.city),
                                      Strings.city,
                                      onCitySelected,false),
                                  SizedBox(
                                    width: 2.h,
                                  ),
                                  DropdownSpinner(
                                      getDropdownData(snapshot, Strings.site),
                                      Strings.site,
                                      onSiteSelected,false),
                                  SizedBox(
                                    width: 2.h,
                                  ),
                                  DropdownSpinner(
                                      getDropdownData(snapshot, Strings.region),
                                      Strings.region,
                                      onRegionSelected,false),
                                ],
                              ),

                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Wrap(
                                  spacing: 1.4.h,
                                  children: [
                                    TotalDataContainer(Strings.commercialSites,
                                        snapshot.data['commercial_sites']),
                                    TotalDataContainer(Strings.industrialSites,
                                        snapshot.data['industrial_sites']),
                                    TotalDataContainer(Strings.residentialSites,
                                        snapshot.data['resedential_sites']),
                                    TotalDataContainer(Strings.activeAlarms,
                                        snapshot.data['active_alarms']),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(3.h),
                          child: Column(
                            children: [

                              HorizontalBarChart(getCitySites(snapshot)),
                              SizedBox(
                                height: 3.h,
                              ),
                              VerticalBarChart(getDynamicKPICoordinates(snapshot),getLabels(snapshot)),
                            ],
                          ),
                        ),
                      ],
                    );
                  } else {
                    EasyLoading.dismiss();
                    return Container();
                  }
                }),
          ),
        ));
  }

  List<dynamic> getLabels(AsyncSnapshot snapshot)
  {
    Map<String, dynamic> data = snapshot.data;
    List prComparison = data["pr_comparison"];
    int length = prComparison.length;
    List<dynamic> labels = prComparison[length - 2];
    return labels;
  }

  List<KPIData> getKPICoordinates(AsyncSnapshot snapshot) {
    List<KPIData> coordinates = [];
    Map<String, dynamic> data = snapshot.data;
    List prComparison = data["pr_comparison"];
    List<dynamic> y1List = prComparison[0];
    List<dynamic> y2List = prComparison[1];
    List<dynamic> xCoords = prComparison[2];

    print("prComparison " + xCoords.length.toString());

    for (int j = 0; j < y1List.length; j++) {
      String x = xCoords[j];
      double y1 = y1List[j];
      double y2 = y2List[j];
      KPIData data = KPIData(x, y1, y2);
      coordinates.add(data);
    }

    return coordinates;
  }

  List<List<ChartDataP>> getDynamicKPICoordinates(AsyncSnapshot snapshot) {
    final List<List<ChartDataP>> coordinates = [];
    Map<String, dynamic> data = snapshot.data;
    List prComparison = data["pr_comparison"];
    int length = prComparison.length;

    List<dynamic> xCoords = prComparison[length - 1];
    List<dynamic> labels = prComparison[length - 2];

    print("prComparison " + xCoords.length.toString());

    for (int i = 0; i < 2; i++) {//labels.length
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

  List<String> getDropdownData(AsyncSnapshot snapshot, String type) {
    List<String> dataList = [];
    switch (type) {
      case Strings.city:
        // dataList[0] = type;
        dataList = snapshot.data["city_list"].cast<String>();
        //     dataList.insert(0,type);
        print(dataList);
        break;
      case Strings.region:
        dataList = snapshot.data["region_list"].cast<String>();
        //   dataList.insert(0,type);
        break;
      case Strings.site:
        List prComparison = snapshot.data["pr_comparison"];
        List<dynamic> sites = prComparison[prComparison.length - 1];
        dataList = sites.cast<String>();
        // dataList.insert(0,type);
        break;
    }
    return dataList;
  }

  List<CityData> getCitySites(AsyncSnapshot snapshot) {
    List<CityData> coordinates = [];
    Map<String, dynamic> data = snapshot.data;
    List prComparison = data["city_sites"];
    List<dynamic> yList = prComparison[0];
    List<dynamic> cityNames = prComparison[2];

    for (int j = 0; j < yList.length; j++) {
      String x = cityNames[j];
      int y = yList[j];
      CityData data = CityData(x, y);
      coordinates.add(data);
    }

    return coordinates;
  }

  List<MountData> getMountCoordinates(AsyncSnapshot snapshot) {
    List<MountData> coordinates = [];
    Map<String, dynamic> data = snapshot.data;
    List prComparison = data["mount_wise"];
    List<dynamic> values = prComparison[1];
    List<dynamic> mountNames = prComparison[4];

    for (int j = 0; j < values.length; j++) {
      int x = values[j];
      String y1 = mountNames[j];
      Color color = Colors.green;
      if (j == 0) {
        color = Colors.red;
      } else if (j == 1) {
        color = Colors.yellow;
      }
      MountData data = MountData(y1, x, color);
      coordinates.add(data);
    }

    return coordinates;
  }

  String city = "all";
  String region = "all";

  void getSolarOverview() async {

    Map<String, dynamic> postData = {
      UserTableKeys.epcName: "EFC",
      UserTableKeys.city: city,
      UserTableKeys.region: region,
    };

    GetStorage box = GetStorage();
    Map<String, String> headers = {
      'Authorization': "JWT " + box.read(Strings.token),
     };

    EasyLoading.show();
    futureData = NetworkAPI()
        .httpGetGraphData(ServiceUrl.perfOverviewUrl, headers, postData);
  }

  void onFailureAlert() {
    Navigator.of(context).pop(); // dismiss dialog
  }

  void onCitySelected(String selCity) {
    print(selCity + " city SELECTED");

    setState(() {
      city = selCity;
      getSolarOverview();
    });
  }

  void onSiteSelected(String site) {
    print(site + " Site SELECTED");
    Navigator.of(context)
        .pushNamed(SiteDetailScreen.routeName, arguments: site);
  }

  void onRegionSelected(String region) {
    print(region + " region SELECTED");
  }

  @override
  void dispose() {

  }
}
