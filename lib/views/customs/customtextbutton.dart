//custom textbutton in the app
import 'package:flutter/material.dart';
import 'package:secondapp/views/customs/customtext.dart';

class CustomTextbutton extends StatelessWidget {
  final String label;
  final Color? color;
  final double? size;
  final VoidCallback? action;
  const CustomTextbutton(
      {super.key, required this.label, this.color, this.size, this.action});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: action,
        child: CustomText(
          text: label,
          fontsize: size,
          textcolor: color,
          fontWeight: FontWeight.bold,
        ));
  }
}
