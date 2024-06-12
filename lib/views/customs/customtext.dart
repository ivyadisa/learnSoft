//text used in the whole app
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color? textcolor;
  final double? fontsize;
  final FontWeight? fontWeight;

  const CustomText(
      {super.key,
      required this.text,
      this.textcolor,
      this.fontsize,
      this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.justify,
      style: TextStyle(
          color: textcolor, fontSize: fontsize, fontWeight: fontWeight),
    );
  }
}
