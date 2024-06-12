import 'package:flutter/material.dart';
import 'package:secondapp/models/dashboardmodel.dart';
import 'package:secondapp/views/customs/overviewcards.dart';

class Cardsgrid extends StatelessWidget {
  final DashboardData data;

  const Cardsgrid({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final List<Overviewcards> cards = [
      Overviewcards(
        title: "Annual Income",
        value: "${data.totalIncomes / 1000000} M",
        percentage: "5.7%",
        isPositive: true,
      ),
      Overviewcards(
        title: "Enrolment",
        value: "${data.totalStudents}",
        percentage: "6.7%",
        isPositive: false,
      ),
      Overviewcards(
        title: "Invoices",
        value: "${data.sumInvoices / 1000}K",
        percentage: "17%",
        isPositive: true,
      ),
      Overviewcards(
        title: "Teaching Staff",
        value: "${data.totalTeachers} people",
        percentage: "12%",
        isPositive: false,
      ),
      Overviewcards(
        title: "Total grades",
        value: "${data.totalGrades}",
        percentage: "12%",
        isPositive: false,
      ),
      Overviewcards(
        title: "Parents",
        value: "${data.totalParents}",
        percentage: "4.5%",
        isPositive: true,
      ),
      Overviewcards(
        title: "Total Users",
        value: "${data.totalUsers}",
        percentage: "6.7%",
        isPositive: true,
      ),
      Overviewcards(
        title: "Learning Areas",
        value: "${data.totalLearningAreas}",
        percentage: "6.7%",
        isPositive: true,
      ),
      
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(), 
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 1.5,
      ),
      itemCount: cards.length,
      itemBuilder: (context, index) {
        return cards[index];
      },
    );
  }
}
