import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wateen_energy/utils/strings.dart';

import '../models/testenergy.dart';
import '../utils/AppScale.dart';
import '../utils/colour.dart';
import '../utils/utility.dart';
import 'date_range_picker.dart';
import 'energy_mix_button.dart';
import 'graph_heading.dart';

class EnergyMixChart extends StatefulWidget {
  final List<List<ChartDataP>> chartData;
  final List<dynamic> labels;
  final String title;

  EnergyMixChart(this.chartData, this.labels, this.title);

  @override
  State<EnergyMixChart> createState() => _EnergyMixChartState();
}

class _EnergyMixChartState extends State<EnergyMixChart> {
  late ZoomPanBehavior _zoomPanBehavior;
  late TooltipBehavior _tooltipBehavior;
  bool isDayClicked = true;
  String label = "Load";

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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GraphHeading(widget.title),
        widget.title.contains("Energy") ? SizedBox(height: 2.h,): Container(),
        widget.title.contains("Energy") ? getButtons() : Container(),
        Utility.getChartLabels(widget.labels),

        SfCartesianChart(
            tooltipBehavior: _tooltipBehavior,
            enableAxisAnimation: true,
            margin: EdgeInsets.zero,
            zoomPanBehavior: _zoomPanBehavior,
            primaryXAxis: CategoryAxis(
             /*   title: AxisTitle(
                    text: Strings.time,
                    textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: _scale.axisHeading))*/),
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


  List<ColumnSeries<ChartDataP, String>> getBarSeries() {
    List<ColumnSeries<ChartDataP, String>> lineSeries = [];
    for (int i = 0; i < widget.chartData.length; i++) {
      lineSeries.add(ColumnSeries(
          color: (i == 0) ? AppColors.darkBlue : AppColors.lightBlue,
          name: widget.labels[i].toString(),
          dataSource: widget.chartData[i],
          xValueMapper: (ChartDataP data, _) => data.x,
          yValueMapper: (ChartDataP data, _) => data.y));
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
    setState(() {
      isDayClicked = true;
    });
  }

  void onMonthClicked() {
    setState(() {
      isDayClicked = false;
    });
  }

  void onYearClicked() {}

  void onRangeClicked() async {
    AppScale _scale = AppScale(context);
    DateTime startDate = DateTime.now();
    DateTime endDate = DateTime.now();

    final picked = await showDateRangePicker(
        context: context,
        lastDate: endDate,
        firstDate: new DateTime(2019),
        builder: (context, child) {
          return Column(
            children: [
              Center(
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
            ],
          );
        });

    String? start = picked?.start.toString();
    print("date " + start!);
  }

  void onDateSelected(String date) {}
}
