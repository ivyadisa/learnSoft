//this is the button to be used in the app
import 'package:flutter/material.dart';
import 'package:secondapp/constants/constants.dart';

import 'package:secondapp/views/customs/customtext.dart';

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? action;
  final Color? textcolor;
  final Color color;
  final double size;
  

  const AppButton(
      {super.key,
      required this.label,
      this.action,
      this.textcolor,
      this.color = secondarycolor,
      this.size = 280});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(color),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            )),
            fixedSize: MaterialStateProperty.all<Size>(Size(size, 40))),
        onPressed: action,
        child: CustomText(
          text: label,
          textcolor: whitecolor,
          fontsize: 16,
          fontWeight: FontWeight.bold,
        ));
  }
}
