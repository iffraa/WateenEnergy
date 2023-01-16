import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../models/testenergy.dart';
import '../utils/AppScale.dart';
import '../utils/colour.dart';
import '../utils/utility.dart';
import 'graph_heading.dart';

class HorizontalBarChart extends StatefulWidget {
  final List<CityData> chartData;

  HorizontalBarChart(this.chartData);

  @override
  State<HorizontalBarChart> createState() => _HorizontalBarChartState();
}

class _HorizontalBarChartState extends State<HorizontalBarChart> {
  late ZoomPanBehavior _zoomPanBehavior;
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    super.initState();
    _tooltipBehavior = Utility.getToolTipStyle();
    _zoomPanBehavior = ZoomPanBehavior(
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
        GraphHeading("Number Of Sites - Installed"),
        SizedBox(height: 1.h,),
        Row(
          children: [
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
              "Number Of Sites",
              style: TextStyle(fontSize: _scale.axisHeading),
              textAlign: TextAlign.start,
            ),
          ],
        ),
        SfCartesianChart(
               tooltipBehavior: _tooltipBehavior,
            enableAxisAnimation: true,
            zoomPanBehavior: _zoomPanBehavior,
            margin: EdgeInsets.only(top: 2.h,left: 6.h),

            primaryYAxis:
                NumericAxis(desiredIntervals: 4, minimum: 0, maximum: Utility.getMaxXAxisValue(widget.chartData)),
            primaryXAxis: CategoryAxis(labelRotation: -90,
                ),
            series: <ChartSeries>[
              StackedBarSeries<CityData, String>(
                name: "Performance Ratio",
                  color: AppColors.darkBlue,
                 // dataLabelSettings: DataLabelSettings(isVisible: true),
                  dataSource: widget.chartData,
                  xValueMapper: (CityData data, _) => data.x,
                  yValueMapper: (CityData data, _) => data.y),
            ]),
      ],
    );
  }
}
