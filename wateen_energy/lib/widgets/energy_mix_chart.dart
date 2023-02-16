import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wateen_energy/utils/strings.dart';

import '../models/testenergy.dart';
import '../services/network_api.dart';
import '../services/service_url.dart';
import '../utils/AppScale.dart';
import '../utils/colour.dart';
import '../utils/user_table.dart';
import '../utils/utility.dart';
import 'date_range_picker.dart';
import 'energy_mix_button.dart';
import 'graph_heading.dart';

class EnergyMixChart extends StatefulWidget {
  final List<List<ChartDataP>> chartData;
  final List<dynamic> labels;
  final String title;
  final String siteName;

  EnergyMixChart(this.chartData, this.labels, this.title, this.siteName);

  @override
  State<EnergyMixChart> createState() => _EnergyMixChartState();
}

class _EnergyMixChartState extends State<EnergyMixChart> {
  late ZoomPanBehavior _zoomPanBehavior;
  late TooltipBehavior _tooltipBehavior;
  bool isDayClicked = true;
  bool isRangeClicked = false;

  String label = "Load";
  List<List<EnergyData>> energyData = [];

  @override
  void initState() {
    super.initState();
    _tooltipBehavior = Utility.getToolTipStyle();
    _zoomPanBehavior = ZoomPanBehavior(
      // Enables pinch zooming
      enablePinching: true,
      enableDoubleTapZooming: true,
      zoomMode: ZoomMode.x,
      enablePanning: true,
      /* enableSelectionZooming: true,
        selectionRectBorderColor: Colors.red,
        selectionRectBorderWidth: 1,
        selectionRectColor: Colors.grey*/
    );
  }

  @override
  Widget build(BuildContext context) {
    AppScale _scale = AppScale(context);
    print("Building again");

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GraphHeading(widget.title),
        widget.title.contains("Energy") ? SizedBox(height: 2.h,): Container(),
        widget.title.contains("Energy") ? getButtons() : Container(),
        Utility.getChartLabels(widget.labels, true),
        SfCartesianChart(
            tooltipBehavior: _tooltipBehavior,
            enableAxisAnimation: true,
            margin: EdgeInsets.zero,
            zoomPanBehavior: _zoomPanBehavior,
            primaryXAxis: CategoryAxis(labelRotation: -45),
            primaryYAxis: NumericAxis(
               /* title: AxisTitle(
                    text: Strings.energy,
                    textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: _scale.axisHeading))*/
                desiredIntervals: 10,
                minimum: 0,
                maximum: Utility.getMaxYAxisValue(widget.chartData)),
            series:
              isDayClicked ? getAreaSeries() : getBarSeries()
            ),
      ],
    );
  }


  List<LineSeries<ChartDataP, String>> getAreaSeries() {
    List<LineSeries<ChartDataP, String>> lineSeries = [];
    for (int i = 0; i < widget.chartData.length; i++) {
      lineSeries.add(LineSeries(
          color: (i == 0) ? AppColors.darkBlue : AppColors.lightBlue,
          name: widget.labels[i].toString(),
          dataSource: widget.chartData[i],
          xValueMapper: (ChartDataP data, _) => data.x,
          yValueMapper: (ChartDataP data, _) => data.y));
    }
    return lineSeries;
  }

  /*AreaSeries<ChartDataP, String> getAreaSeries() {
    return AreaSeries<ChartDataP, String>(
        name: label,
        color: AppColors.lightBlue.withOpacity(0.4),
        borderWidth: 0.2.h,
        borderColor: AppColors.darkBlue,
        dataSource: widget.chartData,
        xValueMapper: (ChartDataP data, _) => data.x,
        yValueMapper: (ChartDataP data, _) => data.y);
  }*/


  List<ChartSeries<ChartDataP, String>> getBarSeries() {
    print("BAR SERIES");

    List<ChartSeries<ChartDataP, String>> lineSeries = [];
   // for (int i = 0; i < widget.chartData.length; i++) {
      lineSeries.add(ColumnSeries(
          color: AppColors.darkBlue ,
          name: widget.labels[0].toString(),
          dataSource: widget.chartData[0],
          xValueMapper: (ChartDataP data, _) => data.x,
          yValueMapper: (ChartDataP data, _) => data.y)
      );

      if(!isRangeClicked){
      lineSeries.add( LineSeries<ChartDataP, String>(
          name: "P-50",
          color: Colors.red,
          dataSource: widget.chartData[1],
          xValueMapper: (ChartDataP data, _) => data.x,
          yValueMapper: (ChartDataP data, _) => data.y
      ));
    lineSeries.add( LineSeries<ChartDataP, String>(
        name: "P-90",
        color: Colors.indigo,
        dataSource: widget.chartData[2],
        xValueMapper: (ChartDataP data, _) => data.x,
        yValueMapper: (ChartDataP data, _) => data.y
    ));
    }
    return lineSeries;
  }
  /*BarSeries<ChartDataP, String> getBarSeries() {
    return BarSeries<ChartDataP, String>(
        name: label,
        color: AppColors.lightBlue.withOpacity(0.4),
        borderWidth: 0.2.h,
        borderColor: AppColors.darkBlue,
        dataSource: widget.chartData,
        xValueMapper: (ChartDataP data, _) => data.x,
        yValueMapper: (ChartDataP data, _) => data.y);
  }*/

  Widget getButtons() {
    return Row(
      children: [
        EnergyMixButton("Day", onDayClicked),
        SizedBox(
          width: 1.h,
        ),
        EnergyMixButton("Month", onMonthClicked),
        SizedBox(
          width: 1.h,
        ),
        EnergyMixButton("Year", onYearClicked),
        SizedBox(
          width: 1.h,
        ),
        EnergyMixButton("Range", onRangeClicked)
      ],
    );
  }

  void onDayClicked() {
    getDailyEnergyData(ServiceUrl.perfSolarSiteUrl, true);

  }

  void onMonthClicked() {
    getEnergyData(ServiceUrl.energyMonthlyUrl,false);
  }

  void onYearClicked() {
    getEnergyData(ServiceUrl.energyYearlyUrl,false);

  }

  void onRangeClicked() async {
    AppScale _scale = AppScale(context);
    DateTime startDate = DateTime.now();
    DateTime endDate = DateTime.now();

    final picked = await showDateRangePicker(
        context: context,
        lastDate: endDate,
        firstDate: new DateTime(2019),
        builder: (context, child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light(
                primary: AppColors.darkBlue,
              ),
            ),
            child: Center(
              child: Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.2),
                alignment: Alignment.center,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.9,
                      maxHeight: MediaQuery.of(context).size.height * 0.6),
                  child: child,
                ),
              ),
            ),
          );
        });

    String? start = picked?.start.toString();
    String? end = picked?.end.toString();
    getDateRangeEnergyData(start!, end!);
    print("date " + start!);
  }

  void onDateSelected(String date) {}

  void getEnergyData(String url,bool isDay)
  {
    url = url + UserTableKeys.siteName + "=" + widget.siteName;
    List data = [];
    EasyLoading.show();
    NetworkAPI().httpGetRequest(url, null,
            (error, response) {
          if (response != null) {
            print(response);
            if (!error) {
              url.contains(ServiceUrl.energyMonthlyUrl) ? data = response["monthly_data"] : data = response["yearly_data"];
              updateChartData(data);
              updateLabels(data);
              setState(() {
                isDayClicked = isDay;
              });
            } else {
              print("ERROR");

              // Utility.showSubmitAlert(context, response["detail"], Strings.appNameTxt, onFailureAlert);
            }
          } else {
           // Utility.showSubmitAlert(context, "Please try again later", "", onFailureAlert);
          }
          EasyLoading.dismiss();
        });
  }


  void getDailyEnergyData(String url,bool isDay)
  {
    Map<String, dynamic> postData = {
      UserTableKeys.siteName: widget.siteName,
    };

    List data = [];
    EasyLoading.show();
    NetworkAPI().httpPostData(url, null,postData,
            (error, response) {
          if (response != null) {
            print(response);
            if (!error) {
              data = response["solar_hourly"] ;
              updateChartData(data);
              updateLabels(data);
              setState(() {
                isDayClicked = isDay;
              });
            } else {
              print("ERROR");

              // Utility.showSubmitAlert(context, response["detail"], Strings.appNameTxt, onFailureAlert);
            }
          } else {
            // Utility.showSubmitAlert(context, "Please try again later", "", onFailureAlert);
          }
          EasyLoading.dismiss();
        });
  }

  void getDateRangeEnergyData(String strtDate, String endDate)
  {
    Map<String, dynamic> postData = {
      UserTableKeys.siteName: widget.siteName,
      "start_date" : strtDate.split(" ")[0],
      "end_date" : endDate.split(" ")[0]
    };

    List data = [];
    EasyLoading.show();
    NetworkAPI().httpPostRequest(ServiceUrl.energyDateUrl, null,postData,
            (status, response) {
          if (response != null) {
            print(response);
            if (status) {
              data = response["custom_data"] ;
              updateChartData(data);
              updateLabels(data);
              setState(() {
                isDayClicked = false;
                isRangeClicked = true;
              });
            } else {
              print("ERROR");

              // Utility.showSubmitAlert(context, response["detail"], Strings.appNameTxt, onFailureAlert);
            }
          } else {
            // Utility.showSubmitAlert(context, "Please try again later", "", onFailureAlert);
          }
          EasyLoading.dismiss();
        });
  }


  void updateLabels(List prComparison)
  {
    int length = prComparison.length;
    List<dynamic> labels = prComparison[length - 2];
    widget.labels.clear();
    widget.labels.addAll(labels);
  }


  List<List<ChartDataP>> updateChartData( List prComparison) {
    int length = prComparison.length;
    List<List<ChartDataP>> coordinates = [];

    List<dynamic> xCoords = prComparison[length - 1];
    List<dynamic> labels = prComparison[length - 2];

    print("EnergyMix " + xCoords.length.toString());
    widget.chartData.clear();
    for (int i = 0; i < labels.length; i++) {
      List<dynamic> yList = prComparison[i];

      final List<ChartDataP> chartData = [];
      for (int j = 0; j < yList.length; j++) {

        var x = xCoords[j];
        chartData.add(ChartDataP(
          x.toString(),
          yList[j],
        ));
      }
      coordinates.add(chartData);
      widget.chartData.add(chartData);
    }
    return coordinates;
  }

}
