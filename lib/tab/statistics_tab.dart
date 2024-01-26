import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tastic/app_provider.dart';

class StatisticsTab extends StatefulWidget {
  const StatisticsTab({Key? key}) : super(key: key);

  @override
  State<StatisticsTab> createState() => _StatisticsTabState();
}

class _StatisticsTabState extends State<StatisticsTab> {
  List<Point> points = [
    Point(x: 1, y: 1),
    Point(x: 2, y: 2),
    Point(x: 3, y: 1),
    Point(x: 4, y: 2),
    Point(x: 5, y: 1),
    Point(x: 6, y: 2),
    Point(x: 7, y: 1),
    Point(x: 8, y: 2),
    Point(x: 9, y: 1),
    Point(x: 10, y: 2),
  ];

  @override
  Widget build(BuildContext context) {
    AppProvider provider = Provider.of(context, listen: true);

    for (var e in provider.notes) {
      print(e.bookId);
    }

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 2,
            child: LineChart(
              LineChartData(
                lineBarsData: provider.books
                    .map(
                      (e) => LineChartBarData(
                        spots: points.map((point) => FlSpot(point.x, Random().nextInt(100).toDouble())).toList(),
                        isCurved: true,
                        barWidth: 2,
                        dotData: const FlDotData(
                          show: false,
                        ),
                        color: Colors.redAccent,
                      ),
                    )
                    .toList(),
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(border: const Border(bottom: BorderSide(), left: BorderSide())),
                titlesData: const FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 25,
                    ),
                  ),
                  leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
              ),
              duration: const Duration(milliseconds: 150),
              curve: Curves.linear,
            ),
          ),
          const Text('asdasd')
        ],
      ),
    );
  }
}

class Point {
  double x;
  double y;

  Point({
    required this.x,
    required this.y,
  });
}
