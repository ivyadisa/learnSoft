import 'package:flutter/material.dart';
import 'package:secondapp/constants/constants.dart';

class CustomContainer extends StatelessWidget {
  final Widget child;
  const CustomContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 20),
      height: 283.19,
      width: MediaQuery.of(context).size.width * 0.95, // Adjust width as needed
      decoration: BoxDecoration(
        color: Color.fromRGBO(247, 239, 229, 1),
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.25),
            blurRadius: 4,
            offset: Offset(2, 2),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: backgroundcolor,
            blurRadius: 15,
            offset: Offset(-4, -4),
            spreadRadius: 1,
          ),
        ],
      ),
      child: child,
    );
  }
}

class PieChartContainer extends StatelessWidget {
  final Widget child;
  const PieChartContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 273, // Adjusted height to be the same as the first container
      width: 200, 
      decoration: BoxDecoration(
        color: Color.fromRGBO(247, 239, 229, 1),
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.25),
            blurRadius: 4,
            offset: Offset(2, 2),
            spreadRadius: 0,
          ),
        ],
      ),
      child: child,
    );
  }
}

class IncomeGraphContainer extends StatelessWidget {
  final Widget child;
  const IncomeGraphContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20),
      height: 283.19,
       

      width: MediaQuery.sizeOf(context).width * 0.95,
      decoration: BoxDecoration(
        color: Color.fromRGBO(247, 239, 229, 1),
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.25),
            blurRadius: 4,
            offset: Offset(2, 2),
            spreadRadius: 0,
          ),
        ],
      ),
      child: child,
    );
  }
}
