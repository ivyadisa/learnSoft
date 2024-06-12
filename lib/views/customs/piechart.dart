// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:secondapp/constants/constants.dart';

class PieChartSample extends StatelessWidget {
  final int totalStudents;
  final int totalParents;
  final int totalTeachers;

  const PieChartSample({
    Key? key,
    required this.totalStudents,
    required this.totalParents,
    required this.totalTeachers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Student Ratio',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 20,
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(),
            child: PieChart(
              PieChartData(
                sections: showingSections(),
                borderData: FlBorderData(show: false),
                sectionsSpace: 0,
                centerSpaceRadius: 0,
                pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {}),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        ProgressBar(
          value: totalStudents / (totalStudents + totalParents + totalTeachers),
          color: pieChartColor_1,
          title: 'Students',
        ),
        const SizedBox(height: 8),
        ProgressBar(
          value: totalParents / (totalStudents + totalParents + totalTeachers),
          color: pieChartColor_2,
          title: 'Parents',
        ),
        const SizedBox(height: 8),
        ProgressBar(
          value: totalTeachers / (totalStudents + totalParents + totalTeachers),
          color: pieChartColor_3,
          title: 'Teachers',
        ),
      ],
    );
  }

  List<PieChartSectionData> showingSections() {
    final int total = totalStudents + totalParents + totalTeachers;

    return [
      PieChartSectionData(
        color: pieChartColor_1,
        value: (totalStudents / total) * 100,
        title: '',
        radius: 50,
      ),
      PieChartSectionData(
        color: pieChartColor_2,
        value: (totalParents / total) * 100,
        title: '',
        radius: 50,
      ),
      PieChartSectionData(
        color: pieChartColor_3,
        value: (totalTeachers / total) * 100,
        title: '',
        radius: 50,
      ),
    ];
  }
}

class ProgressBar extends StatelessWidget {
  final String? title;
  final double value;
  final Color color;
  final double height;
  final BorderRadius borderRadius;

  const ProgressBar({
    Key? key,
    this.title,
    required this.value,
    required this.color,
    this.height =29,
    this.borderRadius = const BorderRadius.all(Radius.circular(7.0)),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          children: [
            SizedBox(
              height: height,
              width: 200, // Adjusted width
              child: ClipRRect(
                borderRadius: borderRadius,
                child: LinearProgressIndicator(
                  value: value,
                  backgroundColor: Colors.grey[200],
                  color: color,
                  minHeight: 24,
                ),
              ),
            ),
            Positioned.fill(
              child: Center(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Text(
                        // Display percentage
                        '${(value * 100).toStringAsFixed(1)}%',
                        style: TextStyle(
                          color: Colors.black87, 
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      title ?? '',
                      style: TextStyle(
                        color: Colors.black, 
                        fontWeight: FontWeight.bold,
                      ),
                      
                      
                    ),
                    
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
      ],
    );
  }
}
