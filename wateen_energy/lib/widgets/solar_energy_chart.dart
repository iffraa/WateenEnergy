import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wateen_energy/utils/strings.dart';
import 'package:wateen_energy/utils/utility.dart';
import 'package:wateen_energy/widgets/graph_heading.dart';

import '../models/testenergy.dart';
import '../utils/AppScale.dart';
import '../utils/colour.dart';

class SolarEnergyChart extends StatefulWidget {
  final List<SolarData> chartData;

  SolarEnergyChart(this.chartData);

  @override
  State<SolarEnergyChart> createState() => _SolarEnergyChartState();
}

class _SolarEnergyChartState extends State<SolarEnergyChart> {
  late ZoomPanBehavior _zoomPanBehavior;
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    super.initState();
    _tooltipBehavior = Utility.getToolTipStyle();
    _zoomPanBehavior = ZoomPanBehavior(
      enablePinching: true,
      enableDoubleTapZooming: true,
      zoomMode: ZoomMode.xy,
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
        GraphHeading("Actual Solar VS Expected Solar"),
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
              width: 1.5.h,
            ),
            Text(
              "Actual Generation",
              style: TextStyle(fontSize: _scale.axisHeading),
              textAlign: TextAlign.start,
            ),
            SizedBox(
              width: 3.h,
            ),
            Container(
              height: 0.8.h,
              width: 4.h,
              decoration: BoxDecoration(
                  color: AppColors.yellow,
                  borderRadius: BorderRadius.all(Radius.circular(1.h))),
            ),
            SizedBox(
              width: 1.5.h,
            ),
            Expanded(
              child: Text(
                "Expected Generation",
                style: TextStyle(fontSize: _scale.axisHeading),
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 2.h,
        ),
        SfCartesianChart(
            margin: EdgeInsets.zero,
            tooltipBehavior: _tooltipBehavior,
            enableAxisAnimation: true,
            zoomPanBehavior: _zoomPanBehavior,
            primaryXAxis: CategoryAxis(
                title: AxisTitle(
                    text: Strings.time,
                    textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: _scale.axisHeading))),
            primaryYAxis: NumericAxis(
                title: AxisTitle(
                    text: Strings.energy,
                    textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: _scale.axisHeading)),
                desiredIntervals: 10,
                minimum: 0,
                maximum: 750),
            series: <ChartSeries>[
              AreaSeries<SolarData, String>(
                name: Strings.solarHourly,
                  color: AppColors.yellow.withOpacity(0.5),
                  borderColor: Colors.lightBlue,borderWidth: 0.2.h,
                  dataSource: widget.chartData,
                  xValueMapper: (SolarData data, _) => data.x,
                  yValueMapper: (SolarData data, _) => data.y1),
              LineSeries<SolarData, String>(
                  name: "p90",
                  color: Colors.indigo,
                  dataSource: widget.chartData,
                  xValueMapper: (SolarData data, _) => data.x,
                  yValueMapper: (SolarData data, _) => data.y2
              ),
              LineSeries<SolarData, String>(
                  name: "p50",
                  color: Colors.red,
                  dataSource: widget.chartData,
                  xValueMapper: (SolarData data, _) => data.x,
                  yValueMapper: (SolarData data, _) => data.y3
              ),
              LineSeries<SolarData, String>(
                  name: "Solar Output",
                  color: Colors.limeAccent,
                  dataSource: widget.chartData,
                  xValueMapper: (SolarData data, _) => data.x,
                  yValueMapper: (SolarData data, _) => data.y4
              ),
            ]),
      ],
    );
  }
}
