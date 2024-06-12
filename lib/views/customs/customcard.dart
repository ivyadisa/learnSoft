import 'package:flutter/material.dart';
import 'package:secondapp/constants/constants.dart';
import 'package:secondapp/views/customs/customtext.dart';

PageController page = PageController();

class DashboardCard extends StatelessWidget {
  const DashboardCard(
      {super.key,
      this.ontap,
      this.imagePath = "insert",
      required this.label,
      this.heading = "not mentioned",
      required this.color,
      this.showTrailing = true});

  final VoidCallback? ontap;
  final String imagePath;
  final String label;
  final String heading;
  final Color color;
  final bool showTrailing;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 6,
        color: color,
        child: ListTile(
          leading: Image.asset(
            imagePath,
            height: 100,
            width: 100,
          ),
          title: showTrailing
              ? Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CustomText(
                    text: heading,
                    fontWeight: FontWeight.w400,
                    fontsize: 16,
                    textcolor: whitecolor,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60.0),
                  child: CustomText(
                    text: heading,
                    fontWeight: FontWeight.w400,
                    fontsize: 18,
                    textcolor: whitecolor,
                  ),
                ),
          subtitle: showTrailing
              ? Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CustomText(
                    text: label,
                    fontsize: 12,
                    fontWeight: FontWeight.w200,
                    textcolor: whitecolor,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60.0),
                  child: CustomText(
                    text: label,
                    fontsize: 14,
                    fontWeight: FontWeight.w200,
                    textcolor: whitecolor,
                  ),
                ),
          trailing: showTrailing // Conditionally display the trailing widget
              ? Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: whitecolor,
                  ),
                  child: const Icon(Icons.arrow_forward),
                )
              : null,
        ));
  }
}
