import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../models/testenergy.dart';
import '../utils/AppScale.dart';
import '../utils/colour.dart';
import '../utils/utility.dart';
import 'graph_heading.dart';

class SiteAlarmsChart extends StatefulWidget {
  final List<List<ChartDataP>> chartData;
  final List<dynamic> labels;

  SiteAlarmsChart(this.chartData,this.labels);

  @override
  State<SiteAlarmsChart> createState() => _SiteAlarmsChartState();
}

class _SiteAlarmsChartState extends State<SiteAlarmsChart> {
  late ZoomPanBehavior _zoomPanBehavior;
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    super.initState();
    _tooltipBehavior =Utility.getToolTipStyle();
    _zoomPanBehavior = ZoomPanBehavior(
      // Enables pinch zooming
      enablePinching: true,
      enableDoubleTapZooming: true,
      zoomMode: ZoomMode.x,
      enablePanning: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    AppScale _scale = AppScale(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GraphHeading("Site Wise Alarms as of " + Utility.getDay(DateTime.now().weekday) + " " + DateTime.now().day.toString() +
            " " + Utility.getMonth(DateTime.now().month) + " " + DateTime.now().year.toString()),

        SizedBox(height: 0.8.h,),
        Utility.getChartLabels(widget.labels, false),
        SfCartesianChart(
            tooltipBehavior: _tooltipBehavior,
            enableAxisAnimation: true,
            margin: EdgeInsets.only(top: 2.h),
                primaryXAxis: CategoryAxis(),
            primaryYAxis:
                NumericAxis( minimum: 0, maximum: Utility.getSitesMaxYAxisValue(widget.chartData) + 5),
            enableSideBySideSeriesPlacement: true,
            series: getBarSeries()
        ),
      ],
    );
  }


  List<ChartSeries<ChartDataP, String>> getBarSeries() {

    List<ChartSeries<ChartDataP, String>> lineSeries = [];
    // for (int i = 0; i < widget.chartData.length; i++) {
    lineSeries.add(ColumnSeries(
        color: AppColors.darkBlue ,
        name: widget.labels[0].toString(),
        dataSource: widget.chartData[0],
        xValueMapper: (ChartDataP data, _) => data.x,
        yValueMapper: (ChartDataP data, _) => data.y)
    );



    return lineSeries;
  }

}
