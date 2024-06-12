import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:secondapp/constants/constants.dart';
import 'package:secondapp/services/api.dart';

class FeesPaymentChart extends StatefulWidget {
  const FeesPaymentChart({super.key});

  @override
  _FeesPaymentChartState createState() => _FeesPaymentChartState();
}

class _FeesPaymentChartState extends State<FeesPaymentChart> {
  String selectedYear = 'Last year';
  final List<String> years = ['Last year', '2022', '2021', '2020', '2019'];
  Map<String, dynamic>? monthlyFeePayments;

  @override
  void initState() {
    super.initState();
    fetchMonthlyFeePayments();
  }

  Future<void> fetchMonthlyFeePayments() async {
    ApiService apiService = ApiService();
    try {
      final data = await apiService.fetchData();
      setState(() {
        monthlyFeePayments = data['monthlyFeePayments'];
      });
    } catch (e) {
      print('Failed to load fee payment data: $e');
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300, // Adjust height as needed
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: backgroundcolor,
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  const Text(
                    'Fees payment',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  DropdownButton<String>(
                    value: selectedYear,
                    items: years.map((String year) {
                      return DropdownMenuItem<String>(
                        value: year,
                        child: Text(year),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedYear = newValue!;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              monthlyFeePayments == null
                  ? const Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 666,
                            height: 150,
                            child: BarChart(
                              BarChartData(
                                titlesData: FlTitlesData(
                                  leftTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      interval:
                                          10, // Set y-axis intervals to 10
                                      getTitlesWidget: (value, meta) {
                                        const style = TextStyle(
                                          color: primarycolor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        );
                                        return Text(value.toInt().toString(),
                                            style: style);
                                      },
                                      reservedSize: 40,
                                    ),
                                  ),
                                  bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      interval: 1,
                                      getTitlesWidget: (value, meta) {
                                        const style = TextStyle(
                                          color: primarycolor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        );
                                        List<String> months = [
                                          'Jan',
                                          'Feb',
                                          'Mar',
                                          'Apr',
                                          'May',
                                          'Jun',
                                          'Jul',
                                          'Aug',
                                          'Sep',
                                          'Oct',
                                          'Nov',
                                          'Dec'
                                        ];
                                        return SideTitleWidget(
                                          axisSide: meta.axisSide,
                                          space: 10,
                                          child: Text(months[value.toInt()],
                                              style: style),
                                        );
                                      },
                                      reservedSize: 40,
                                    ),
                                  ),
                                  topTitles: const AxisTitles(
                                    sideTitles: SideTitles(showTitles: false),
                                  ),
                                  rightTitles: const AxisTitles(
                                    sideTitles: SideTitles(showTitles: false),
                                  ),
                                ),
                                borderData: FlBorderData(
                                  show: false,
                                ),
                                gridData: const FlGridData(
                                  show: false,
                                ),
                                barGroups: List.generate(12, (index) {
                                  String monthKey = 'month_${index + 1}';
                                  double value =
                                      (monthlyFeePayments![monthKey] ?? 0)
                                          .toDouble();
                                  return BarChartGroupData(
                                    x: index,
                                    barRods: [
                                      BarChartRodData(
                                        toY: value /
                                            100000, // Adjust scaling as needed
                                        color: primarycolor,
                                        width: 20,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ],
                                  );
                                }),
                                minY: 0,
                                maxY: ((monthlyFeePayments!.values.reduce(
                                                    (a, b) => a > b ? a : b) /
                                                100000) /
                                            10)
                                        .ceil() *
                                    10.0, // Adjust the max value to fit the y-axis intervals of 10
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
