// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import the intl package


import '../../constants/constants.dart';

class IncomeGraph extends StatelessWidget {
  final int totalIncomes;
  final int sumExpenses;

  const IncomeGraph({
    Key? key,
    required this.totalIncomes,
    required this.sumExpenses,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Calculate the percentage of income compared to expenses
    double percentage = totalIncomes / (totalIncomes + sumExpenses);

    // Create NumberFormat instances for comma-separated formatting
    NumberFormat currencyFormat =
        NumberFormat.currency(locale: 'en_US', symbol: '');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Income & Expenses Comparison',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 100,
                  height: 100,
                  child: CircularProgressIndicator(
                    value: percentage,
                    strokeWidth: 15,
                    backgroundColor: secondarycolor,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.teal),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.person,
                      color: Colors.red,
                    ),
                    SizedBox(height: 5),
                    Text(
                      '${(percentage * 100).toStringAsFixed(0)}%',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Total Income:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  '${currencyFormat.format(totalIncomes.toDouble())}',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: secondarycolor),
                ),
                SizedBox(height: 10),
                Text(
                  'Total Expenses:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  '${currencyFormat.format(sumExpenses.toDouble())}',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: secondarycolor),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.teal[800],
              ),
            ),
            const SizedBox(width: 5),
            const Text('Income'),
            const SizedBox(width: 20),
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: secondarycolor,
              ),
            ),
            const SizedBox(width: 5),
            const Text('Expenses'),
          ],
        ),
      ],
    );
  }
}
