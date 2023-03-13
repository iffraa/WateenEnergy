import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../models/testenergy.dart';
import '../utils/AppScale.dart';
import '../utils/chart_visibility_cn.dart';
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
  late Legend _legend;

  @override
  void initState() {
    super.initState();
    _legend = Legend(
      isVisible: true,
      toggleSeriesVisibility: true,
      position: LegendPosition.top,
      orientation: LegendItemOrientation.vertical,
      // overflowMode: LegendItemOverflowMode.scroll,
      width: '200%',height: '60%',
    );
    _tooltipBehavior = Utility.getToolTipStyle();
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

        Consumer<ChartVisibilityCN>(
            builder: (context, chartVisibilityCN, child) {
          return Center(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 45.h,
              child: SfCartesianChart(
                  tooltipBehavior: _tooltipBehavior,
                  enableAxisAnimation: true,
                  //margin: EdgeInsets.only(top: 2.h),
                  primaryXAxis: CategoryAxis(
                    labelRotation: (widget.chartData.length < 5)  ?  360 : 270,
                  ),
                  legend: _legend,
                  primaryYAxis: NumericAxis(
                      desiredIntervals: 4, minimum: 0, maximum: 150),
                  enableSideBySideSeriesPlacement: true,
                  series: getSeries(chartVisibilityCN)),
            ),
          );
        }),
      ],
    );
  }

  void updateChartVisibility(ChartVisibilityCN chartVisibilityCN,
      List<ColumnSeries<ChartDataP, String>> lineSeries) {
    Map<String, bool> chartVisibilityData = chartVisibilityCN.lblMap;
    for (int i = 0; i < lineSeries.length; i++) {
      ColumnSeries<ChartDataP, String> item = lineSeries[i];
      String? label = item.name;
      bool? isVisible = chartVisibilityData[label];

      if (chartVisibilityData.containsKey(label)) {
        print(label);
        if (!isVisible!) {
          print(label! + " removing visibility");
          print(item.isTrackVisible!.toString() + "  = item visibility");

          lineSeries.remove(item);
        }
      }
    }
  }

  List<ColumnSeries<ChartDataP, String>> getSeries(
      ChartVisibilityCN chartVisibilityCN) {
    List<ColumnSeries<ChartDataP, String>> lineSeries = [];
    for (int i = 0; i < widget.chartData.length; i++) {
      lineSeries.add(ColumnSeries(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(2.h), topLeft: Radius.circular(2.h)),
          color: (i == 0) ? AppColors.darkBlue : AppColors.yellow,
          name: widget.labels[i].toString(),
          dataSource: widget.chartData[i],
          xValueMapper: (ChartDataP data, _) => data.x,
          yValueMapper: (ChartDataP data, _) => data.y));
    }

    updateChartVisibility(chartVisibilityCN, lineSeries);

    return lineSeries;
  }
}
