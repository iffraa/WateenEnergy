import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../models/testenergy.dart';
import '../utils/AppScale.dart';
import '../utils/colour.dart';

class PieChart extends StatefulWidget {
  final List<MountData> chartData;
  final List mountWiseData;

  PieChart(this.chartData, this.mountWiseData);

  @override
  State<PieChart> createState() => _PieChartState();
}

class _PieChartState extends State<PieChart> {
  @override
  Widget build(BuildContext context) {
    String selectedType = "Industrial";
    int index = 0;
    AppScale _scale = AppScale(context);
    final List<ChartDataPie> chartData = [
      ChartDataPie('David', 25.0, Colors.green),
      ChartDataPie('Steve', 38, Colors.black54),
      ChartDataPie('Jack', 34, Colors.red),
      ChartDataPie('David', 25.0, Colors.blueAccent),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SfCircularChart(
            title: ChartTitle(text: 'Mount Wise Installation'),
            legend: Legend(isVisible: true),
            //primaryXAxis: CategoryAxis(),
            series: <CircularSeries>[
              // Render pie chart
              PieSeries<MountData, String>(
                dataLabelSettings: DataLabelSettings(isVisible: true),
                dataSource: this.widget.chartData,
                xValueMapper: (MountData data, _) => data.x,
                yValueMapper: (MountData data, _) => data.y,
                //map Color for each dataPoint datasource.
                pointColorMapper: (MountData data, _) => data.color,
              )
            ]),
        Text(selectedType),
        Column(
          children: [
            IconButton(
              iconSize: 3.h,
              icon: new Icon(Icons.arrow_circle_up),
              color: Colors.pink,
              onPressed: () {
                if (index > 0) {
                  index--;
                }
                List<dynamic> values = widget.mountWiseData[index];
                setState(() {
                  List<dynamic> values = widget.mountWiseData[3];

                //  selectedType =
                //  formChartData(values);
                });
              },
            ),
            SizedBox(
              height: 2.h,
            ),
            IconButton(
              iconSize: 3.h,
              icon: new Icon(Icons.arrow_circle_down),
              color: Colors.pink,
              onPressed: () {},
            ),
          ],
        )
      ],
    );
  }

  void formChartData(List<dynamic> values)
  {
    List<dynamic> mountNames = widget.mountWiseData[4];

    for (int j = 0; j < values.length; j++) {
      int x = values[j];
      String y1 = mountNames[j];
      Color color = Colors.green;
      if(j == 0)
      {
        color = Colors.red;
      }
      else if (j == 1){
        color = Colors.yellow;
      }
      MountData data = MountData( y1,x, color);
      widget.chartData.add(data);
    }


  }
}
