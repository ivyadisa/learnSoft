import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:secondapp/constants/constants.dart';

import '../../models/dashboardmodel.dart';

class DashGrid extends StatelessWidget {
  final DashboardData data;

  const DashGrid({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var crossAxisCount = screenWidth < 400
        ? 1
        : screenWidth < 600
            ? 2
            : 3;

    // Calculate net income
    var netIncome = data.totalIncomes - data.sumExpenses;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView.count(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          childAspectRatio: 1.5,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            _buildCard(
              title: "Annual Income",
              value: _formatNumber(data.totalIncomes),
              icon: Icons.attach_money,
              color: Colors.green,
              context: context,
            ),
            _buildCard(
              title: "Expenses",
              value: _formatNumber(data.sumExpenses),
              icon: Icons.money_off,
              color: Colors.red,
              context: context,
            ),
            _buildCard(
              title: "Net Income",
              value: _formatNumber(netIncome),
              icon: Icons.compare_arrows,
              color: netIncome >= 0 ? Colors.green : Colors.red,
              context: context,
            ),
            _buildCard(
              title: "Invoices",
              value: _formatNumber(data.sumInvoices),
              icon: Icons.receipt,
              color: Colors.orange,
              context: context,
            ),
            _buildCard(
              title: "Enrolment",
              value: "${data.totalStudents} Students",
              icon: Icons.people,
              color: Colors.blue,
              context: context,
            ),
            _buildCard(
              title: "Teaching Staff",
              value: "${data.totalTeachers} Teachers",
              icon: Icons.school,
              color: Colors.purple,
              context: context,
            ),
            _buildCard(
              title: "Total Grades",
              value: "${data.totalGrades} Grades",
              icon: Icons.grade,
              color: Colors.red,
              context: context,
            ),
            _buildCard(
              title: "Parents",
              value: "${data.totalParents} Parents",
              icon: Icons.family_restroom,
              color: Colors.deepOrange,
              context: context,
            ),
            _buildCard(
              title: "Total Users",
              value: "${data.totalUsers} Users",
              icon: Icons.supervised_user_circle,
              color: Colors.teal,
              context: context,
            ),
            _buildCard(
              title: "Learning Areas",
              value: "${data.totalLearningAreas} Learning Areas",
              icon: Icons.book,
              color: Colors.indigo,
              context: context,
            ),
          ],
        ),
      ),
    );
  }

  String _formatNumber(num value) {
    final formatter = NumberFormat("#,##0.00", "en_US");
    return formatter.format(value);
  }

  Widget _buildCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    required BuildContext context,
  }) {
    var screenWidth = MediaQuery.sizeOf(context).width;
    var screenHeight = MediaQuery.sizeOf(context).height;
    var textScaleFactor = screenWidth < 600 ? 0.8 : 1.0;

    return Container(
      height: screenHeight * 0.4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              icon,
              size: 36,
              color: color,
            ),
            // SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 16 * textScaleFactor,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            // SizedBox(height: 5),
            Container(
              // height: screenHeight * 0.01,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: Offset(0, 1),
                  ),
                ],
                borderRadius: BorderRadius.circular(20),
                color: card_1,
              ),
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 14 * textScaleFactor,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
