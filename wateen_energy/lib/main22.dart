import 'dart:math';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<List<ChartData>> data = [];

  @override
  void initState() {
    data = getDataList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SfCartesianChart(
          series: getSeries(),
        ));
  }

  List<LineSeries<ChartData, num>> getSeries() {
    List<LineSeries<ChartData, num>> lineSeries = [];
    for (int i = 0; i < data.length; i++) {
      lineSeries.add(LineSeries(
          dataSource: data[i],
          xValueMapper: (ChartData data, _) => data.x,
          yValueMapper: (ChartData data, _) => data.y));
    }
    return lineSeries;
  }

  List<List<ChartData>> getDataList() {
    final List<List<ChartData>> data = [];

    for (int i = 0; i < 3; i++) {
      final List<ChartData> chartData = [];
      for (int j = 0; j < 10; j++) {
        chartData.add(ChartData(j + 1, _getRandomInt(10, 50)));
      }
      data.add(chartData);
    }
    return data;
  }

  int _getRandomInt(int min, int max) {
    final Random _random = Random();
    return min + _random.nextInt(max - min);
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final num x;
  final num y;
}
