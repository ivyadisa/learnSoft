import 'package:flutter/material.dart';
import 'package:secondapp/constants/constants.dart';
// import 'package:secondapp/views/customs/custombutton.dart';
import 'package:secondapp/views/customs/customtext.dart';
// import 'package:secondapp/views/customs/customtextbutton.dart';

class FirstPage extends StatelessWidget {
  final String heading;
  final String text;
  final String image;
  const FirstPage(
      {super.key,
      required this.heading,
      required this.text,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 120),
      child: SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              image,
              height: 356,
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              children: [
                CustomText(
                  text: heading,
                  textcolor: secondarycolor,
                  fontWeight: FontWeight.bold,
                  fontsize: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: CustomText(
                    text: text,
                    fontWeight: FontWeight.w500,
                    fontsize: 16,
                    textcolor: primarycolor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
