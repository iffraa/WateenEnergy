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
  final List<SiteAlamrs> chartData;

  SiteAlarmsChart(this.chartData);

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
        GraphHeading("Site Wise Alarms as of May 2019, 09:41 PM"),
        SizedBox(height: 0.8.h,),
        Row(
          children: [
            Container(
              height: 0.8.h,
              width: 4.h,
              decoration: BoxDecoration(
                  color: AppColors.lightBlue,
                  borderRadius: BorderRadius.all(Radius.circular(1.h))),
            ),
            SizedBox(
              width: 2.h,
            ),
            Text(
              "Major",
              style: TextStyle(fontSize: _scale.axisHeading),
              textAlign: TextAlign.start,
            ),
            SizedBox(width: 4.h,),
            Container(
              height: 0.8.h,
              width: 4.h,
              decoration: BoxDecoration(
                  color: Colors.lightBlue,
                  borderRadius: BorderRadius.all(Radius.circular(1.h))),
            ),
            SizedBox(
              width: 2.h,
            ),
            Text(
              "Minor",
              style: TextStyle(fontSize: _scale.axisHeading),
              textAlign: TextAlign.start,
            ),
            SizedBox(width: 4.h,),
            Container(
              height: 0.8.h,
              width: 4.h,
              decoration: BoxDecoration(
                  color: AppColors.darkBlue,
                  borderRadius: BorderRadius.all(Radius.circular(1.h))),
            ),
            SizedBox(
              width: 2.h,
            ),
            Text(
              "Critical",
              style: TextStyle(fontSize: _scale.axisHeading),
              textAlign: TextAlign.start,
            ),

          ],
        ),

        SfCartesianChart(
            tooltipBehavior: _tooltipBehavior,
            enableAxisAnimation: true,
            margin: EdgeInsets.only(top: 2.h),
                primaryXAxis: CategoryAxis(),
            primaryYAxis:
                NumericAxis( minimum: 0, maximum: 1),
            enableSideBySideSeriesPlacement: true,
            series: <ChartSeries<SiteAlamrs, String>>[
              ColumnSeries<SiteAlamrs, String>(
                  name: "Major",
                //  dataLabelSettings: DataLabelSettings(isVisible: true),
                  color: AppColors.lightBlue,
                  dataSource: widget.chartData,
                  xValueMapper: (SiteAlamrs data, _) => data.x,
                  yValueMapper: (SiteAlamrs data, _) => data.y1),
              ColumnSeries<SiteAlamrs, String>(
                  name: "Minor",
                  color: Colors.lightBlue,
                  dataSource: widget.chartData,
                  xValueMapper: (SiteAlamrs data, _) => data.x,
                  yValueMapper: (SiteAlamrs data, _) => data.y2),
              ColumnSeries<SiteAlamrs, String>(
                  name: "Critical",
                  color: AppColors.darkBlue,
                  dataSource: widget.chartData,
                  xValueMapper: (SiteAlamrs data, _) => data.x,
                  yValueMapper: (SiteAlamrs data, _) => data.y3)
            ]),
      ],
    );
  }
}
