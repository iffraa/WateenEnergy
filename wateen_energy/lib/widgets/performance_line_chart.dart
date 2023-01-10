import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../models/testenergy.dart';
import '../utils/AppScale.dart';
import '../utils/colour.dart';
import '../utils/utility.dart';
import 'graph_heading.dart';

class LineChart extends StatefulWidget {
  final List<InverterHourlyData> chartData;

  LineChart(this.chartData);

  @override
  State<LineChart> createState() => _LineChartState();
}

class _LineChartState extends State<LineChart> {
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

  List<LineSeries<InverterHourlyData, String>> getSeries() {
    List<LineSeries<InverterHourlyData, String>> lineSeries = [];
    for (int i = 0; i < widget.chartData.length; i++) {
      lineSeries.add(
          LineSeries<InverterHourlyData, String>(
              name: "Inverter 02",
              color: AppColors.lightBlue,
              dataSource: widget.chartData,
              xValueMapper: (InverterHourlyData data, _) => data.x,
              yValueMapper: (InverterHourlyData data, _) => data.y2)
      );
    }
    return lineSeries;
  }

  @override
  Widget build(BuildContext context) {
    AppScale _scale = AppScale(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GraphHeading("Inverter Wise Performance"),

        SizedBox(
          height: 2.h,
        ),
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
              "Inverter 1",
              style: TextStyle(fontSize: _scale.axisHeading),
              textAlign: TextAlign.start,
            ),
            SizedBox(
              width: 4.h,
            ),
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
              "Inverter 2",
              style: TextStyle(fontSize: _scale.axisHeading),
              textAlign: TextAlign.start,
            ),
          ],
        ),
        SizedBox(
          height: 2.h,
        ),
        SfCartesianChart(
            margin: EdgeInsets.zero,
            enableAxisAnimation: true,
            tooltipBehavior: _tooltipBehavior,
            zoomPanBehavior: _zoomPanBehavior,
            primaryXAxis: CategoryAxis(),
            primaryYAxis:
                NumericAxis(desiredIntervals: 4, minimum: 0, maximum: 100),
            enableSideBySideSeriesPlacement: true,
            series: <ChartSeries<InverterHourlyData, String>>[
              LineSeries<InverterHourlyData, String>(
                  name: "Inverter 1",
                 /* dataLabelSettings: DataLabelSettings(
                    isVisible: true,
                    showCumulativeValues: true,
                    showZeroValue: false,
                  ),*/
                  color: AppColors.darkBlue,
                  dataSource: widget.chartData,
                  xValueMapper: (InverterHourlyData data, _) => data.x,
                  yValueMapper: (InverterHourlyData data, _) => data.y1),
              LineSeries<InverterHourlyData, String>(
                  name: "Inverter 2",
                  color: AppColors.lightBlue,
                  dataSource: widget.chartData,
                  xValueMapper: (InverterHourlyData data, _) => data.x,
                  yValueMapper: (InverterHourlyData data, _) => data.y2)
            ]),
      ],
    );
  }
}
