import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wateen_energy/widgets/chart_label.dart';

import '../models/testenergy.dart';
import '../utils/AppScale.dart';
import '../utils/colour.dart';
import '../utils/utility.dart';
import 'graph_heading.dart';

class DynamicLineChart extends StatefulWidget {
  final List<List<ChartDataP>> chartData;
  final List<dynamic> labels;

  DynamicLineChart(this.chartData, this.labels);

  @override
  State<DynamicLineChart> createState() => _DynamicLineChartState();
}

class _DynamicLineChartState extends State<DynamicLineChart> {
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
        GraphHeading("Inverter Wise Performance"),

        Utility.getChartLabels(widget.labels),

        SfCartesianChart(
            margin: EdgeInsets.zero,
            enableAxisAnimation: true,
            tooltipBehavior: _tooltipBehavior,
            zoomPanBehavior: _zoomPanBehavior,
            primaryXAxis: CategoryAxis(),
            primaryYAxis:
                NumericAxis(desiredIntervals: 10, minimum: 0, maximum: Utility.getMaxYAxisValue(widget.chartData)),
            enableSideBySideSeriesPlacement: true,
            series: getSeries())

    ]);
  }


  List<LineSeries<ChartDataP, String>> getSeries() {
    List<LineSeries<ChartDataP, String>> lineSeries = [];
    for (int i = 0; i < widget.chartData.length; i++) {
      lineSeries.add(LineSeries(
        color: (i == 0) ? AppColors.darkBlue : AppColors.lightBlue,
        name: "Inverter " + (i+1).toString(),
          dataSource: widget.chartData[i],
          xValueMapper: (ChartDataP data, _) => data.x,
          yValueMapper: (ChartDataP data, _) => data.y));
    }
    return lineSeries;
  }

}
