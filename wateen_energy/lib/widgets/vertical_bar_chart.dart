import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../models/testenergy.dart';
import '../utils/AppScale.dart';
import '../utils/colour.dart';
import '../utils/utility.dart';
import 'graph_heading.dart';

class VerticalBarChart extends StatefulWidget {
  final List<List<ChartDataP>> chartData;
  final List<dynamic> labels;

  VerticalBarChart(this.chartData, this.labels);

  @override
  State<VerticalBarChart> createState() => _VerticalBarChartState();
}

class _VerticalBarChartState extends State<VerticalBarChart> {
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
        GraphHeading("PR Comparison - Daily"),
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
              width: 1.5.h,
            ),
            Text(
              "Temp Corrected PR",
              style: TextStyle(fontSize: _scale.axisHeading),
              textAlign: TextAlign.start,
            ),

            SizedBox(width: 3.h,),
            Container(
              height: 0.8.h,
              width: 4.h,
              decoration: BoxDecoration(
                  color: AppColors.darkBlue,
                  borderRadius: BorderRadius.all(Radius.circular(1.h))),
            ),
            SizedBox(
              width: 1.5.h,
            ),
            Expanded(
              child: Text(
                "Performance Ratio",
                style: TextStyle(fontSize: _scale.axisHeading),
                textAlign: TextAlign.start,
              ),
            ),

          ],
        ),

        SfCartesianChart(
            tooltipBehavior: _tooltipBehavior,
            enableAxisAnimation: true,
            margin: EdgeInsets.only(top: 2.h),
                primaryXAxis: CategoryAxis(),
            primaryYAxis:
                NumericAxis(desiredIntervals: 4, minimum: 0, maximum: 100),
            enableSideBySideSeriesPlacement: true,
            series: getSeries()),
      ],
    );
  }

  List<ColumnSeries<ChartDataP, String>> getSeries() {
    List<ColumnSeries<ChartDataP, String>> lineSeries = [];
    for (int i = 0; i < widget.chartData.length; i++) {
      lineSeries.add(ColumnSeries(
          color: (i == 0) ? AppColors.lightBlue : AppColors.darkBlue,
          name: widget.labels[i].toString(),
          dataSource: widget.chartData[i],
          xValueMapper: (ChartDataP data, _) => data.x,
          yValueMapper: (ChartDataP data, _) => data.y));
    }
    return lineSeries;
  }
}
