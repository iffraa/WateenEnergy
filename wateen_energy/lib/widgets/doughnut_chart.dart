import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../models/testenergy.dart';
import '../utils/AppScale.dart';
import '../utils/colour.dart';

class DoughnutChart extends StatelessWidget {

  const DoughnutChart()
  ;

  @override
  Widget build(BuildContext context) {
    AppScale _scale = AppScale(context);
    final List<ChartDataPie> chartData = [
      ChartDataPie('David', 25.0, Colors.green),
      ChartDataPie('Steve', 38, Colors.black54),
      ChartDataPie('Jack', 34, Colors.red),
      ChartDataPie('David', 25.0, Colors.blueAccent),
    ];

    return SfCircularChart(
        legend: Legend(isVisible: true),

        series: <CircularSeries>[

          // Renders doughnut chart
          DoughnutSeries<ChartDataPie, String>(
              dataLabelSettings: DataLabelSettings(isVisible: true),
              dataSource: chartData,
              pointColorMapper:(ChartDataPie data,  _) => data.color,
              xValueMapper: (ChartDataPie data, _) => data.x,
              yValueMapper: (ChartDataPie data, _) => data.y
          )
        ]
    );
  }

}
