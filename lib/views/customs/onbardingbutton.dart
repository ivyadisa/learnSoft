//button customed for the on boarding screens
import 'package:flutter/material.dart';
import 'package:secondapp/views/customs/customtext.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback? action;
  final Color colorbutton;
  final Color? textcolor;
  final IconData? icon;
  final double size;

  const CustomButton(
      {super.key,
      required this.label,
      this.action,
      required this.colorbutton,
      required this.size,
      this.icon,
      this.textcolor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(colorbutton),
            shape:MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            )),
            fixedSize: MaterialStateProperty.all<Size>(Size(size, 40))),
        onPressed: action,
        child: (label != "BACK")
            ? Row(
                children: [
                  CustomText(
                    text: label,
                    textcolor: textcolor,
                    fontsize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Icon(
                    icon,
                    color: textcolor!.withOpacity(0.3),
                  ),
                  Icon(
                    icon,
                    color: textcolor!.withOpacity(0.5),
                  ),
                  Icon(icon, color: textcolor),
                ],
              )
            : Row(
                children: [
                  Icon(
                    icon,
                    color: textcolor,
                  ),
                  Icon(
                    icon,
                    color: textcolor!.withOpacity(0.5),
                  ),
                  Icon(icon, color: textcolor!.withOpacity(0.3)),
                  CustomText(
                    text: label,
                    textcolor: textcolor,
                    fontsize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ));
  }
}
