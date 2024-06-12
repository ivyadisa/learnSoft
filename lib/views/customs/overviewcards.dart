import 'package:flutter/material.dart';
import 'package:secondapp/constants/constants.dart';

class Overviewcards extends StatelessWidget {
  final String title;
  final String percentage;
  final String value;
  final bool isPositive;

  const Overviewcards({
    required this.title,
    required this.percentage,
    required this.value,
    required this.isPositive,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final currentwidth = MediaQuery.of(context).size.width;
    final currentheight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Container(
          width: currentwidth * 0.45,
          height: currentheight * 0.13,
          decoration: BoxDecoration(
            color: secondarycolor,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: const Icon(
            Icons.arrow_forward_ios_rounded,
            color: Colors.white,
          ),
        ),
        Positioned(
          left: 0,
          child: Container(
            width: currentwidth * 0.4,
            height: currentheight * 0.13,
            decoration: const BoxDecoration(
              color: primarycolor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12.0,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      percentage,
                      style: TextStyle(
                        color: isPositive ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(
                      isPositive
                          ? Icons.arrow_outward_outlined
                          : Icons.arrow_downward_sharp,
                      color: isPositive ? Colors.green : Colors.red,
                    ),
                    const SizedBox(width: 4.0),
                  ],
                ),
                const SizedBox(height: 9),
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
